import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart';

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Buttons"),
    );
  }
}