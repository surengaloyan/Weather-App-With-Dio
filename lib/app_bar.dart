import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Color mainClr;
  CustomAppBar({Key? key, required this.mainClr}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainClr,
      title: Row(
        children: const [
          Icon(Icons.cloud_queue_sharp),
          Text('Weather'),
        ],
      ),
    );
  }
}
