import 'package:flutter/material.dart';

class ScrollLayout extends StatefulWidget {
  const ScrollLayout({super.key});

  @override
  State<ScrollLayout> createState() => _ScrollLayoutState();
}

class _ScrollLayoutState extends State<ScrollLayout> {
  // --- MASTER STATE ---
  String selectedScroll = 'ListView';

  // --- SHARED STATE ---
  double itemCount = 5; // How many boxes to draw

  // --- LISTVIEW & SINGLECHILDSCHROLLVIEW STATE ---
  String axisDirection = 'Vertical'; // Vertical or Horizontal

  // --- GRIDVIEW STATE ---
  double gridColumns = 3; // How many items across

  // --- HELPER TO DRAW NUMBERED BOXES ---
  Widget _buildBox(int index) {
    // Alternate colors to make scrolling obvious!
    final isEven = index % 2 == 0;
    return Container(
      height: 80,
      width: 80,
      margin: const EdgeInsets.all(4.0), // Adds a tiny gap between items
      decoration: BoxDecoration(
        color: isEven ? Colors.indigo : Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Text(
        '${index + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- THE LIVE PREVIEW RENDERER ---
  Widget _buildCanvasContent() {
    final scrollAxis = axisDirection == 'Vertical'
        ? Axis.vertical
        : Axis.horizontal;

    switch (selectedScroll) {
      case 'SingleChildScrollView':
        // 1. The Overflow Fixer: Wraps a standard Row or Column!
        List<Widget> standardBoxes = List.generate(
          itemCount.toInt(),
          (index) => _buildBox(index),
        );

        return SingleChildScrollView(
          scrollDirection: scrollAxis,
          // If vertical, use a Column. If horizontal, use a Row!
          child: scrollAxis == Axis.vertical
              ? Column(children: standardBoxes)
              : Row(children: standardBoxes),
        );

      case 'GridView':
        // 2. The Strict Wrap: Perfect columns and rows
        return GridView.builder(
          // GridView automatically scrolls vertically, so we don't need the axis toggle here
          itemCount: itemCount.toInt(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridColumns.toInt(), // Reads your slider!
          ),
          itemBuilder: (context, index) {
            return _buildBox(index);
          },
        );

      case 'ListView':
      default:
        // 3. The Infinite Column/Row: Highly optimized for long lists
        return ListView.builder(
          scrollDirection: scrollAxis,
          itemCount: itemCount.toInt(),
          itemBuilder: (context, index) {
            return _buildBox(index);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- SECTION 1: CONTROLS ---
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                        "Scroll Type",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      DropdownButton<String>(
                        value: selectedScroll,
                        items: ['ListView', 'GridView', 'SingleChildScrollView']
                            .map((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            })
                            .toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => selectedScroll = newValue);
                          }
                        },
                      ),
                    ],
                  ),

                  const Divider(),

                  // --- SECTION 2: DYNAMIC SUB-CONTROLS ---

                  // ALL TYPES: Item Count Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Item Count: ${itemCount.toInt()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: itemCount,
                          min: 1,
                          max: 15, // Let them scroll a lot!
                          label: itemCount.toInt().toString(),
                          onChanged: (val) => setState(() => itemCount = val),
                        ),
                      ),
                    ],
                  ),

                  // LISTVIEW & SINGLECHILDSCHROLLVIEW: Axis Toggle (Reused your Sliding Pill!)
                  if (selectedScroll == 'ListView' ||
                      selectedScroll == 'SingleChildScrollView')
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Scroll Axis",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // Your custom sliding pill, adapted for scrolling!
                          Container(
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  alignment: axisDirection == 'Vertical'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
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
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => setState(
                                          () => axisDirection = 'Vertical',
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Vertical',
                                            style: TextStyle(
                                              color: axisDirection == 'Vertical'
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight:
                                                  axisDirection == 'Vertical'
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => setState(
                                          () => axisDirection = 'Horizontal',
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Horizontal',
                                            style: TextStyle(
                                              color:
                                                  axisDirection == 'Horizontal'
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight:
                                                  axisDirection == 'Horizontal'
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

                  // GRIDVIEW: Columns Slider
                  if (selectedScroll == 'GridView')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grid Columns: ${gridColumns.toInt()}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: gridColumns,
                            min: 2,
                            max: 6,
                            divisions: 4, // Snap to 2, 3, 4, 5, 6
                            label: gridColumns.toInt().toString(),
                            onChanged: (val) =>
                                setState(() => gridColumns = val),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          // --- SECTION 3: CANVAS ---
          const SizedBox(height: 16),
          const Text(
            "Live Preview:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: Container(
              // Notice we DO NOT use padding here! Scrolling items should touch the edges.
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 0.5),
                color: Colors.grey[50],
              ),
              child: _buildCanvasContent(),
            ),
          ),
        ],
      ),
    );
  }
}
