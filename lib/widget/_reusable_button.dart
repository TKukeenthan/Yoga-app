import 'package:flutter/material.dart';
import 'package:yogaapp/constents/app_colors.dart';
import 'package:yogaapp/constents/app_size.dart';

class ReusableButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String text;
  final Function() onTap;
  const ReusableButton(
      {super.key,
      this.color,
      this.textColor,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth(327, context),
        height: screenHeight(48, context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: color ?? buttonColor),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: textColor ?? baseWhite,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
