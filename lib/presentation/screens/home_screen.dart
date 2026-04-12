import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vidmate Clone'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search or paste URL',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onSubmitted: (value) {
                  Navigator.pushNamed(context, '/search', arguments: value);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular Sites',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              padding: const EdgeInsets.all(16),
              children: [
                _buildSiteIcon(context, 'YouTube', Icons.play_circle_filled, Colors.red, 'https://www.youtube.com'),
                _buildSiteIcon(context, 'Facebook', Icons.facebook, Colors.blue, 'https://www.facebook.com'),
                _buildSiteIcon(context, 'Instagram', Icons.camera_alt, Colors.purple, 'https://www.instagram.com'),
                _buildSiteIcon(context, 'TikTok', Icons.music_note, Colors.black, 'https://www.tiktok.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiteIcon(BuildContext context, String name, IconData icon, Color color, String url) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
