import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/progress_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:get/get.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProgressTaskController>(
        builder: (controller){
          return Visibility(
            visible: controller.progressTaskInProgress == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.progressTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.progress,
                  taskModel: controller.progressTaskList[index],
                  refreshList: _getAllProgressTaskList,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
        },

      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    final bool isSuccess = await _progressTaskController.getProgressTasks() ;
    if (!isSuccess) {
      showSnackBarMessage(context, _progressTaskController.errorMessage, true);
    }
  }
}
