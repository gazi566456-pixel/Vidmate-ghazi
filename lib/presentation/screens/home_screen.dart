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
                _buildSiteIcon(context, 'YouTube', 'assets/icons/youtube.png', 'https://www.youtube.com'),
                _buildSiteIcon(context, 'Facebook', 'assets/icons/facebook.png', 'https://www.facebook.com'),
                _buildSiteIcon(context, 'Instagram', 'assets/icons/instagram.png', 'https://www.instagram.com'),
                _buildSiteIcon(context, 'TikTok', 'assets/icons/tiktok.png', 'https://www.tiktok.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiteIcon(BuildContext context, String name, String assetPath, String url) {
    return GestureDetector(
      onTap: () {
        // Navigate to webview with this URL
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 25,
            child: Image.asset(assetPath, width: 40, height: 40, fit: BoxFit.contain),
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
