import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vidmate_clone_app/app.dart';
import 'package:vidmate_clone_app/presentation/screens/search_screen.dart';
import 'package:vidmate_clone_app/presentation/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Request permissions at startup
  await _requestPermissions();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> _requestPermissions() async {
  if (Platform.isAndroid) {
    // Request storage permissions (granular for Android 13+, broad for older)
    await Permission.manageExternalStorage.request(); // Broad access for downloads
    await Permission.mediaLibrary.request(); // For Android 13+ media access
    await Permission.audio.request(); // For audio access
    await Permission.videos.request(); // For video access

    // Notification permission for Android 13+
    await Permission.notification.request();
    // Foreground service permission (Android 14+) is handled natively via manifest/runtime system
  } else if (Platform.isIOS) {
    // Notification permissions on iOS
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidmate Clone MVP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Use Material 3 design
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const MainScaffold(), // Main screen with bottom navigation
      routes: {
        // Define routes for navigation
        '/search': (context) => const SearchScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
