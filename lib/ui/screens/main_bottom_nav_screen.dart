import 'package:flutter/material.dart';
import 'package:ui_design1/ui/screens/cancelled_task_screen.dart';
import 'package:ui_design1/ui/screens/completed_task_screen.dart';
import 'package:ui_design1/ui/screens/progress_task_screen.dart';
import 'package:ui_design1/ui/screens/new_task_screen.dart';

import '../widgets/tm_appbar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  int _selectedIndex = 0;
  final List<Widget> _screens=[
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index){
          _selectedIndex= index;
          setState(() {

          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: "New"),
          NavigationDestination(
            icon: Icon(Icons.timelapse_sharp),
            label: "Progress",
          ),
          NavigationDestination(icon: Icon(Icons.done), label: "Completed"),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: "Cancelled",
          ),
        ],
      ),
    );
  }
}

