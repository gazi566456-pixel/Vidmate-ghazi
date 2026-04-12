import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidmate_clone_app/presentation/providers/download_providers.dart';
import 'package:vidmate_clone_app/presentation/widgets/download_list_item.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(downloadRepositoryProvider);
    final activeDownloads = repository.activeDownloads;
    final completedDownloads = repository.completedDownloads;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Downloads'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Downloading'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDownloadList(activeDownloads, repository),
            _buildDownloadList(completedDownloads, repository),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadList(List activeDownloads, repository) {
    if (activeDownloads.isEmpty) {
      return const Center(child: Text('No downloads yet.'));
    }
    return ListView.builder(
      itemCount: activeDownloads.length,
      itemBuilder: (context, index) {
        final item = activeDownloads[index];
        return DownloadListItem(
          downloadItem: item,
          onCancel: () => repository.cancelDownload(item.id),
        );
      },
    );
  }
}
