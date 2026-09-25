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
      web.window.delete(cbName.toJS);
      scriptEl?.remove();
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
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!completer.isCompleted) {
        completer.complete([]);
        cleanup();
      }
    });
  } catch (_) {
    if (!completer.isCompleted) {
      completer.complete([]);
    }
  }

  return completer.future;
}
