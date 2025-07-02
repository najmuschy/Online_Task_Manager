import 'package:flutter/material.dart';
import 'package:ui_design1/ui/screens/add_task_screen.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return TaskCard(taskStatus: TaskStatus.progress,);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 1);
        },
      ),

    );
  }



}
