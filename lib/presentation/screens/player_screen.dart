import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media Player')),
      body: const Center(
        child: Text(
          'Media player functionality will be implemented here.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
      ),
    );
  }
}
