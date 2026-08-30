import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/authentication/auth_dialog.dart';
import 'package:maratha_shivmudra/src/screens/landing/widgets/shivmudra_emblem.dart';

import 'package:maratha_shivmudra/core/constants/styles.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onExploreTap;
  final VoidCallback? onContactTap;
  final VoidCallback? onPledgeTap;

  const HeroSection({
    super.key,
    this.onExploreTap,
    this.onContactTap,
    this.onPledgeTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppGradients.heroBackground,
      ),
      child: Stack(
        children: [
          // Background ambient glow circles
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.saffron.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withValues(alpha: 0.08),
              ),
            ),
          ),

          // Main Hero Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 48,
              vertical: isMobile ? 32 : 64,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isMobile || isTablet
                    ? Column(
                        children: [
                          _buildEmblem(size: isMobile ? 180 : 220),
                          const SizedBox(height: 32),
                          _buildTextContent(context, isMobile: true),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _buildTextContent(context, isMobile: false),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: _buildEmblem(size: 320),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmblem({required double size}) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: ShivmudraEmblem(size: size),
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Royal Shloka Badge
        GestureDetector(
          onTap: widget.onPledgeTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              gradient: AppGradients.badgeGradient,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.6),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🚩', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    context.l10n.hero_badge,
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    style: AppTypography.shlokaBadge(isMobile),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Organization Name
        Text(
          context.l10n.hero_org_name,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: AppTypography.orgName(isMobile),
        ),

        const SizedBox(height: 12),

        // Catchy Tagline
        ShaderMask(
          shaderCallback: (bounds) =>
              AppGradients.heroTextGradient.createShader(bounds),
          child: Text(
            context.l10n.hero_title,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: AppTypography.heroTagline(isMobile),
          ),
        ),

        const SizedBox(height: 16),

        // Subtitle / Mission Statement
        Text(
          context.l10n.hero_subtitle,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: AppTypography.heroSubtitle(isMobile),
        ),

        const SizedBox(height: 32),

        // Interactive Action Buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14,
          runSpacing: 12,
          children: [
            // Join as Member CTA
            ElevatedButton.icon(
              onPressed: () => AuthDialog.show(context),
              icon: const Icon(Icons.volunteer_activism,
                  size: 18, color: Colors.white),
              label: Text(
                context.l10n.hero_btn_join,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.saffron,
                elevation: 6,
                shadowColor: AppColors.saffron.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: AppColors.goldLight,
                    width: 1.2,
                  ),
                ),
              ),
            ),

            // Explore Initiatives CTA
            OutlinedButton.icon(
              onPressed: widget.onExploreTap,
              icon: const Icon(Icons.explore_outlined,
                  size: 18, color: AppColors.goldLight),
              label: Text(
                context.l10n.hero_btn_explore,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.goldLight,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.gold.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
