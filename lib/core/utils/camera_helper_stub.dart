import 'dart:typed_data';
import 'package:flutter/material.dart';

/// Stub implementation for non-web platforms (Native Android, iOS, Desktop)
Future<Uint8List?> captureBrowserCamera(BuildContext context) async {
  // On native platforms, ImagePicker(source: ImageSource.camera) handles camera directly
  return null;
}
