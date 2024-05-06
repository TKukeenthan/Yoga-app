import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yogaapp/constents/app_colors.dart';
import 'package:yogaapp/constents/app_size.dart';
import 'package:yogaapp/model/lession_model.dart';
import 'package:yogaapp/model/session_model.dart';
import 'package:yogaapp/provider/lession_provider.dart';

import 'lession_video_player.dart';

class LessonScreen extends StatelessWidget {
  final Session session;
  const LessonScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight(812, context),
          child: Stack(
            children: [
              _topImageContainer(context),
              _appBar(context),
              _bottomContainer(context)
            ],
          ),
        ),
      ),
    );
  }

  Positioned _appBar(BuildContext context) {
    return Positioned(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: baseWhite,
              radius: 24,
              child: Icon(Icons.close),
            ),
          )
        ],
      ),
    ));
  }

  Positioned _bottomContainer(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: screenHeight(438, context),
          width: screenWidth(375, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              color: baseWhite),
          child: Column(
            children: [
              h8,
              SvgPicture.asset('assets/svg/rectangle.svg'),
              h16,
              SizedBox(
                width: screenWidth(327, context),
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        session.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      w16,
                      Text(
                        '${session.lessons.length} Lessons',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textColor2),
                      ),
                    ],
                  ),
                ),
              ),
              h16,
              for (int i = 0; i < session.lessons.length; i++)
                lessonCard(context, session.lessons[i])
            ],
          ),
        ));
  }

  Widget lessonCard(BuildContext context, Lesson lesson) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => LessionVideoPlayer(
                      lesson: lesson,
                    )));
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Container(
          width: screenWidth(375, context),
          decoration: BoxDecoration(color: baseWhite),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: baseWhite,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                        'assets/png/lession-icon.png',
                      ))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: textColor1),
                    ),
                    Text(
                      lesson.title,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: textColor2),
                    ),
                  ],
                ),
                SvgPicture.asset('assets/svg/Vector (2).svg')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _topImageContainer(BuildContext context) {
    return Positioned(
      child: Container(
        width: double.infinity,
        height: screenHeight(527, context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(session.imageUrl), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
