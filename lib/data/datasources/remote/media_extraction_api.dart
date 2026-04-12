import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:vidmate_clone_app/domain/entities/download_media_info.dart';
import 'package:vidmate_clone_app/domain/entities/stream_info.dart';
import 'package:vidmate_clone_app/core/errors/exceptions.dart';

class MediaExtractionApi {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<DownloadMediaInfo> extractMediaInfo(String url) async {
    if (url.contains('youtube.com') || url.contains('youtu.be')) {
      return _extractYoutubeInfo(url);
    } else {
      // For other sites, we'd use a generic extractor or webview sniffer
      throw UnsupportedPlatformException(message: "Platform not supported for direct extraction.");
    }
  }

  Future<DownloadMediaInfo> _extractYoutubeInfo(String url) async {
    try {
      final video = await _yt.videos.get(url);
      final manifest = await _yt.videos.streamsClient.getManifest(video.id);
      
      final List<StreamInfo> streams = [];
      
      // Add muxed streams (video + audio)
      for (var stream in manifest.muxed) {
        streams.add(StreamInfo(
          url: stream.url.toString(),
          type: StreamType.muxed,
          quality: stream.videoQuality.label,
          format: stream.container.name,
          size: stream.size.totalBytes,
        ));
      }

      // Add audio-only streams
      for (var stream in manifest.audioOnly) {
        streams.add(StreamInfo(
          url: stream.url.toString(),
          type: StreamType.audio,
          quality: "${stream.bitrate.kbps.toInt()}kbps",
          format: stream.container.name,
          size: stream.size.totalBytes,
        ));
      }

      return DownloadMediaInfo(
        id: video.id.value,
        title: video.title,
        author: video.author,
        thumbnailUrl: video.thumbnails.highResUrl,
        duration: video.duration,
        streams: streams,
        sourceUrl: url,
      );
    } catch (e) {
      throw ExtractionFailedException(message: "Failed to extract YouTube info: $e");
    }
  }

  void dispose() {
    _yt.close();
  }
}
