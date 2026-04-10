import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final PreferredSizeWidget? bottom;

  const CustomAppbar({super.key, required this.text, this.bottom});

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white,), // Make the built-in back button white
      title: Text(
        text,
        style: GoogleFonts.pangolin(
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
      backgroundColor: Colors.deepPurple,
      bottom: bottom,
    );
  }
}
