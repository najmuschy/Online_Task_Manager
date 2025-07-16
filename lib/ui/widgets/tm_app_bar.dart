import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/profile_update_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';
import 'package:get/get.dart';


class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.fromProfileScreen,
  });

  final bool? fromProfileScreen;


  @override
  Widget build(BuildContext context) {
    ProfileUpdateController _profileUpdateController = Get.find<ProfileUpdateController>() ;
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromProfileScreen ?? false) {
            return;
          }
          _onTapProfileSection(context);
        },
        child: GetBuilder<ProfileUpdateController>(
          builder: (controller){
            return Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: controller.appBarPhoto!=null?  MemoryImage(base64Decode(controller.appBarPhoto!)) : _shouldShowImage(AuthController.userModel?.photo )
                      ? MemoryImage(
                    base64Decode(AuthController.userModel?.photo ?? ''),
                  ): null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.appBarFullName!=null? controller.appBarFullName! : AuthController.userModel?.fulName ?? 'Unknown',
                        style: textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        controller.appBarEmail!=null? controller.appBarEmail! : AuthController.userModel?.email ?? 'Unknown',
                        style: textTheme.bodySmall?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () => _onTapLogOutButton(context),
                    icon: const Icon(Icons.logout))
              ],
            );
          },
        ),
      ),
    );
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }

  void _onTapProfileSection(BuildContext context) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => const UpdateProfileScreen(),),);
  }

  Future<void> _onTapLogOutButton(BuildContext context) async {
    await AuthController.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (predicate) => false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
