import 'package:flutter/material.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return TaskCard(taskStatus: TaskStatus.completed,);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 1);
        },
      ),

    );
  }


}
