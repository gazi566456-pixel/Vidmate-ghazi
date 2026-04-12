import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vidmate_clone_app/domain/entities/stream_info.dart';

class WebviewSnifferService {
  final StreamController<StreamInfo> _detectedMediaController = StreamController<StreamInfo>.broadcast();
  Stream<StreamInfo> get detectedMediaStream => _detectedMediaController.stream;

  InAppWebViewController? _webViewController;

  InAppWebView createWebView() {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("https://www.youtube.com")),
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        useShouldInterceptRequest: true,
      ),
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      shouldInterceptRequest: (controller, request) async {
        final url = request.url.toString();
        if (url.contains(".m3u8") || url.contains(".mp4") || url.contains(".mp3")) {
          _detectedMediaController.add(StreamInfo(
            url: url,
            type: url.contains(".m3u8") ? StreamType.m3u8 : (url.contains(".mp3") ? StreamType.audio : StreamType.video),
            format: url.split('.').last.split('?').first,
          ));
        }
        return null;
      },
    );
  }

  Future<void> loadUrl(String url) async {
    if (_webViewController != null) {
      await _webViewController!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
    }
  }

  Future<void> goBack() async {
    if (_webViewController != null && await _webViewController!.canGoBack()) {
      await _webViewController!.goBack();
    }
  }

  Future<void> reload() async {
    if (_webViewController != null) {
      await _webViewController!.reload();
    }
  }

  Future<void> clearCookies() async {
    await CookieManager.instance().deleteAllCookies();
  }

  void dispose() {
    _detectedMediaController.close();
  }
}
