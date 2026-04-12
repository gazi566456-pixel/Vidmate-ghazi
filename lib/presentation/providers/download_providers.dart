import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidmate_clone_app/core/helpers/ffmpeg_service.dart';
import 'package:vidmate_clone_app/data/datasources/remote/media_extraction_api.dart';
import 'package:vidmate_clone_app/data/datasources/remote/webview_sniffer.dart';
import 'package:vidmate_clone_app/data/repositories/download_repository_impl.dart';
import 'package:vidmate_clone_app/domain/repositories/download_repository.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final ffmpegServiceProvider = Provider<FFmpegService>((ref) => FFmpegService());

final downloadRepositoryProvider = Provider<DownloadRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final ffmpegService = ref.watch(ffmpegServiceProvider);
  return DownloadRepositoryImpl(dio, ffmpegService);
});

final mediaExtractionApiProvider = Provider<MediaExtractionApi>((ref) => MediaExtractionApi());

final webviewSnifferServiceProvider = Provider<WebviewSnifferService>((ref) => WebviewSnifferService());

final downloadUpdateStreamProvider = StreamProvider<DownloadItem>((ref) {
  final repository = ref.watch(downloadRepositoryProvider);
  return repository.downloadUpdateStream;
});

final downloadDirectoryProvider = StateProvider<String?>((ref) => null);
final wifiOnlyDownloadProvider = StateProvider<bool>((ref) => false);
