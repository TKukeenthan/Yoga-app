import 'package:flutter/material.dart';
import 'package:yogaapp/screens/auth/register/register_screen.dart';
import 'package:yogaapp/screens/auth/wellcome_screen.dart';
import 'package:yogaapp/screens/home/home_screen.dart';
import 'package:yogaapp/screens/lesson/lesson_screen.dart';

import '../screens/auth/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const WellcomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const HomeScreen(),
};
