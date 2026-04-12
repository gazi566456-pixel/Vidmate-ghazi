import 'package:flutter/material.dart';
import 'package:vidmate_clone_app/data/repositories/download_repository_impl.dart';
import 'package:vidmate_clone_app/core/utils/formatters.dart';

class DownloadListItem extends StatelessWidget {
  final DownloadItem downloadItem;
  final VoidCallback onCancel;

  const DownloadListItem({
    super.key,
    required this.downloadItem,
    required this.onCancel,
  });

  String _getStatusText(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.queued: return 'Queued';
      case DownloadStatus.downloading: return 'Downloading';
      case DownloadStatus.paused: return 'Paused';
      case DownloadStatus.completed: return 'Completed';
      case DownloadStatus.failed: return 'Failed';
      case DownloadStatus.processing: return 'Processing...';
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0.0;
    if (downloadItem.status != DownloadStatus.completed &&
        downloadItem.totalBytes != null && downloadItem.totalBytes! > 0) {
      progress = (downloadItem.downloadedBytes / downloadItem.totalBytes!).clamp(0.0, 1.0);
    } else if (downloadItem.status == DownloadStatus.completed) {
      progress = 1.0;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (downloadItem.thumbnailUrl != null)
                  Image.network(downloadItem.thumbnailUrl!, width: 80, height: 45, fit: BoxFit.cover)
                else
                  Container(width: 80, height: 45, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(downloadItem.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(_getStatusText(downloadItem.status), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                if (downloadItem.status == DownloadStatus.downloading)
                  IconButton(icon: const Icon(Icons.close), onPressed: onCancel),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatBytes(downloadItem.downloadedBytes), style: const TextStyle(fontSize: 10)),
                if (downloadItem.status == DownloadStatus.downloading)
                  Text("${formatBytes(downloadItem.speed.toInt())}/s", style: const TextStyle(fontSize: 10)),
                if (downloadItem.totalBytes != null)
                  Text(formatBytes(downloadItem.totalBytes!), style: const TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
