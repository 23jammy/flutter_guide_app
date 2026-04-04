import 'package:flutter/material.dart';
import 'package:lecture/features/button_section/button_screen.dart';
import 'package:lecture/features/home_screen.dart';
import 'package:lecture/features/input_section/input_screen.dart';
import 'package:lecture/features/layout_section/layout_screen.dart';
import 'package:lecture/features/typography_section/typography_screen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        '/buttons': (context) => const ButtonScreen(),
        '/input': (context) => const InputScreen(),
        '/layout': (context) => const LayoutScreen(),
        '/typography': (context) => const TypographyScreen(),
      }
    );
  }
}
