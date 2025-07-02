import 'package:flutter/material.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSummarySection(),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                 return TaskCard(taskStatus: TaskStatus.sNew,);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 1);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onTapTaskAdd,
        label: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );
  }

  Widget buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          SummaryCard(count: 12, status: 'New'),
          SummaryCard(count: 12, status: 'Cancelled'),
          SummaryCard(count: 12, status: 'Progress'),
          SummaryCard(count: 12, status: 'Completed'),
        ],
      ),
    );
  }
  void _onTapTaskAdd(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen())) ;
  }
}
