import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Typography"),
    );
  }
}