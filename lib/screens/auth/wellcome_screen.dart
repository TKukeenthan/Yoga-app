import 'package:flutter/material.dart';
import 'package:yogaapp/constents/app_colors.dart';
import 'package:yogaapp/constents/app_size.dart';
import 'package:yogaapp/widget/_reusable_button.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffDAE2EB),
        body: SafeArea(
          child: Stack(
            children: [
              buildBackroundImageContainer(context),
              buildTitle(context),
              buildButtons(context)
            ],
          ),
        ));
  }

  Widget buildTitle(BuildContext context) {
    return Positioned(
        top: screenHeight(76, context),
        left: screenWidth(33, context),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth(308, context),
              child: Center(
                child: Text(
                  'keepyoga',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: baseGray),
                ),
              ),
            ),
            h16,
            SizedBox(
              width: screenWidth(327, context),
              height: screenHeight(72, context),
              child: Center(
                child: Text(
                  'Practice yoga whenever you want.',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: baseBlack,
                      height: 0),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ));
  }

  Widget buildButtons(BuildContext context) {
    return Positioned(
        bottom: screenHeight(30, context),
        left: 24,
        child: Column(
          children: [
            ReusableButton(
              text: 'Get started',
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              color: baseWhite,
              textColor: baseBlack,
            ),
            h8,
            ReusableButton(
              text: 'Log In',
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        ));
  }

  Widget buildBackroundImageContainer(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: screenHeight(667, context),
        width: screenWidth(375, context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/welcome-page.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
