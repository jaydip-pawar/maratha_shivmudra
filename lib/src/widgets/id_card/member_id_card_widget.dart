import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MemberIdCardWidget extends StatelessWidget {
  final MemberProfile profile;
  final bool isFrontOnly;

  const MemberIdCardWidget({
    super.key,
    required this.profile,
    this.isFrontOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final memberId = profile.memberId ?? 'MSM-${profile.districtCode}-00000';
    final qrData = 'https://marathashivmudra.web.app/verify?id=$memberId';

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth.clamp(320.0, 480.0);
        final cardHeight = cardWidth * 0.62;

        return RepaintBoundary(
          child: Container(
            width: cardWidth,
            height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF200A0A),
                Color(0xFF140808),
                Color(0xFF0F0505),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: AppColors.gold,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.saffron.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                // Background Watermark Logo
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Opacity(
                    opacity: 0.08,
                    child: Image.asset(
                      AppAssets.logo,
                      width: cardHeight * 0.9,
                      height: cardHeight * 0.9,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Card Layout
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.logo,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'मराठा शिवमुद्रा प्रतिष्ठान',
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.goldLight,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  profile.isOfficial && (profile.officialFullTitleMr != null || profile.officialRoleMr != null)
                                      ? '🎖️ ${profile.officialFullTitleMr ?? profile.officialRoleMr}'
                                      : (profile.isOfficialManager && profile.designation.isNotEmpty
                                          ? '👑 ${profile.designation}'
                                          : 'अधिकृत सभासद ओळखपत्र'),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: profile.isOfficial || profile.isOfficialManager
                                        ? AppColors.goldLight
                                        : AppColors.saffronLight,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // Saffron/Gold District or HQ / Core Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: profile.isOfficial || profile.isOfficialManager
                                  ? const Color(0xFFB8860B)
                                  : AppColors.saffron,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              profile.isOfficial && profile.officialLevel == 'core'
                                  ? 'राज्य'
                                  : (profile.isOfficial && profile.officialLevel == 'vibhag'
                                      ? 'विभाग'
                                      : (profile.isOfficialManager && profile.roleType == 'core_committee'
                                          ? 'HQ'
                                          : profile.districtCode)),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),
                      const Divider(color: AppColors.gold, height: 1, thickness: 0.8),
                      const SizedBox(height: 8),

                      // Member Body Details
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Member Photo
                            _buildPhotoWidget(cardHeight * 0.45),
                            const SizedBox(width: 12),

                            // Member Info Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Member ID Chip
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.saffron.withValues(alpha: 0.15),
                                      border: Border.all(
                                        color: AppColors.gold.withValues(alpha: 0.5),
                                        width: 0.8,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'ID: $memberId',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.goldLight,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),

                                  // Name
                                  Text(
                                    profile.fullNameEn.isNotEmpty
                                        ? profile.fullNameEn
                                        : profile.fullNameMr,
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  // District & Taluka
                                  Text(
                                    '${profile.district} • ${profile.subDistrict.isNotEmpty ? profile.subDistrict : "महाराष्ट्र"}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  // Blood Group & Issue Date
                                  Row(
                                    children: [
                                      if (profile.bloodGroup.isNotEmpty) ...[
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(
                                              color: Colors.redAccent.withValues(alpha: 0.6),
                                              width: 0.6,
                                            ),
                                          ),
                                          child: Text(
                                            '🩸 ${profile.bloodGroup}',
                                            style: const TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                      Flexible(
                                        child: Text(
                                          'नोंदणी: ${_formatDate(profile.cardIssuedDate ?? DateTime.now())}',
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: AppColors.textMuted,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Official QR Code
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: AppColors.gold,
                                      width: 1,
                                    ),
                                  ),
                                  child: QrImageView(
                                    data: qrData,
                                    version: QrVersions.auto,
                                    size: cardHeight * 0.38,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'स्कॅन करा',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: AppColors.goldLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (profile.isOfficial && (profile.officialFullTitleMr != null || profile.officialRoleMr != null)) ...[
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6B1200),
                                Color(0xFFB8860B),
                                Color(0xFF6B1200),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.gold, width: 0.8),
                          ),
                          child: Text(
                            'पदाधिकारी: ${profile.officialFullTitleMr ?? profile.officialRoleMr}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ] else
                        const SizedBox(height: 4),

                      // Footer Tagline
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '॥ धर्मो रक्षति रक्षितः ॥  •  जयोस्तु मराठा शिवमुद्रा',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 8.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.goldLight,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        );
      },
    );
  }

  Widget _buildPhotoWidget(double size) {
    if (profile.photoBase64 != null && profile.photoBase64!.isNotEmpty) {
      try {
        final cleanBase64 = profile.photoBase64!.contains(',')
            ? profile.photoBase64!.split(',').last
            : profile.photoBase64!;
        final bytes = base64Decode(cleanBase64);
        return Container(
          width: size * 0.85,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.gold, width: 1.5),
            image: DecorationImage(
              image: MemoryImage(bytes),
              fit: BoxFit.cover,
            ),
          ),
        );
      } catch (_) {}
    }

    // Default Avatar
    return Container(
      width: size * 0.85,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gold, width: 1.5),
      ),
      child: const Center(
        child: Icon(
          Icons.person_rounded,
          color: AppColors.goldLight,
          size: 30,
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }
}
