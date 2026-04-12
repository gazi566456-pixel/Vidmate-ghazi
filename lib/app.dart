import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Screens
import 'package:vidmate_clone_app/presentation/screens/home_screen.dart';
import 'package:vidmate_clone_app/presentation/screens/webview_screen.dart';
import 'package:vidmate_clone_app/presentation/screens/downloads_screen.dart';
import 'package:vidmate_clone_app/presentation/screens/player_screen.dart';
import 'package:vidmate_clone_app/presentation/screens/settings_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    WebviewScreen(),
    DownloadsScreen(),
    PlayerScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.language), label: 'Browser'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Downloads'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_filled), label: 'Player'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
      ),
    );
  }
}
