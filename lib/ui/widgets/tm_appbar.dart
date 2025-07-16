import 'dart:convert';

import 'package:flutter/material.dart';


import '../controller/auth_controller.dart';
import '../screens/login_screen.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfileScreen});

  final bool? fromUpdateProfileScreen;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromUpdateProfileScreen ?? false) {
            return;
          }

          _onTapUpdateProfile(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundImage: showImageOrNot(AuthController.userModel?.photo) ? MemoryImage(
                base64Decode(AuthController.userModel!.photo?? ''),
              ): null,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fulName ?? '',
                  style: theme.bodyLarge?.copyWith(color: Colors.white),
                ),

                Text(
                  AuthController.userModel?.email ?? '',
                  style: theme.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _onTapLogoutButton(context),
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  _onTapUpdateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
    );
  }
   bool showImageOrNot(String? photo){
    return photo!=null && photo.isNotEmpty ;

  }
  _onTapLogoutButton(BuildContext context) async {
    await AuthController.clearUserInfo();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
