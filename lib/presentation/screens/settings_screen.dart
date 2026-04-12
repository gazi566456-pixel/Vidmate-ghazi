import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidmate_clone_app/presentation/providers/webview_notifier.dart';
import 'package:vidmate_clone_app/presentation/providers/download_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadDir = ref.watch(downloadDirectoryProvider);
    final wifiOnly = ref.watch(wifiOnlyDownloadProvider);

    final webviewNotifier = ref.read(webviewNotifierProvider.notifier);
    final wifiOnlyNotifier = ref.read(wifiOnlyDownloadProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionTitle(title: 'Browser Settings'),
          ListTile(
            title: const Text('Clear Browser Cookies'),
            subtitle: const Text('Logs you out of websites in the browser tab.'),
            leading: const Icon(Icons.cookie_remove),
            onTap: () async {
              await webviewNotifier.clearCookies();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Browser cookies cleared.')),
              );
              webviewNotifier.reload();
            },
          ),
          const SectionTitle(title: 'Download Settings'),
          ListTile(
            title: const Text('Download Location'),
            subtitle: Text(downloadDir ?? 'Default (App Documents)'),
            leading: const Icon(Icons.folder_open),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Download location selection not implemented in MVP')),
              );
            },
          ),
          SwitchListTile(
            title: const Text('Wi-Fi Only Downloads'),
            subtitle: const Text('Restrict downloads to Wi-Fi connections only.'),
            value: wifiOnly,
            secondary: const Icon(Icons.wifi),
            onChanged: (bool value) {
              wifiOnlyNotifier.state = value;
            },
          ),
          const SectionTitle(title: 'About'),
          const ListTile(
            title: Text('App Version'),
            subtitle: Text('1.0.0+1 (MVP)'),
            leading: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
