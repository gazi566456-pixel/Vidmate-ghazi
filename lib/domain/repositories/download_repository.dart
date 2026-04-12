import 'package:vidmate_clone_app/data/repositories/download_repository_impl.dart';
import 'package:vidmate_clone_app/domain/entities/download_media_info.dart';
import 'package:vidmate_clone_app/domain/entities/stream_info.dart';

abstract class DownloadRepository {
  Stream<DownloadItem> get downloadUpdateStream;
  List<DownloadItem> get activeDownloads;
  List<DownloadItem> get completedDownloads;

  Future<void> startDownload(DownloadMediaInfo mediaInfo, StreamInfo selectedStream);
  Future<void> pauseDownload(String id);
  Future<void> resumeDownload(String id);
  Future<void> cancelDownload(String id);
  Future<void> removeDownload(String id, {bool deleteFile = true});
  DownloadItem? getDownloadItem(String id);
}
