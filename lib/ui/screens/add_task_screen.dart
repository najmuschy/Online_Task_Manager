import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design1/ui/screens/main_bottom_nav_screen.dart';
import 'package:ui_design1/ui/screens/register_screen.dart';

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


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
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
                ),
                SizedBox(height: 6),
                TextFormField(
                  maxLines: 10,
                  controller: _taskDescriptionTEController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),

                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: Icon(Icons.arrow_forward),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _taskNameTEController.dispose();
    _taskDescriptionTEController.dispose();
    super.dispose();
  }
}
