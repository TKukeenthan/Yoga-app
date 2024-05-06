import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yogaapp/constents/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogaapp/constents/app_size.dart';
import 'package:yogaapp/model/session_model.dart';
import 'package:yogaapp/provider/home_provider.dart';
import 'package:yogaapp/screens/lesson/lesson_screen.dart';

import '../../app_service/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildAppBar(context),
                buildCategoryRaw(context, provider),
                buildBasicYogaConainer(context),
                topSesionList(context, provider.sessionList)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildBasicYogaConainer(BuildContext context) {
    return Container(
      width: screenWidth(339, context),
      decoration: BoxDecoration(
          color: Color.fromARGB(187, 108, 78, 255),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Yoga',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                SizedBox(
                  width: screenWidth(250, context),
                  height: screenHeight(48, context),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Good Morning',
            style: TextStyle(
                color: baseBlack, fontSize: 24, fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                child: Image.asset('assets/images/Images_ Avatars.png'),
              ),
              w8,
              GestureDetector(
                onTap: () async {
                  await logoutUser().then((value) {
                    Navigator.popAndPushNamed(context, '/');
                  });
                },
                child: SvgPicture.asset(
                  'assets/svg/ant-design_poweroff-outlined.svg',
                  height: screenHeight(32, context),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildCategoryCard(
      BuildContext context, SessionCategory category, String image) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            Container(
              width: screenWidth(88, context),
              height: screenHeight(88, context),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
              ),
            ),
            Text(category.name)
          ],
        ),
      ),
    );
  }

  Widget buildCategoryRaw(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < provider.category.length; i++)
              buildCategoryCard(
                  context, provider.category[i], provider.categoryImages[i])
          ],
        ),
      ),
    );
  }

  Widget sesionCard(BuildContext context, Session session) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => LessonScreen(session: session)));
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: screenWidth(335, context),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  width: screenWidth(75, context),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(session.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                w16,
                SizedBox(
                  width: screenWidth(200, context),
                  height: screenHeight(62, context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.title,
                        maxLines: 1,
                        style: TextStyle(
                            color: baseBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      h8,
                      Text(
                        '${session.lessons.length} lessons',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                      h8,
                      FittedBox(
                        child: Row(
                          children: [
                            Text(
                              'By ${session.instructor}',
                              style: TextStyle(
                                  color: textColor2,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            CircleAvatar(
                              radius: 1.5,
                              backgroundColor: textColor2,
                            ),
                            Text(
                              'All Level',
                              style: TextStyle(
                                  color: textColor2,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            CircleAvatar(
                              radius: 1.5,
                              backgroundColor: textColor2,
                            ),
                            SvgPicture.asset(
                              'assets/svg/star.svg',
                              height: 13,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(
                                  color: textColor2,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topSesionList(BuildContext context, List<Session> sessonList) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Sessions',
            style: TextStyle(
                color: baseBlack, fontSize: 24, fontWeight: FontWeight.w700),
          ),
          h16,
          for (int i = 0; i < sessonList.length; i++)
            if (sessonList[i].lessons.length > 0)
              sesionCard(context, sessonList[i])
        ],
      ),
    );
  }
}
