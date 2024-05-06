import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yogaapp/constents/app_colors.dart';
import 'package:yogaapp/constents/app_size.dart';
import 'package:yogaapp/provider/register_provider.dart';
import 'package:yogaapp/widget/_reusable_button.dart';
import 'package:yogaapp/widget/_reusable_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      h16,
                      Text(
                        'Registration',
                        style: TextStyle(
                            color: baseBlack,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        'Create your account',
                        style: TextStyle(
                            color: Color(0xff090A0A),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      h16,
                      CustomTextField(
                          titleText: 'Email',
                          controller: provider.emailController),
                      h16,
                      CustomTextField(
                          titleText: 'User name',
                          controller: provider.userNameController),
                      h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildGenderContainer(context, provider),
                          CustomTextField(
                            titleText: 'age',
                            controller: provider.ageController,
                            width: 154,
                            textInputType: TextInputType.number,
                          ),
                        ],
                      ),
                      h16,
                      CustomTextField(
                        titleText: 'password',
                        controller: provider.passwordController,
                        isPassword: true,
                      ),
                      h16,
                      CustomTextField(
                        titleText: 'confirm password',
                        controller: provider.confirmPasswordController,
                        isPassword: true,
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: screenHeight(270, context)),
                        child: Column(
                          children: [
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
                                text: 'Create Account',
                                onTap: () async {
                                  await provider.singUp(context);
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildGenderContainer(BuildContext context, RegisterProvider provider) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'male',
          child: Text('Male'),
        ),
        const PopupMenuItem<String>(
          value: 'female',
          child: Text('Female'),
        ),
        const PopupMenuItem<String>(
          value: 'other',
          child: Text('Other'),
        ),
      ],
      onSelected: (value) {
        // Handle the selected gender here
        provider.updateGender(value);
      },
      child: Container(
        width: screenWidth(154, context),
        height: screenHeight(48, context),
        decoration: BoxDecoration(
          border: Border.all(color: textColor2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight(12, context), left: 12),
          child: Text(
            provider.gender,
            style: TextStyle(
              color: textColor2,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
