import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yogaapp/constents/app_colors.dart';
import 'package:yogaapp/constents/app_size.dart';
import 'package:yogaapp/provider/login_provider.dart';
import 'package:yogaapp/widget/_reusable_button.dart';
import 'package:yogaapp/widget/_reusable_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildImageContainer(context),
                h16,
                CustomTextField(
                    titleText: 'Email', controller: provider.emailController),
                h16,
                CustomTextField(
                  titleText: 'password',
                  controller: provider.passwordController,
                  isPassword: true,
                ),
                h16,
                _buildForgotPassword(),
                h24,
                //By continuing, you agree to our Terms of Service and Privacy Policy.
                buildTermAndPrivacyNote(context),
                h16,
                if (provider.isErrorShow)
                  SizedBox(
                    width: screenWidth(327, context),
                    child: Center(
                      child: Text(
                        provider.errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ReusableButton(
                    text: 'Log In',
                    onTap: () async {
                      await provider.singin(context);
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildTermAndPrivacyNote(BuildContext context) {
    return SizedBox(
      width: screenWidth(327, context),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'By continuing, you agree to our',
              style: TextStyle(
                color: baseBlack,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(
                color: baseBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                color: basePurple,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(
              text: ' and ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: basePurple,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {},
          child: Text(
            'Forgot password?',
            style: TextStyle(
                color: basePurple, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget buildImageContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight(417, context),
          width: screenWidth(375, context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login-cover.png'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                  colors: [Color.fromARGB(0, 23, 10, 90), Colors.white60])),
        ),
        Container(
          height: screenHeight(417, context),
          width: screenWidth(375, context),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(0, 23, 10, 90),
                Colors.white60,
                Colors.white60
              ])),
        ),
      ],
    );
  }
}
