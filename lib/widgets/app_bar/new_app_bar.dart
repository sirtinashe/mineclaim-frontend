import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  const MyAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 2, // Controls the shadow depth
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.5),
      child: AppBar(
        // foregroundColor: Colors.white,
        backgroundColor: PrimaryColors().appDarkBlue,
        centerTitle: true,

        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
