import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:get/get.dart';

import '../widgets/scaffold_message.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController = Get.find<CancelledTaskController>() ;

  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskController>(
        builder: (controller){
          return Visibility(
            visible: controller.cancelledTaskInProgress == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.cancelled,
                  taskModel: controller.cancelledTaskList[index],
                  refreshList: _getAllCancelledTaskList,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
        },
      ),
    );
  }

  Future<void> _getAllCancelledTaskList() async {

    final bool isSuccess=  await _cancelledTaskController.getCancelledTasks() ;
    if(!isSuccess){
      showScaffoldMessage(context, _cancelledTaskController.errorMessage);
    }

  }
}
