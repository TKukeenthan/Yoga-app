import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogaapp/provider/home_provider.dart';
import 'package:yogaapp/provider/lession_provider.dart';
import 'package:yogaapp/provider/login_provider.dart';
import 'package:yogaapp/provider/register_provider.dart';

import 'constents/routers.dart';
import 'screens/auth/wellcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<RegisterProvider>(create: (_) => RegisterProvider()),
    ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ChangeNotifierProvider<LessonProvider>(create: (_) => LessonProvider(_)),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token = '';
  Future<void> instData() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    print(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    instData();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoga - app',
      initialRoute:
          token != '' || token != null || token.isNotEmpty ? '/home' : '/',
      routes: routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: 'Intel',
      ),
    );
  }
}
