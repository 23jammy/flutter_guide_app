import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  // --- MASTER STATE ---
  String selectedConcept = 'LayoutBuilder';

  // --- SHARED STATE ---
  // We start the simulated screen width at 200 pixels
  double simulatedWidth = 200.0;

  // --- HELPER TO DRAW A BOX ---
  Widget _buildBox(String text, Color color) {
    return Container(
      height: 60,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- THE LIVE PREVIEW RENDERER ---
  Widget _buildCanvasContent() {
    switch (selectedConcept) {
      case 'LayoutBuilder':
        // 1. The Breakpoint: Changes completely based on width!
        return LayoutBuilder(
          builder: (context, constraints) {
            // If the box is squeezed smaller than 250px, show Mobile UI
            if (constraints.maxWidth < 250) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone_iphone, size: 50, color: Colors.blue),
                  const SizedBox(height: 10),
                  _buildBox('Mobile Layout\n(< 250px)', Colors.blue),
                ],
              );
            }
            // If it's wider than 250px, show Tablet UI
            else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.tablet_mac, size: 50, color: Colors.green),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildBox('Tablet Layout\n(>= 250px)', Colors.green),
                  ),
                ],
              );
            }
          },
        );

      case 'Fractional Sizing':
        // 2. The Percentage Sizer: Always takes up exactly 70% of the space
        return Center(
          child: FractionallySizedBox(
            widthFactor: 0.7, // 70% of parent width
            child: _buildBox(
              'I am always 70%\nof my parent!',
              Colors.deepOrange,
            ),
          ),
        );

      case 'Auto Grid':
      default:
        // 3. The Math Grid: Calculates columns based on available pixels
        return LayoutBuilder(
          builder: (context, constraints) {
            // Math: Divide the available width by 80px to see how many boxes fit!
            int columns = (constraints.maxWidth / 80).floor();
            // Ensure at least 1 column so it doesn't crash if squeezed to 0
            columns = columns > 0 ? columns : 1;

            return GridView.builder(
              itemCount: 12,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) => Container(
                color: Colors.purple,
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // We wrap the entire page in a LayoutBuilder so we know EXACTLY
    // how wide the user's physical phone is. This allows us to set the
    // Slider's maximum value so the simulated box doesn't break the screen!
    return LayoutBuilder(
      builder: (context, pageConstraints) {
        // Calculate max width for the slider (Phone Width - padding)
        final maxSliderWidth = pageConstraints.maxWidth - 32;

        return Padding(
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
                                  'LayoutBuilder',
                                  'Fractional Sizing',
                                  'Auto Grid',
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
                              if (val != null)
                                setState(() => selectedConcept = val);
                            },
                          ),
                        ],
                      ),
                      const Divider(),

                      // --- SECTION 2: THE DEVICE RESIZER SLIDER ---
                      const Text(
                        "Drag to resize the simulated device:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone_android,
                            size: 20,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Slider(
                              value: simulatedWidth.clamp(
                                100.0,
                                maxSliderWidth,
                              ),
                              min: 100,
                              max: maxSliderWidth,
                              onChanged: (val) =>
                                  setState(() => simulatedWidth = val),
                            ),
                          ),
                          const Icon(
                            Icons.tablet_android,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Text(
                        "Current Width: ${simulatedWidth.toInt()}px",
                        style: const TextStyle(fontWeight: FontWeight.bold),
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

              // --- SECTION 3: THE CANVAS ---
              Expanded(
                // We use Center so the simulated device sits in the middle of the empty space
                child: Center(
                  // THIS is the simulated device!
                  child: Container(
                    width: simulatedWidth, // Bound to the slider!
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.black87,
                        width: 4,
                      ), // Thick border looks like a phone bezel
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildCanvasContent(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
