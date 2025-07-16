import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/scaffold_message.dart';

class NewTaskController extends GetxController{
  bool _newTaskInProgress = false ;
  bool get newTaskInProgress => _newTaskInProgress ;

  List<TaskModel> _newTaskList = [];
  String? _errorMessage ;
  String get errorMessage => _errorMessage! ;
  List get newTaskList => _newTaskList ;
  Future<bool> getNewTasks() async{
    bool isSuccess = false ;
    _newTaskInProgress = true ;
    update();

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.newTaskListUrl) ;
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {}) ;
      _newTaskList = taskListModel.taskList ;
      isSuccess = true ;
    }
    else{
      _errorMessage = response.errorMessage;
    }

    _newTaskInProgress=false;
    update();
    return isSuccess ;
  }
}