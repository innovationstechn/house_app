import 'package:flutter/material.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  StandardAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            icon: Icon(Icons.calendar_today_outlined,color: Colors.black),
            onPressed: () {
            }),
        IconButton(icon: Icon(Icons.more_vert,color: Colors.black), onPressed: () {
        })
      ],
      title: Text(this.title),
      leading: IconButton(
        icon: Icon(Icons.menu,color: Colors.black),
        onPressed: () {},
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}