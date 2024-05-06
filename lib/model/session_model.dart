import 'lession_model.dart';

class Session {
  final String id;
  final String title;
  final String instructor;
  final String category;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imageUrl;
  final List<Lesson> lessons;

  Session({
    required this.id,
    required this.title,
    required this.instructor,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.lessons,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    List<Lesson> lessons = [];
    if (json['lessons'] != null) {
      lessons = List<Lesson>.from(
          json['lessons'].map((lesson) => Lesson.fromJson(lesson)));
    }

    return Session(
      id: json['id'],
      title: json['title'],
      instructor: json['instructor'],
      category: json['category'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      imageUrl: json['imageUrl'],
      lessons: lessons,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instructor': instructor,
      'category': category,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }

  static List<SessionCategory> getSessionCategories(List<Session> sessions) {
    Map<String, List<Session>> groupedSessions = {};
    sessions.forEach((session) {
      if (!groupedSessions.containsKey(session.category)) {
        groupedSessions[session.category] = [];
      }
      groupedSessions[session.category]!.add(session);
    });

    List<SessionCategory> sessionCategories = [];
    groupedSessions.forEach((category, sessions) {
      String image = sessions.isNotEmpty ? sessions.first.imageUrl : '';
      List<String> sessionIds = sessions.map((session) => session.id).toList();
      sessionCategories.add(SessionCategory(
          name: category, image: image, sessionIds: sessionIds));
    });

    return sessionCategories;
  }
}

class SessionCategory {
  final String name;
  final String image;
  final List<String> sessionIds;
  SessionCategory({
    required this.name,
    required this.image,
    required this.sessionIds,
  });
}
