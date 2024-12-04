import 'package:flutter/material.dart';
import 'package:flutter_application_1/challenge/ui_challenge_3.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/detail_popular.dart';
import 'package:flutter_application_1/screens/popular_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/settings/global_values.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: GlobalValues.bandThemeDark,
      builder: (context, value,_) {
        return MaterialApp(
          theme: value ? ThemeData.dark() : ThemeData.light(),
          title: 'Material App',
          routes: {
            '/dash': (context) => const DashboardScreen(),
            '/chal': (context) => UiChallenge3(),
            '/movie': (context) => const PopularScreen(),
            '/detail': (context) => const DetailPopular(),
          },
          home: const SplashScreen()
        );
      }
    );
  }
}