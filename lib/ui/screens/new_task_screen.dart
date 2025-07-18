import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_list_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/controller/task_status_count_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/scaffold_message.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/summary_card.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:get/get.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});


  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  final NewTaskController _newTaskController = Get.find<NewTaskController>() ;
  final TaskStatusCountController _taskStatusCountController = Get.find<TaskStatusCountController>() ;


  @override
  void initState() {
    super.initState();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<TaskStatusCountController>(
              builder: (controller){
                return  Visibility(
                  visible: controller.taskStatusInProgress == false,
                  replacement: const Padding(
                    padding: EdgeInsets.all(16),
                    child: CenteredCircularProgressIndicator(),
                  ),
                  child: _buildSummarySection(),
                );
              },

            ),
            GetBuilder<NewTaskController>(
              builder: (controller){
                return Visibility(
                  visible: controller.newTaskInProgress == false,
                  replacement: const SizedBox(
                    height: 300,
                    child: CenteredCircularProgressIndicator(),
                  ),
                  child: ListView.separated(
                    itemCount: controller.newTaskList.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskStatus: TaskStatus.sNew,
                        taskModel: controller.newTaskList[index],
                        refreshList: _getAllNewTaskList,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                  ),
                );
              },

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTask() {
    Get.to(const AddNewTaskScreen()) ;
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: GetBuilder<TaskStatusCountController>(
          builder: (controller){
            return Visibility(
              visible: controller.taskStatusInProgress==false,
              replacement: const CenteredCircularProgressIndicator(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.taskStatusList.length,
                itemBuilder: (context, index) {
                  return SummaryCard(
                      title: controller.taskStatusList[index].status,
                      count: controller.taskStatusList[index].count);
                },
              ),
            );
          },

        ),
      ),
    );
  }

  Future<void> _getAllTaskStatusCount() async {
    final bool isSuccess = await _taskStatusCountController.getTaskStatus() ;
    if (!isSuccess) {
      showScaffoldMessage(context, _taskStatusCountController.errorMessage) ;
    }


  }

  Future<void> _getAllNewTaskList() async {
   final bool isSuccess=  await _newTaskController.getNewTasks() ;
   if(!isSuccess){
     showScaffoldMessage(context, _newTaskController.errorMessage);
   }

   _getAllTaskStatusCount();
  }
}
