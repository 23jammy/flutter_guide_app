import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart';
import 'package:lecture/core/widgets/menu_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Home"),

      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MenuCard(
                text: "Buttons",
                textColor: Colors.black87,
                cardColor: Colors.teal[100]!,
                onTap: () {
                  Navigator.pushNamed(context, '/buttons');
                },
              ),
              MenuCard(
                text: "Layout Lab",
                textColor: Colors.black87,
                cardColor: Colors.indigo[200]!,
                onTap: () {
                  Navigator.pushNamed(context, '/layout');
                },
              ),
              MenuCard(
                text: "Input Playground",
                textColor: Colors.white,
                cardColor: Colors.blue[600]!,
                onTap: () {
                  Navigator.pushNamed(context, '/input');
                },
              ),
              MenuCard(
                text: "Typography",
                textColor: Colors.white,
                cardColor: Colors.blueGrey[600]!,
                onTap: () {
                  Navigator.pushNamed(context, '/typography');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
