import 'package:flutter/material.dart';
import 'package:lecture/core/widgets/custom_appbar.dart';
import 'package:lecture/features/layout_section/core_layout.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppbar(
          text: "Layout Lab",
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: Container(
              color: Colors.deepPurple[50],
              child: TabBar(
                indicatorColor: Colors.deepPurple[700], 
                labelColor: Colors.black, 
                unselectedLabelColor: Colors.black.withValues(alpha:0.7), 
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                tabs: [
                  Tab(text: "Core"),
                  Tab(text: "Modifiers"),
                  Tab(text: "Scroll"),
                  Tab(text: "Responsive"),
                ],
              ),
            ),
          ),
        ),

        body: TabBarView(children: [
          CoreLayout(),
        ],)
      ),
    );
  }
}
