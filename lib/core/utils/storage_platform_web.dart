import 'package:web/web.dart' as web;

/// Platform implementation for web browser storage purge
void purgeBrowserStorage() {
  try {
    web.window.localStorage.clear();
    web.window.sessionStorage.clear();
  } catch (_) {}
}
