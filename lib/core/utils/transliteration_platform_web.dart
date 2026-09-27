import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:web/web.dart' as web;

int _cbId = 0;

/// Web implementation using JSONP script injection to bypass browser CORS
Future<List<String>> fetchPlatformWebJsonp(String word) async {
  final completer = Completer<List<String>>();
  final cbName = '_gitCb_${DateTime.now().millisecondsSinceEpoch}_${_cbId++}';

  web.HTMLScriptElement? scriptEl;

  void cleanup() {
    try {
      // In JSONP, NEVER delete the callback immediately upon completion or timeout!
      // If a network response arrives late, calling an undefined function throws `ReferenceError`.
      // Instead, replace it with a no-op function so late executions do nothing harmlessly.
      final noop = (() {}).toJS;
      try {
        globalContext.setProperty(cbName.toJS, noop);
      } catch (_) {}
      try {
        web.window.setProperty(cbName.toJS, noop);
      } catch (_) {}

      scriptEl?.remove();

      // Delay actual removal of the global callback by 60 seconds
      Future.delayed(const Duration(seconds: 60), () {
        try {
          globalContext.delete(cbName.toJS);
          web.window.delete(cbName.toJS);
        } catch (_) {}
      });
    } catch (_) {}
  }

  final jsCallback = ((JSAny? data) {
    if (!completer.isCompleted) {
      try {
        if (data != null) {
          final jsJson = web.window.getProperty('JSON'.toJS)! as JSObject;
          final jsStr = jsJson.callMethod<JSString>('stringify'.toJS, data);
          final dynamic parsed = jsonDecode(jsStr.toDart);
          if (parsed is List && parsed.length > 1 && parsed[1] is List) {
            final list1 = parsed[1] as List;
            if (list1.isNotEmpty && list1[0] is List) {
              final wordInfo = list1[0] as List;
              if (wordInfo.length > 1 && wordInfo[1] is List) {
                final list = (wordInfo[1] as List)
                    .map((e) => e.toString())
                    .toList();
                completer.complete(list);
                cleanup();
                return;
              }
            }
          }
        }
      } catch (_) {}
      completer.complete([]);
      cleanup();
    }
  }).toJS;

  try {
    globalContext.setProperty(cbName.toJS, jsCallback);
    web.window.setProperty(cbName.toJS, jsCallback);

    final script = web.document.createElement('script') as web.HTMLScriptElement;
    script.src =
        'https://inputtools.google.com/request?text=${Uri.encodeComponent(word)}&itc=mr-t-i0-und&num=5&cb=$cbName';
    script.async = true;

    script.onerror = ((web.Event e) {
      if (!completer.isCompleted) {
        completer.complete([]);
        cleanup();
      }
    }).toJS;

    scriptEl = script;
    web.document.head?.appendChild(script);

    // Timeout safety
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (!completer.isCompleted) {
        completer.complete([]);
        cleanup();
      }
    });
  } catch (_) {
    if (!completer.isCompleted) {
      completer.complete([]);
      cleanup();
    }
  }

  return completer.future;
}
