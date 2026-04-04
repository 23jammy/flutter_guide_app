import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuCard extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color cardColor;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.text,
    required this.textColor,
    required this.cardColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Ink(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 250,
            height: 75,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Text(
              text,
              style: GoogleFonts.sourGummy(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
