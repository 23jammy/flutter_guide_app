import 'package:flutter/material.dart';

class CoreLayout extends StatefulWidget {
  const CoreLayout({super.key});

  @override
  State<CoreLayout> createState() => _CoreLayoutState();
}

class _CoreLayoutState extends State<CoreLayout> {
  String selectedLayout = 'Row';
  int cardCount = 3;

  // Helper to generate cards
  List<Widget> _generatedCards() {
    return List.generate(
      cardCount,
      (index) => Container(
        width: 100,
        height: 100,
        color: Colors.purple[300],
        margin: const EdgeInsets.all(4),
        alignment: Alignment.center,
      ),
    );
  }

  // Helper for layout switch based on what user selected
  Widget _buildActiveLayout() {
    final cards = _generatedCards();

    switch (selectedLayout) {
      case 'Column':
        return Column(children: cards);
      case 'Wrap':
        return Wrap(children: cards);
      case 'Stack':
        return Stack(
          children: List.generate(cardCount, (index) {
            return Positioned(
              top: index * 25.0,
              left: index * 30.0,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.purple[400]!.withValues(alpha: 0.5),
                alignment: Alignment.center,
              ),
            );
          }),
        );
      case 'Row':
        return Row(children: cards);
      default:
        return Row(children: cards);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Controls
          Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "Controls",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Layout", style: TextStyle(fontSize: 16)),
                      DropdownButton<String>(
                        value: selectedLayout,
                        items: ['Row', 'Column', 'Stack', 'Wrap'].map((
                          String layout,
                        ) {
                          return DropdownMenuItem<String>(
                            value: layout,
                            child: Text(
                              layout,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedLayout = newValue;
                            });
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cards: $cardCount", style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Slider(
                          value: cardCount.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: cardCount.toString(),
                          onChanged: (double newValue) {
                            setState(() {
                              cardCount = newValue.toInt();
                            });
                          },
                        ),
                      ),
                    ],
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

              child: _buildActiveLayout(),
            ),
          ),
        ],
      ),
    );
  }
}
