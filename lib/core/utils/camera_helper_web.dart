import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:web/web.dart' as web;

/// Web implementation that opens a live browser camera dialog,
/// requests browser camera permissions, shows a live viewfinder,
/// and allows capturing and confirming a photo.
Future<Uint8List?> captureBrowserCamera(BuildContext context) async {
  return showDialog<Uint8List>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const _WebCameraCaptureDialog(),
  );
}

class _WebCameraCaptureDialog extends StatefulWidget {
  const _WebCameraCaptureDialog();

  @override
  State<_WebCameraCaptureDialog> createState() => _WebCameraCaptureDialogState();
}

class _WebCameraCaptureDialogState extends State<_WebCameraCaptureDialog> {
  web.MediaStream? _mediaStream;
  web.HTMLVideoElement? _videoElement;
  String? _viewType;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isFrontCamera = true;
  Uint8List? _capturedBytes;

  @override
  void initState() {
    super.initState();
    _startCamera();
  }

  Future<void> _startCamera() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    _stopCamera();

    try {
      web.MediaStream? stream;

      // 1. Try with preferred facingMode constraints
      try {
        final constraints = web.MediaStreamConstraints(
          video: {
            'facingMode': _isFrontCamera ? 'user' : 'environment',
            'width': {'ideal': 1280},
            'height': {'ideal': 720},
          }.jsify()!,
          audio: false.toJS,
        );
        stream = await web.window.navigator.mediaDevices
            .getUserMedia(constraints)
            .toDart;
      } catch (_) {
        // Fallback for desktop/laptops or browsers that reject facingMode
        final basicConstraints = web.MediaStreamConstraints(
          video: true.toJS,
          audio: false.toJS,
        );
        stream = await web.window.navigator.mediaDevices
            .getUserMedia(basicConstraints)
            .toDart;
      }

      if (!mounted) {
        for (final track in stream.getTracks().toDart) {
          track.stop();
        }
        return;
      }

      _mediaStream = stream;

      // 2. Create and configure HTML video element
      final video = web.document.createElement('video') as web.HTMLVideoElement
        ..autoplay = true
        ..playsInline = true
        ..muted = true
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover';

      if (_isFrontCamera) {
        video.style.transform = 'scaleX(-1)';
      } else {
        video.style.transform = 'none';
      }

      video
        ..srcObject = stream
        ..play();
      _videoElement = video;

      // 3. Register unique view type for Flutter platform view
      final viewType = 'web-camera-${DateTime.now().microsecondsSinceEpoch}';
      ui_web.platformViewRegistry.registerViewFactory(
        viewType,
        (int viewId, {Object? params}) => video,
      );

      setState(() {
        _viewType = viewType;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage =
            'कॅमेरा सुरू करता आला नाही.\nकृपया ब्राउझरमध्ये कॅमेरा परवानगी (Permission) तपासा किंवा कॅमेरा चालू असल्याची खात्री करा.';
      });
    }
  }

  void _capturePhoto() {
    final video = _videoElement;
    if (video == null) return;

    try {
      final canvas =
          web.document.createElement('canvas') as web.HTMLCanvasElement;
      final videoWidth = video.videoWidth;
      final videoHeight = video.videoHeight;
      final width = videoWidth > 0 ? videoWidth : 640;
      final height = videoHeight > 0 ? videoHeight : 480;

      canvas
        ..width = width
        ..height = height;

      final ctx =
          canvas.getContext('2d')! as web.CanvasRenderingContext2D;

      if (_isFrontCamera) {
        // Mirror the canvas context so captured photo matches what user sees
        ctx
          ..translate(width, 0)
          ..scale(-1, 1);
      }

      ctx.drawImage(video, 0, 0, width, height);

      final dataUrl = canvas.toDataURL('image/jpeg', 0.88.toJS);
      final commaIndex = dataUrl.indexOf(',');
      final base64String =
          commaIndex != -1 ? dataUrl.substring(commaIndex + 1) : dataUrl;
      final bytes = base64Decode(base64String);

      setState(() {
        _capturedBytes = bytes;
      });

      // Immediately release hardware camera tracks once photo is captured
      _stopCamera();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('फोटो काढताना त्रुटी आली. कृपया पुन्हा प्रयत्न करा.'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  void _retakePhoto() {
    setState(() {
      _capturedBytes = null;
    });

    // Re-initialize live camera for retake
    _startCamera();
  }

  void _switchCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _capturedBytes = null;
    });
    _startCamera();
  }

  void _stopCamera() {
    try {
      _videoElement?.pause();
    } catch (_) {}

    if (_mediaStream != null) {
      try {
        final tracks = _mediaStream!.getTracks().toDart;
        for (final track in tracks) {
          try {
            track.stop();
          } catch (_) {}
        }
      } catch (_) {}
      try {
        final videoTracks = _mediaStream!.getVideoTracks().toDart;
        for (final track in videoTracks) {
          try {
            track.stop();
          } catch (_) {}
        }
      } catch (_) {}
      _mediaStream = null;
    }

    if (_videoElement != null) {
      try {
        final src = _videoElement!.srcObject;
        if (src != null && src is web.MediaStream) {
          final tracks = src.getTracks().toDart;
          for (final track in tracks) {
            try {
              track.stop();
            } catch (_) {}
          }
        }
      } catch (_) {}
      try {
        _videoElement!.srcObject = null;
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.darkBgHeroTop,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.darkBorder, width: 1.2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.camera_alt_rounded,
                          color: AppColors.saffron, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'कॅमेरा / Camera',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.textMuted),
                    onPressed: () {
                      _stopCamera();
                      Navigator.of(context).pop(null);
                    },
                    tooltip: 'बंद करा / Close',
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Viewfinder / Capture Box
              Container(
                width: double.infinity,
                height: 340,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _capturedBytes != null
                        ? AppColors.saffron
                        : AppColors.darkBorder,
                    width: 1.5,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildCameraBody(),
              ),
              const SizedBox(height: 16),

              // Bottom Actions
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppColors.saffron),
            SizedBox(height: 14),
            Text(
              'कॅमेरा सुरू होत आहे...\n(कृपया ब्राउझर परवानगी द्या)',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.videocam_off_rounded,
                  color: AppColors.errorColor, size: 44),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.saffron,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _startCamera,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('पुन्हा प्रयत्न करा'),
              ),
            ],
          ),
        ),
      );
    }

    // Platform view is ALWAYS kept mounted in the tree so the video stream never detaches
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_viewType != null)
          HtmlElementView(viewType: _viewType!),

        // Guide circle and Switch camera button (visible only in live camera mode)
        if (_capturedBytes == null && _viewType != null) ...[
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.saffron.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Material(
              color: AppColors.black.withValues(alpha: 0.6),
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Icons.cameraswitch_rounded,
                    color: AppColors.white, size: 20),
                tooltip: 'कॅमेरा बदला / Switch Camera',
                onPressed: _switchCamera,
              ),
            ),
          ),
        ],

        // Captured Photo Preview overlay (placed on top of the live video view)
        if (_capturedBytes != null)
          Positioned.fill(
            child: ColoredBox(
              color: AppColors.black,
              child: Image.memory(
                _capturedBytes!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomActions() {
    if (_errorMessage != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              _stopCamera();
              Navigator.of(context).pop(null);
            },
            child: const Text('रद्द करा / Cancel',
                style: TextStyle(color: AppColors.textMuted)),
          ),
        ],
      );
    }

    if (_capturedBytes != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.textMuted),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _retakePhoto,
            icon: const Icon(Icons.replay_rounded, size: 18),
            label: const Text('पुन्हा काढा / Retake'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.saffron,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              final bytes = _capturedBytes;
              _stopCamera();
              Navigator.of(context).pop(bytes);
            },
            icon: const Icon(Icons.check_rounded, size: 18),
            label: const Text('वापरा / Use Photo'),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (_isLoading || _errorMessage != null) ? null : _capturePhoto,
          child: Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.saffron, width: 3.5),
              color: AppColors.transparent,
            ),
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.saffron,
              ),
              child: const Icon(Icons.camera_alt_rounded,
                  color: AppColors.white, size: 28),
            ),
          ),
        ),
      ],
    );
  }
}
