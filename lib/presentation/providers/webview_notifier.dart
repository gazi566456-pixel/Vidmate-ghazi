import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidmate_clone_app/domain/entities/stream_info.dart';
import 'package:vidmate_clone_app/presentation/providers/download_providers.dart';

class WebviewState {
  final String currentUrl;
  final bool isLoading;
  final List<StreamInfo> detectedMedia;
  final String? loadError;

  WebviewState({
    required this.currentUrl,
    this.isLoading = false,
    this.detectedMedia = const [],
    this.loadError,
  });

  WebviewState copyWith({
    String? currentUrl,
    bool? isLoading,
    List<StreamInfo>? detectedMedia,
    String? loadError,
  }) {
    return WebviewState(
      currentUrl: currentUrl ?? this.currentUrl,
      isLoading: isLoading ?? this.isLoading,
      detectedMedia: detectedMedia ?? this.detectedMedia,
      loadError: loadError ?? this.loadError,
    );
  }
}

class WebviewNotifier extends StateNotifier<WebviewState> {
  final Ref _ref;

  WebviewNotifier(this._ref) : super(WebviewState(currentUrl: "https://www.youtube.com")) {
    _ref.read(webviewSnifferServiceProvider).detectedMediaStream.listen((media) {
      if (!state.detectedMedia.any((m) => m.url == media.url)) {
        state = state.copyWith(detectedMedia: [...state.detectedMedia, media]);
      }
    });
  }

  Future<void> loadUrl(String url) async {
    state = state.copyWith(currentUrl: url, isLoading: true, detectedMedia: []);
    await _ref.read(webviewSnifferServiceProvider).loadUrl(url);
    state = state.copyWith(isLoading: false);
  }

  Future<void> goBack() async {
    await _ref.read(webviewSnifferServiceProvider).goBack();
  }

  Future<void> reload() async {
    await _ref.read(webviewSnifferServiceProvider).reload();
  }

  Future<void> clearCookies() async {
    await _ref.read(webviewSnifferServiceProvider).clearCookies();
  }

  void removeDetectedMedia(StreamInfo media) {
    state = state.copyWith(detectedMedia: state.detectedMedia.where((m) => m.url != media.url).toList());
  }

  void downloadDetectedMedia(StreamInfo media) {
    // Logic to start download from detected media
  }

  @override
  void dispose() {
    _ref.read(webviewSnifferServiceProvider).dispose();
    super.dispose();
  }
}

final webviewNotifierProvider = StateNotifierProvider<WebviewNotifier, WebviewState>((ref) {
  return WebviewNotifier(ref);
});
