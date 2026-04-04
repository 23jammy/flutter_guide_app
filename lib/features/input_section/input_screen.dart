import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Input Playground"),
    );
  }
}