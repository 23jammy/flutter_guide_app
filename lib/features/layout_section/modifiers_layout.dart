import 'package:flutter/material.dart';

class ModifiersLayout extends StatefulWidget {
  const ModifiersLayout({super.key});

  @override
  State<ModifiersLayout> createState() => _ModifiersLayoutState();
}

class _ModifiersLayoutState extends State<ModifiersLayout> {
  // Main state
  String selectedModifier = 'Flex Widget';

  // Flex State
  String flexType = 'Expanded';

  // SizedBox State
  double gapSize = 20;

  // Padding State
  double padTop = 10;
  double padLeft = 10;
  double padRight = 10;
  double padBottom = 10;

  // Alignment State
  Alignment align = Alignment.center;

  // A helper to create box

  Widget _buildBox(String text, Color color, {double width = 60, double height = 60}) {
    return Container(
      width: width,
      height: height,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  // A helper for live rendering

  Widget _buildCanvasContent() {
    switch (selectedModifier) {
      
      case 'Flex Widget':
        return Row(
          children: [
            _buildBox('Fixed', Colors.red, width: 60),
            
            // Reads your pill button state!
            if (flexType == 'Expanded')
              Expanded(child: _buildBox('Expanded', Colors.green)),
            if (flexType == 'Flexible')
              Flexible(child: _buildBox('Flexible\n(w-80)', Colors.green, width: 80)),
              
            _buildBox('Fixed', Colors.blue, width: 60),
          ],
        );

      case 'SizedBox':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBox('Box 1', Colors.teal),
            // Reads your gapSize slider!
            SizedBox(width: gapSize), 
            _buildBox('Box 2', Colors.teal),
          ],
        );

      case 'Padding':
        return Container(
          color: Colors.amber.shade100, // Light background to see the padding
          child: Padding(
            padding: EdgeInsets.only(
              top: padTop,
              bottom: padBottom,
              left: padLeft,
              right: padRight,
            ),
            // The inner box fills the remaining space so you can see the edges push in
            child: _buildBox('Inner Box', Colors.deepOrange, width: double.infinity, height: double.infinity),
          ),
        );

      case 'Align':
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blueGrey.shade50,
          child: Align(
            // Reads your Alignment dropdown!
            alignment: align, 
            child: _buildBox('Target', Colors.indigo, width: 80, height: 80),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                children: [
                  Text(
                    "Controls",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Modifier",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      DropdownButton<String>(
                        value: selectedModifier,
                        items: ['Flex Widget', 'SizedBox', 'Padding', 'Align']
                            .map((String modifier) {
                              return DropdownMenuItem<String>(
                                value: modifier,
                                child: Text(
                                  modifier,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            })
                            .toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedModifier = newValue;
                            });
                          }
                        },
                      ),
                    ],
                  ),

                  const Divider(),

                  // Sub Controls
                  if (selectedModifier == "Flex Widget")
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Flex Type",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // The Outer Light Grey Pill
                          Container(
                            width: 170,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            // We use a Stack to put the text ON TOP of the sliding background
                            child: Stack(
                              children: [
                                // --- LAYER 1: THE SLIDING BLUE BACKGROUND ---
                                AnimatedAlign(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves
                                      .easeInOut, // Gives it a smooth "snap" feel
                                  // If Expanded, snap to the left. If Flexible, snap to the right!
                                  alignment: flexType == 'Expanded'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  // FractionallySizedBox forces the blue block to be exactly half the width
                                  child: FractionallySizedBox(
                                    widthFactor: 0.5,
                                    heightFactor: 1.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple[600],
                                        borderRadius: BorderRadius.circular(
                                          25.0,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                ),

                                // --- LAYER 2: THE INVISIBLE CLICKABLE TEXT ---
                                Row(
                                  children: [
                                    // Expanded Button
                                    Expanded(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          setState(() {
                                            flexType = 'Expanded';
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Expanded',
                                            style: TextStyle(
                                              color: flexType == 'Expanded'
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight: flexType == 'Expanded'
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Flexible Button
                                    Expanded(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          setState(() {
                                            flexType = 'Flexible';
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Flexible',
                                            style: TextStyle(
                                              color: flexType == 'Flexible'
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight: flexType == 'Flexible'
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (selectedModifier == "SizedBox")
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gap Size: ${gapSize.toInt()}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: gapSize.toDouble(),
                              min: 5,
                              max: 50,
                              label: gapSize.toString(),
                              onChanged: (double newValue) {
                                setState(() {
                                  gapSize = newValue.toDouble();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (selectedModifier == "Padding")
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Top: ${padTop.toInt()}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Slider(
                                  value: padTop.toDouble(),
                                  min: 5,
                                  max: 50,
                                  label: padTop.toString(),
                                  onChanged: (double newValue) {
                                    setState(() {
                                      padTop = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bottom: ${padBottom.toInt()}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: padBottom.toDouble(),
                                min: 5,
                                max: 50,
                                label: padBottom.toString(),
                                onChanged: (double newValue) {
                                  setState(() {
                                    padBottom = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Left: ${padLeft.toInt()}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: padLeft.toDouble(),
                                min: 5,
                                max: 50,
                                label: padLeft.toString(),
                                onChanged: (double newValue) {
                                  setState(() {
                                    padLeft = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Right: ${padRight.toInt()}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: padRight.toDouble(),
                                min: 5,
                                max: 50,
                                label: padRight.toString(),
                                onChanged: (double newValue) {
                                  setState(() {
                                    padRight = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  if (selectedModifier == 'Align')
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Alignment:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          DropdownButton<Alignment>(
                            value: align,
                            items: const [
                              DropdownMenuItem(value: Alignment.topLeft, child: Text("Top Left", style: TextStyle(fontWeight: FontWeight.bold))),
                              DropdownMenuItem(value: Alignment.topCenter, child: Text("Top Center", style: TextStyle(fontWeight: FontWeight.bold))),
                              DropdownMenuItem(value: Alignment.topRight, child: Text("Top Right", style: TextStyle(fontWeight: FontWeight.bold))),
                              
                              DropdownMenuItem(value: Alignment.centerLeft, child: Text("Center Left", style: TextStyle(fontWeight: FontWeight.bold))),
                              DropdownMenuItem(value: Alignment.center, child: Text("Center", style: TextStyle(fontWeight: FontWeight.bold))),
                              DropdownMenuItem(value: Alignment.centerRight, child: Text("Center Right", style: TextStyle(fontWeight: FontWeight.bold))),
                              
                              DropdownMenuItem(value: Alignment.bottomLeft, child: Text("Bottom Left", style: TextStyle(fontWeight: FontWeight.bold))),
                              DropdownMenuItem(value: Alignment.bottomCenter, child: Text("Bottom Center", style: TextStyle(fontWeight: FontWeight.bold))),
                              DropdownMenuItem(value: Alignment.bottomRight, child: Text("Bottom Right", style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                            onChanged: (Alignment? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  align = newValue; // Perfectly matches your variable type!
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Canvas
          const SizedBox(height: 16),

          const Text(
            "Live Preview:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 0.5),
                color: Colors.grey[50],
              ),
              alignment: Alignment.center, 
              padding: EdgeInsets.all(4),

              child: _buildCanvasContent(),

            ),
          ),
        ],
      ),
    );
  }
}
