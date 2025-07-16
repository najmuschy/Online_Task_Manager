import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/completed_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:get/get.dart';

import '../widgets/scaffold_message.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
 CompletedTaskController _completedTaskController = Get.find<CompletedTaskController>() ;

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskController>(
        builder: (controller) {
          return Visibility(
            visible: controller.completedTaskInProgress == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.completed,
                  taskModel: controller.completedTaskList[index],
                  refreshList: _getAllCompletedTaskList,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );

        },
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    final bool isSuccess=  await _completedTaskController.getCompletedTasks() ;
    if(!isSuccess){
      showScaffoldMessage(context, _completedTaskController.errorMessage);
    }

    
  }
}

