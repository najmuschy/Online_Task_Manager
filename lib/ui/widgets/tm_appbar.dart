import 'package:flutter/material.dart';
import 'package:ui_design1/ui/screens/new_task_screen.dart';
import 'package:ui_design1/ui/screens/update_profile_screen.dart';

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
            CircleAvatar(radius: 14),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Najmus Saquib',
                  style: theme.bodyLarge?.copyWith(color: Colors.white),
                ),

                Text(
                  'avc@gmail.com',
                  style: theme.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
    );
  }

  _onTapUpdateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
