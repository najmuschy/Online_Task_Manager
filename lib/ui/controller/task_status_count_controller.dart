import 'package:get/get.dart';
import 'package:task_manager/data/models/task_status_count_list_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/models/task_status_count_model.dart';

class TaskStatusCountController extends GetxController{
  bool _taskStatusInProgress = false ;
  bool get taskStatusInProgress => _taskStatusInProgress ;

  String? _errorMessage ;
  String get errorMessage => _errorMessage! ;

  List<TaskStatusCountModel> _taskStatusCountList = [];
  List get taskStatusList => _taskStatusCountList ;

  Future<bool> getTaskStatus() async{
    bool isSuccess = false ;
    _taskStatusInProgress =true ;
    update() ;

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);

    if(response.isSuccess){
      TaskStatusCountListModel taskStatusCountListModel = TaskStatusCountListModel.fromJson(response.data ?? {}) ;
      _taskStatusCountList = taskStatusCountListModel.statusCountList ;
      isSuccess = true ;
    }
    else{
      _errorMessage = response.errorMessage ;
    }

    _taskStatusInProgress =false ;
    update() ;
    return isSuccess ;
  }
}