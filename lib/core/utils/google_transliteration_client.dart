import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'transliteration_platform_stub.dart'
    if (dart.library.js_interop) 'transliteration_platform_web.dart';

class GoogleTransliterationClient {
  static Future<List<String>> getCandidates(String word) async {
    if (word.trim().isEmpty) return [];

    if (kIsWeb) {
      final webList = await fetchPlatformWebJsonp(word.trim());
      if (webList.isNotEmpty) return webList;
    }

    return _fetchHttp(word.trim());
  }

  static Future<List<String>> _fetchHttp(String word) async {
    try {
      final uri = Uri.parse(
        'https://inputtools.google.com/request?text=${Uri.encodeComponent(word)}&itc=mr-t-i0-und&num=5',
      );
      final res = await http
          .get(uri)
          .timeout(const Duration(milliseconds: 2000));
      if (res.statusCode == 200) {
        final dynamic data = jsonDecode(res.body);
        if (data is List && data.length > 1 && data[1] is List) {
          final list1 = data[1] as List;
          if (list1.isNotEmpty && list1[0] is List) {
            final wordInfo = list1[0] as List;
            if (wordInfo.length > 1 && wordInfo[1] is List) {
              return (wordInfo[1] as List).map((e) => e.toString()).toList();
            }
          }
        }
      }
    } catch (_) {}
    return [];
  }
}
