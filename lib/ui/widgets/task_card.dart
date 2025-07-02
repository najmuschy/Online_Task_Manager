import 'package:flutter/material.dart';

enum TaskStatus{
  sNew,
  completed,
  progress,
  cancelled
}
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.taskStatus,
  });
 final TaskStatus taskStatus;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task title', style: TextTheme.of(context).titleLarge,),
            SizedBox(height: 4,),
            Text('Task description'),
            SizedBox(height: 8,),
            Text('Task Date'),
            SizedBox(height: 8,),
            Row(
              children: [
                Chip(label: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24),
                  child: Text('New', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                ), backgroundColor: _getChipColor(), shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete)),


              ],
            )
          ],
        ),
      ),
    );
  }
  Color _getChipColor(){
    late Color color;
    switch(taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
      case TaskStatus.completed:
        color = Colors.green;
      case TaskStatus.progress:
        color = Colors.purpleAccent;
      case TaskStatus.cancelled:
        color = Colors.red;
    }
    return color;
  }
}