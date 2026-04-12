import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidmate_clone_app/presentation/providers/webview_notifier.dart';
import 'package:vidmate_clone_app/presentation/widgets/detected_media_list_widget.dart';
import 'package:vidmate_clone_app/presentation/providers/download_providers.dart';

class WebviewScreen extends ConsumerStatefulWidget {
  const WebviewScreen({super.key});

  @override
  ConsumerState<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends ConsumerState<WebviewScreen> {
  late TextEditingController _urlController;
  Widget? _webViewWidget;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(
      text: ref.read(webviewNotifierProvider).currentUrl,
    );
    _webViewWidget = ref.read(webviewSnifferServiceProvider).createWebView();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final webviewState = ref.watch(webviewNotifierProvider);
    final webviewNotifier = ref.read(webviewNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(Uri.parse(webviewState.currentUrl).host.replaceAll('www.', '')),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: webviewNotifier.reload, tooltip: 'Reload'),
          IconButton(icon: const Icon(Icons.home), onPressed: () => webviewNotifier.loadUrl("https://www.youtube.com"), tooltip: 'Home'),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: webviewNotifier.goBack,
                ),
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: 'Enter URL or search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      hintStyle: const TextStyle(fontSize: 13),
                    ),
                    onSubmitted: (url) {
                      webviewNotifier.loadUrl(url);
                    },
                    style: const TextStyle(fontSize: 14),
                    readOnly: webviewState.isLoading,
                  ),
                ),
              ],
            ),
          ),
          if (webviewState.isLoading) const LinearProgressIndicator(),
          Expanded(
            child: _webViewWidget ?? const Center(child: CircularProgressIndicator()),
          ),
          if (webviewState.detectedMedia.isNotEmpty && webviewState.loadError == null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DetectedMediaListWidget(
                detectedMedia: webviewState.detectedMedia,
                onDownload: (media) => webviewNotifier.downloadDetectedMedia(media),
                onDismiss: (media) => webviewNotifier.removeDetectedMedia(media),
              ),
            ),
          if (webviewState.loadError != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error loading page: ${webviewState.loadError}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
