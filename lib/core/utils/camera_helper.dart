import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/camera_helper_stub.dart'
    if (dart.library.js_interop) 'package:maratha_shivmudra/core/utils/camera_helper_web.dart';

class BrowserCameraHelper {
  /// Prompts browser for camera permissions, opens camera viewfinder dialog,
  /// and returns captured JPEG bytes.
  static Future<Uint8List?> capturePhoto(BuildContext context) async {
    if (kIsWeb) {
      return captureBrowserCamera(context);
    }
    return null;
  }
}
