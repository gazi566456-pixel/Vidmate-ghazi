import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String? initialQuery = ModalRoute.of(context)?.settings.arguments as String?;
    if (initialQuery != null) {
      _controller.text = initialQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search / Paste URL')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter URL or search term...',
                suffixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {
                  final query = _controller.text;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Simulating search for: $query')));
                }),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: (query) {
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Simulating search for: $query')));
              },
            ),
            const SizedBox(height: 20),
            const Expanded(child: Center(child: Text('Enter a URL or search term to begin.'))),
          ],
        ),
      ),
    );
  }
}
