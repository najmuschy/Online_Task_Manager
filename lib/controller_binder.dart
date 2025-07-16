import 'package:get/get.dart';
import 'package:task_manager/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager/ui/controller/completed_task_controller.dart';
import 'package:task_manager/ui/controller/login_controller.dart';
import 'package:task_manager/ui/controller/new_task_controller.dart';
import 'package:task_manager/ui/controller/profile_update_controller.dart';
import 'package:task_manager/ui/controller/progress_task_controller.dart';
import 'package:task_manager/ui/controller/task_status_count_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies(){
    Get.put(LoginController()) ;
    Get.put(NewTaskController()) ;
    Get.put(ProgressTaskController()) ;
    Get.put(CancelledTaskController()) ;
    Get.put(CompletedTaskController()) ;
    Get.put(TaskStatusCountController()) ;
    Get.put(ProfileUpdateController()) ;
  }
}