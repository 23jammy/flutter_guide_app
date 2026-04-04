import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Layout Lab"),
    );
  }
}