import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart'; // Your custom appbar

class TypographyScreen extends StatefulWidget {
  const TypographyScreen({super.key});

  @override
  State<TypographyScreen> createState() => _TypographyScreenState();
}

class _TypographyScreenState extends State<TypographyScreen> {
  // --- MASTER STATE ---
  String selectedConcept = 'Basic Styling';

  // --- BASIC STYLING STATE ---
  double fontSize = 24.0;
  double letterSpacing = 0.0;
  double lineHeight = 1.2;
  String selectedWeight = 'Normal';

  // Dictionary for Font Weights
  final Map<String, FontWeight> weights = {
    'Light': FontWeight.w300,
    'Normal': FontWeight.normal,
    'Bold': FontWeight.bold,
    'Black': FontWeight.w900,
  };

  // --- PARAGRAPH CONTROL STATE ---
  String selectedAlign = 'Left';
  String selectedOverflow = 'Ellipsis';
  double maxLines = 2.0;

  // Dictionaries for Paragraph properties
  final Map<String, TextAlign> aligns = {
    'Left': TextAlign.left,
    'Center': TextAlign.center,
    'Right': TextAlign.right,
    'Justify': TextAlign.justify,
  };

  final Map<String, TextOverflow> overflows = {
    'Clip': TextOverflow.clip,
    'Fade': TextOverflow.fade,
    'Ellipsis': TextOverflow.ellipsis,
  };

  // --- THE LIVE PREVIEW RENDERER ---
  Widget _buildCanvasContent() {
    // A standard block of text to test on
    const String sampleText =
        "Flutter transforms the entire app development process. "
        "Build, test, and deploy beautiful mobile, web, desktop, and embedded apps "
        "from a single codebase.";

    switch (selectedConcept) {
      case 'Basic Styling':
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              sampleText,
              textAlign: TextAlign.center, // Keep it centered for the preview
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: weights[selectedWeight],
                letterSpacing: letterSpacing,
                height: lineHeight, // Height is a multiplier of the font size!
                color: Colors.deepPurple[800],
              ),
            ),
          ),
        );

      case 'Paragraph Control':
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                sampleText,
                // These properties belong to the Text widget
                textAlign: aligns[selectedAlign],
                maxLines: maxLines.toInt(),
                overflow: overflows[selectedOverflow],
                style: const TextStyle(fontSize: 20, height: 1.4),
              ),
            ),
          ),
        );

      case 'Rich Text':
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text.rich(
              TextSpan(
                // The default style for the whole paragraph
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: "Sometimes you need to "),
                  TextSpan(
                    text: "highlight a specific word",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                      backgroundColor: Colors.yellow[200],
                    ),
                  ),
                  const TextSpan(text: " or make something "),
                  const TextSpan(
                    text: "italicized",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(
                    text:
                        " without breaking the sentence into multiple different text widgets!",
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(text: "Typography"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- SECTION 1: CONTROLS ---
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Controls",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    // Main Concept Dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Concept",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedConcept,
                          items:
                              [
                                'Basic Styling',
                                'Paragraph Control',
                                'Rich Text',
                              ].map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    val,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => selectedConcept = val);
                            }
                          },
                        ),
                      ],
                    ),
                    const Divider(),

                    // --- DYNAMIC SUB-CONTROLS ---
                    if (selectedConcept == 'Basic Styling')
                      Column(
                        children: [
                          // Font Size Slider
                          Row(
                            children: [
                              Text("Size: ${fontSize.toInt()}"),
                              Expanded(
                                child: Slider(
                                  value: fontSize,
                                  min: 10,
                                  max: 40,
                                  onChanged: (val) =>
                                      setState(() => fontSize = val),
                                ),
                              ),
                            ],
                          ),
                          // Line Height Slider
                          Row(
                            children: [
                              Text(
                                "Line Height: ${lineHeight.toStringAsFixed(1)}",
                              ),
                              Expanded(
                                child: Slider(
                                  value: lineHeight,
                                  min: 0.5,
                                  max: 3.0,
                                  onChanged: (val) =>
                                      setState(() => lineHeight = val),
                                ),
                              ),
                            ],
                          ),
                          // Font Weight Dropdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Font Weight"),
                              DropdownButton<String>(
                                value: selectedWeight,
                                items: weights.keys
                                    .map(
                                      (w) => DropdownMenuItem(
                                        value: w,
                                        child: Text(w),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => selectedWeight = val!),
                              ),
                            ],
                          ),
                        ],
                      ),

                    if (selectedConcept == 'Paragraph Control')
                      Column(
                        children: [
                          // Max Lines Slider
                          Row(
                            children: [
                              Text("Max Lines: ${maxLines.toInt()}"),
                              Expanded(
                                child: Slider(
                                  value: maxLines,
                                  min: 1,
                                  max: 5,
                                  divisions: 4,
                                  onChanged: (val) =>
                                      setState(() => maxLines = val),
                                ),
                              ),
                            ],
                          ),
                          // Text Alignment Dropdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Alignment"),
                              DropdownButton<String>(
                                value: selectedAlign,
                                items: aligns.keys
                                    .map(
                                      (a) => DropdownMenuItem(
                                        value: a,
                                        child: Text(a),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => selectedAlign = val!),
                              ),
                            ],
                          ),
                          // Overflow Dropdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Overflow Behavior"),
                              DropdownButton<String>(
                                value: selectedOverflow,
                                items: overflows.keys
                                    .map(
                                      (o) => DropdownMenuItem(
                                        value: o,
                                        child: Text(o),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => selectedOverflow = val!),
                              ),
                            ],
                          ),
                        ],
                      ),

                    if (selectedConcept == 'Rich Text')
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "RichText uses a tree of TextSpans to allow multiple different styles inside a single seamless paragraph.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Live Preview:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // --- SECTION 2: THE CANVAS ---
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildCanvasContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
