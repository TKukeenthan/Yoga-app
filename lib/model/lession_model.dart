class Lesson {
  final String id;
  final String title;
  final String description;
  final String video;
  final String sessionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String videoUrl;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.video,
    required this.sessionId,
    required this.createdAt,
    required this.updatedAt,
    required this.videoUrl,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      video: json['video'],
      sessionId: json['sessionId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'video': video,
      'sessionId': sessionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'videoUrl': videoUrl,
    };
  }
}
