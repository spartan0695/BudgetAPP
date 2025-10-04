import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double heightApp;

   const CustomAppBar({super.key, required this.title, this.heightApp=kToolbarHeight,});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

// Altezza standard AppBar
  @override
  Size get preferredSize => Size.fromHeight(heightApp);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String _currentTitle;

   @override
  void initState() {
    super.initState();
    _currentTitle = widget.title;
  }

  void updateTitle(String newTitle) {
    setState(() {
      _currentTitle = newTitle;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        _currentTitle,
        style: const TextStyle(color: Colors.black),
      ),
      leading: const Padding(
        padding: EdgeInsets.only(left: 12),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
      ),
      actions: const [
        Icon(Icons.settings, color: Colors.black),
        SizedBox(width: 16),
      ],
      elevation: 0,
    );
  }
}