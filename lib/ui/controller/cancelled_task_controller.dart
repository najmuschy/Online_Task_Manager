import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/scaffold_message.dart';

class CancelledTaskController extends GetxController{
  bool _cancelledTaskInProgress = false ;
  bool get cancelledTaskInProgress => _cancelledTaskInProgress ;

  List<TaskModel> _cancelledTaskList = [];
  String? _errorMessage ;
  String get errorMessage => _errorMessage! ;
  List get cancelledTaskList => _cancelledTaskList ;
  Future<bool> getCancelledTasks() async{
    bool isSuccess = false ;
    _cancelledTaskInProgress = true ;
    update();

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.cancelledTaskListUrl) ;
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {}) ;
      _cancelledTaskList = taskListModel.taskList ;
      isSuccess = true ;
    }
    else{
      _errorMessage = response.errorMessage;
    }

    _cancelledTaskInProgress=false;
    update();
    return isSuccess ;
  }
}