import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';


class CompletedTaskController extends GetxController{
  bool _completedTaskInProgress = false ;
  bool get completedTaskInProgress => _completedTaskInProgress ;

  List<TaskModel> _completedTaskList = [];
  String? _errorMessage ;
  String get errorMessage => _errorMessage! ;
  List get completedTaskList => _completedTaskList ;
  Future<bool> getCompletedTasks() async{
    bool isSuccess = false ;
    _completedTaskInProgress = true ;
    update();

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.completedTaskListUrl) ;
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {}) ;
      _completedTaskList = taskListModel.taskList ;
      isSuccess = true ;
    }
    else{
      _errorMessage = response.errorMessage;
    }

    _completedTaskInProgress=false;
    update();
    return isSuccess ;
  }
}