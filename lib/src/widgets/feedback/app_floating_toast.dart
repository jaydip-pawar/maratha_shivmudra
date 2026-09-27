import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

/// Semantic types for [AppFloatingToast].
enum ToastType {
  success,
  error,
  info,
  warning,
}

/// Screen positioning for [AppFloatingToast].
enum ToastPosition {
  bottom,
  top,
}

/// A modern, luxurious, floating toast notification system for Flutter.
///
/// Anchored on top of all modal barriers, dialogs, and popovers using
/// the root [Overlay], featuring glassmorphism, glowing accents, smooth
/// slide-in animation, progress indicator, hover pause, and swipe-to-dismiss.
class AppFloatingToast {
  static OverlayEntry? _currentEntry;
  static _FloatingToastWidgetState? _currentState;

  /// Show a floating success toast (Emerald theme)
  static void showSuccess(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(milliseconds: 3200),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title,
      type: ToastType.success,
      duration: duration,
      position: position,
    );
  }

  /// Show a floating error toast (Crimson theme)
  static void showError(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(milliseconds: 4200),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title,
      type: ToastType.error,
      duration: duration,
      position: position,
    );
  }

  /// Show a floating info toast (Saffron/Gold theme)
  static void showInfo(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(milliseconds: 3200),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title,
      duration: duration,
      position: position,
    );
  }

  /// Show a floating warning toast (Amber theme)
  static void showWarning(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(milliseconds: 3600),
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      title: title,
      type: ToastType.warning,
      duration: duration,
      position: position,
    );
  }

  /// Display a floating toast anchored in the root overlay.
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    ToastType type = ToastType.info,
    Duration duration = const Duration(milliseconds: 3200),
    ToastPosition position = ToastPosition.bottom,
  }) {
    // Dismiss any previously showing toast
    dismiss();

    final overlayState =
        Overlay.maybeOf(context, rootOverlay: true) ?? Overlay.maybeOf(context);
    if (overlayState == null) return;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) {
        return _FloatingToastWidget(
          message: message,
          type: type,
          duration: duration,
          position: position,
          onDismiss: () {
            if (_currentEntry == entry) {
              _currentEntry?.remove();
              _currentEntry = null;
              _currentState = null;
            }
          },
          onStateCreated: (state) {
            _currentState = state;
          },
          title: title,
        );
      },
    );

    _currentEntry = entry;
    overlayState.insert(entry);
  }

  /// Dismiss the active toast immediately with animation
  static void dismiss() {
    _currentState?.dismissWithAnimation();
    if (_currentEntry != null) {
      _currentEntry?.remove();
      _currentEntry = null;
      _currentState = null;
    }
  }
}

class _FloatingToastWidget extends StatefulWidget {
  const _FloatingToastWidget({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
    required this.onStateCreated,
    this.title,
    this.position = ToastPosition.bottom,
  });

  final String message;
  final String? title;
  final ToastType type;
  final Duration duration;
  final VoidCallback onDismiss;
  final ValueChanged<_FloatingToastWidgetState> onStateCreated;
  final ToastPosition position;

  @override
  State<_FloatingToastWidget> createState() => _FloatingToastWidgetState();
}

class _FloatingToastWidgetState extends State<_FloatingToastWidget>
    with TickerProviderStateMixin {
  late final AnimationController _animController;
  late final AnimationController _progressController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    widget.onStateCreated(this);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
      reverseDuration: const Duration(milliseconds: 260),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final isBottom = widget.position == ToastPosition.bottom;
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, isBottom ? 0.75 : -0.75),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _animController.forward();
    _progressController.forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dismissWithAnimation();
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void dismissWithAnimation() {
    if (_isDismissing || !mounted) return;
    _isDismissing = true;
    _animController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  void _pauseTimer() {
    if (_progressController.isAnimating) {
      _progressController.stop();
    }
  }

  void _resumeTimer() {
    if (!_progressController.isAnimating && !_isDismissing) {
      _progressController.forward();
    }
  }

  Color get _accentColor {
    switch (widget.type) {
      case ToastType.success:
        return AppColors.success;
      case ToastType.error:
        return AppColors.error;
      case ToastType.warning:
        return AppColors.warning;
      case ToastType.info:
        return AppColors.saffron;
    }
  }

  IconData get _icon {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle_rounded;
      case ToastType.error:
        return Icons.error_outline_rounded;
      case ToastType.warning:
        return Icons.warning_amber_rounded;
      case ToastType.info:
        return Icons.auto_awesome_rounded;
    }
  }

  List<Color> get _bgGradient {
    switch (widget.type) {
      case ToastType.success:
        return const [AppColors.toastSuccessGradStart, AppColors.toastSuccessGradEnd];
      case ToastType.error:
        return const [AppColors.toastErrorGradStart, AppColors.toastErrorGradEnd];
      case ToastType.warning:
        return const [AppColors.toastWarningGradStart, AppColors.toastWarningGradEnd];
      case ToastType.info:
        return const [AppColors.toastInfoGradStart, AppColors.toastInfoGradEnd];
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accentColor;
    final isBottom = widget.position == ToastPosition.bottom;
    final alignment = isBottom ? Alignment.bottomCenter : Alignment.topCenter;
    final padding = isBottom
        ? EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom + 24.0,
            left: 16,
            right: 16,
          )
        : EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 16.0,
            left: 16,
            right: 16,
          );

    return SafeArea(
      top: !isBottom,
      bottom: isBottom,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: MouseRegion(
                  onEnter: (_) => _pauseTimer(),
                  onExit: (_) => _resumeTimer(),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: accent.withValues(alpha: 0.32),
                              blurRadius: 28,
                              offset: Offset(0, isBottom ? -4 : 10),
                            ),
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.75),
                              blurRadius: 20,
                              offset: Offset(0, isBottom ? -2 : 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: _bgGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: accent.withValues(alpha: 0.65),
                                  width: 1.3,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        // Left Icon Badge
                                        Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: accent.withValues(
                                              alpha: 0.18,
                                            ),
                                            border: Border.all(
                                              color: accent.withValues(
                                                alpha: 0.45,
                                              ),
                                              width: 1.2,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              _icon,
                                              size: 20,
                                              color: accent,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        // Title & Message Content
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (widget.title != null &&
                                                  widget.title!.isNotEmpty) ...[
                                                Text(
                                                  widget.title!,
                                                  style: TextStyle(
                                                    fontFamily: AppTypography
                                                        .fontFamily,
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: accent,
                                                    letterSpacing: 0.2,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                              ],
                                              Text(
                                                widget.message,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      AppTypography.fontFamily,
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textPrimary,
                                                  height: 1.35,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),

                                        // Close Button
                                        Material(
                                          color: AppColors.transparent,
                                          child: InkWell(
                                            onTap: dismissWithAnimation,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Icon(
                                                Icons.close_rounded,
                                                size: 18,
                                                color: AppColors.white.withValues(
                                                  alpha: 0.65,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Thin bottom auto-dismiss progress bar
                                  AnimatedBuilder(
                                    animation: _progressController,
                                    builder: (context, child) {
                                      final remaining =
                                          1.0 - _progressController.value;
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: FractionallySizedBox(
                                          widthFactor: remaining.clamp(
                                            0.0,
                                            1.0,
                                          ),
                                          child: Container(
                                            height: 2.2,
                                            decoration: BoxDecoration(
                                              color: accent.withValues(
                                                alpha: 0.85,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
