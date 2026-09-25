import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/core/routes/route_config.gr.dart';
import 'package:maratha_shivmudra/core/services/member_profile_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/main.dart';
import 'package:maratha_shivmudra/src/screens/profile/widgets/profile_content_view.dart';

/// Modal dialog and desktop floating popover for Profile.
class ProfileModalDialog extends StatefulWidget {
  final bool isCompact;
  final double? maxWidth;

  const ProfileModalDialog({
    super.key,
    this.isCompact = false,
    this.maxWidth,
  });

  /// Adaptive launcher based on device form factor
  static void showAdaptive(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 700) {
      // Mobile View: Open dedicated Full-Screen Profile Page
      context.router.push(const ProfileRoute());
    } else if (width < 1024) {
      // Tablet View: Open centered dialog
      showTablet(context);
    } else {
      // Desktop View: Open top-right floating dialog / popover
      showDesktopFloating(context);
    }
  }

  /// Tablet Modal Dialog
  static void showTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final dialogWidth = (width * 0.75).clamp(580.0, 720.0);
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: AppColors.black.withValues(alpha: 0.75),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ProfileModalDialog(
          isCompact: dialogWidth < 600,
          maxWidth: dialogWidth,
        ),
      ),
    );
  }

  /// Desktop Floating Popover anchored at top-right
  static void showDesktopFloating(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final dialogWidth = (width * 0.48).clamp(580.0, 720.0);
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 65, right: 24, bottom: 20),
            child: Material(
              color: Colors.transparent,
              child: ProfileModalDialog(
                isCompact: dialogWidth < 600,
                maxWidth: dialogWidth,
              ),
            ),
          ),
        );
      },
    );
  }

  // Backward-compatible show alias
  static void show(BuildContext context) => showAdaptive(context);

  @override
  State<ProfileModalDialog> createState() => _ProfileModalDialogState();
}

class _ProfileModalDialogState extends State<ProfileModalDialog> {
  String _userPhone = '';
  MemberProfile? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final ss = getIt<SecureStorage>();
    final phone = await ss.getMobileNumber();
    _userPhone = phone.trim();

    if (_userPhone.isEmpty) {
      if (mounted) {
        setState(() {
          _profile = null;
          _isLoading = false;
        });
      }
      return;
    }

    final p = await MemberProfileService.instance.getProfile(_userPhone);
    if (mounted) {
      setState(() {
        _profile = p ?? MemberProfile(phone: _userPhone);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveMaxWidth = widget.maxWidth ?? (widget.isCompact ? 480.0 : 700.0);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.88;

    return Container(
      width: effectiveMaxWidth,
      height: maxHeight,
      constraints: BoxConstraints(
        maxWidth: effectiveMaxWidth,
        maxHeight: maxHeight,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF160B0B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.saffron.withValues(alpha: 0.2),
            blurRadius: 30,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.9),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.saffron),
            )
          : ProfileContentView(
              initialProfile: _profile ?? MemberProfile(phone: _userPhone),
              isCompact: widget.isCompact,
              isFixedHeader: true,
              showCloseButton: true,
              onClose: () => Navigator.of(context).pop(),
              onProfileUpdated: _loadProfile,
            ),
    );
  }
}
