import 'package:web/web.dart' as web;

/// Platform implementation for web browser opening URL
void openExternalUrl(String url) {
  try {
    web.window.open(url, '_blank');
  } catch (_) {}
}
