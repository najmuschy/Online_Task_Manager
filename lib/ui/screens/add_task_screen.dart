import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../utils/assets_path.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/scaffold_message.dart';
import '../widgets/screen_background.dart';
import 'forgot_password_verify_email.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameTEController = TextEditingController();
  final TextEditingController _taskDescriptionTEController = TextEditingController();

  bool _taskUpdateInProgress = false ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Add Task',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _taskNameTEController,
                    decoration: InputDecoration(hintText: 'Task'),
                    validator: (String? value){
                      if(value?.isEmpty ?? false){
                        return 'Enter title' ;
                      }
                      else
                        {
                          return null ;
                        }
          
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    maxLines: 10,
                    controller: _taskDescriptionTEController,
                    decoration: const InputDecoration(hintText: 'Description'),
                    validator: (String? value){
                      if(value?.isEmpty?? false){
                        return 'Enter description mi hermano' ;
                      }
                      else {
          
                          return null;
          
                      }
                    },
                  ),
          
                  const SizedBox(height: 12),
                  Visibility(
                    visible: _taskUpdateInProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _updateTask() async{
    _taskUpdateInProgress = true ;
    setState((){});
    Map<String, dynamic> requestBody= {
      "title":_taskNameTEController.text,
      "description": _taskDescriptionTEController.text,
      "status":"New"
    };
    NetworkResponse response = await NetworkClient.postRequest(url: Urls.createTaskUrl, body: requestBody) ;

    if(response.isSuccess){
      clearController() ;
      showScaffoldMessage(context, 'New task has been added') ;
    }
    else{
      showScaffoldMessage(context, 'Something went wrong, try again' , true) ;
    }
    _taskUpdateInProgress = false ;
    setState((){});
  }
  void _onTapSubmitButton() {
    if(_formKey.currentState!.validate()){
      _updateTask() ;
    }
  }
  void clearController(){

    _taskNameTEController.clear();
    _taskNameTEController.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _taskNameTEController.dispose();
    _taskDescriptionTEController.dispose();
    super.dispose();
  }
}
