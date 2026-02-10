import 'package:flutter/material.dart';
import 'sync_status.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double heightApp;

  const CustomAppBar({
    super.key,
    required this.title,
    this.heightApp = kToolbarHeight,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      centerTitle: true,
      toolbarHeight: 70, // Ingrandisco leggermente l'altezza della barra per dare respiro
      title: Text(
        _currentTitle,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 22, // Un filo più grande per bilanciare il widget a sinistra
          fontWeight: FontWeight.bold,
        ),
      ),
      leadingWidth: 150, // Più spazio per il widget "Synced"
      leading: const Center( // Uso Center per allineare meglio verticalmente
        child: Padding(
          padding: EdgeInsets.only(left: 12),
          child: SyncStatusWidget(),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: isDark ? Colors.white : Colors.black, size: 28),
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        ),
        const SizedBox(width: 8),
      ],
      elevation: 0,
    );
  }
}