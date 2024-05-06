import 'package:flutter/material.dart';

SizedBox h8 = const SizedBox(
  height: 8,
);
SizedBox h16 = const SizedBox(
  height: 16,
);
SizedBox h24 = const SizedBox(
  height: 24,
);

SizedBox w8 = const SizedBox(
  width: 8,
);
SizedBox w4 = const SizedBox(
  width: 4,
);
SizedBox w16 = const SizedBox(
  width: 16,
);

double screenWidth(double size, BuildContext context) {
  return MediaQuery.of(context).size.width / 375 * size;
}

double screenHeight(double size, BuildContext context) {
  return MediaQuery.of(context).size.height / 812 * size;
}
