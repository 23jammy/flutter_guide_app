import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  // Snack bar for Click message
  void _showClickMessage(BuildContext context, String btnName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You clicked the $btnName!'),
        duration: Duration(milliseconds: 750),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Buttons"),

      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          // HIGH EMPHASIS BUTTONS

          // Title
          Text(
            'High Emphasis Buttons (Primary)',
            style: GoogleFonts.sourGummy(
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          // Elevated Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[50],
              foregroundColor: Colors.deepPurple,
            ),
            onPressed: () => _showClickMessage(context, 'Elevated Button'),
            child: Text(
              'Elevated Button',
              style: GoogleFonts.sourGummy(
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
          ),

          // Filled Button
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.pink[50],
              foregroundColor: Colors.pink,
            ),
            onPressed: () => _showClickMessage(context, 'Filled Button'),
            child: Text(
              'Filled Button',
              style: GoogleFonts.sourGummy(
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
          ),

          const Divider(height: 40),

          // MEDIUM EMPHASIS BUTTONS

          // Title
          Text(
            'Medium Emphasis Buttons (Secondary)',
            style: GoogleFonts.sourGummy(
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          // Elevated Button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.teal, width: 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Adjust the roundness
              ),
              backgroundColor: Colors.green[50],
              foregroundColor: Colors.teal[700],
            ),
            onPressed: () => _showClickMessage(context, 'Outlined Button'),
            child: Text(
              'Outlined Button',
              style: GoogleFonts.sourGummy(
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
          ),

          const Divider(height: 40),

          // LOW EMPHASIS BUTTONS

          // Title
          Text(
            'Low Emphasis Buttons (Tertiary)',
            style: GoogleFonts.sourGummy(
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          // Elevated Button
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
            onPressed: () => _showClickMessage(context, 'Text Button'),
            child: Text(
              'Text Button',
              style: GoogleFonts.sourGummy(
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
          ),

          const Divider(height: 40),

          // SPECIALIZED BUTTONS

          // Title
          Text(
            'Specialized Buttons',
            style: GoogleFonts.sourGummy(
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          // Elevated Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blueGrey[50],
                ),
                onPressed: () => _showClickMessage(context, 'Favorite Icon'),
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent,
                  size: 30,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blueGrey[50],
                ),
                onPressed: () => _showClickMessage(context, 'Share Icon'),
                icon: const Icon(Icons.share, color: Colors.cyan, size: 30),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () => _showClickMessage(context, 'Floating Action Button'),
        child: Icon(Icons.add),
      ),
    );
  }
}
