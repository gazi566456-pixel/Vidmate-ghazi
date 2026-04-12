import 'package:flutter/material.dart';
import 'package:vidmate_clone_app/domain/entities/stream_info.dart';

class DetectedMediaListWidget extends StatelessWidget {
  final List<StreamInfo> detectedMedia;
  final Function(StreamInfo) onDownload;
  final Function(StreamInfo) onDismiss;

  const DetectedMediaListWidget({
    super.key,
    required this.detectedMedia,
    required this.onDownload,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: detectedMedia.length,
        itemBuilder: (context, index) {
          final media = detectedMedia[index];
          return ListTile(
            leading: Icon(media.type == StreamType.audio ? Icons.music_note : Icons.movie),
            title: Text(media.url, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(media.format ?? 'Unknown format'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.download), onPressed: () => onDownload(media)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => onDismiss(media)),
              ],
            ),
          );
        },
      ),
    );
  }
}
