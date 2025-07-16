import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/scaffold_message.dart';

class ProgressTaskController extends GetxController{
  bool _progressTaskInProgress = false ;
  bool get progressTaskInProgress => _progressTaskInProgress ;

  List<TaskModel> _progressTaskList = [];
  String? _errorMessage ;
  String get errorMessage => _errorMessage! ;
  List get progressTaskList => _progressTaskList ;
  Future<bool> getProgressTasks() async{
    bool isSuccess = false ;
    _progressTaskInProgress = true ;
    update();

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.progressTaskListUrl) ;
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {}) ;
      _progressTaskList = taskListModel.taskList ;
      isSuccess = true ;
    }
    else{
      _errorMessage = response.errorMessage;
    }

    _progressTaskInProgress=false;
    update();
    return isSuccess ;
  }
}