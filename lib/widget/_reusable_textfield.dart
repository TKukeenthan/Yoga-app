import 'package:flutter/material.dart';

import 'package:yogaapp/constents/app_colors.dart';
import 'package:yogaapp/constents/app_size.dart';

class CustomTextField extends StatelessWidget {
  final String titleText;

  final TextEditingController controller;
  final bool isPassword;
  final double width;
  final TextInputType textInputType;

  const CustomTextField(
      {Key? key,
      required this.titleText,
      required this.controller,
      this.isPassword = false,
      this.width = 327,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth(width, context),
          height: screenHeight(48, context),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.start,
            keyboardType: textInputType,
            obscureText: isPassword,
            style: TextStyle(
              color: textColor1,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              labelText: titleText,
              labelStyle: TextStyle(
                color: textColor2,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
