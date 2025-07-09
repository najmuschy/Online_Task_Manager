import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design1/data/service/network_client.dart';
import 'package:ui_design1/data/utils/urls.dart';
import 'package:ui_design1/ui/screens/main_bottom_nav_screen.dart';
import 'package:ui_design1/ui/screens/register_screen.dart';
import 'package:ui_design1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:ui_design1/ui/widgets/scaffold_message.dart';

import 'package:ui_design1/ui/widgets/screen_background.dart';

import '../utils/assets_path.dart';
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
                  SizedBox(height: 80),
                  Text(
                    'Add Task',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 6),
                  TextFormField(
                    maxLines: 10,
                    controller: _taskDescriptionTEController,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value){
                      if(value?.isEmpty?? false){
                        return 'Enter description mi hermano' ;
                      }
                      else {
          
                          return null;
          
                      }
                    },
                  ),
          
                  SizedBox(height: 12),
                  Visibility(
                    visible: _taskUpdateInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_forward),
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
    NetworkResponse response = await NetworkClient.postRequest(url: Urls.createTask, body: requestBody) ;

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
