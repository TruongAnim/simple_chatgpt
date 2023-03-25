import 'package:flutter/material.dart';

class ChatPageAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('hello'),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu)),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
