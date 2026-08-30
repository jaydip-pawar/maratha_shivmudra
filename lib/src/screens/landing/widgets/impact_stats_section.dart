import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/landing/services/landing_firebase_service.dart';

class ImpactStatsSection extends StatelessWidget {
  const ImpactStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppGradients.impactBackground,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.goldBorderSubtle,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 36 : 56,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                context.l10n.impact_title,
                textAlign: TextAlign.center,
                style: AppTypography.sectionTitle(isMobile),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.impact_subtitle,
                textAlign: TextAlign.center,
                style: AppTypography.sectionSubtitle(isMobile),
              ),
              const SizedBox(height: 36),

              // Dynamic Firestore StreamBuilder for Impact Stats
              StreamBuilder<SocialImpactModel>(
                stream: LandingFirebaseService.instance.getSocialImpactStream(),
                initialData: const SocialImpactModel(),
                builder: (context, snapshot) {
                  final data = snapshot.data ?? const SocialImpactModel();

                  final stats = [
                    _StatItem(
                      value: data.volunteers,
                      label: context.l10n.stat_volunteers,
                      icon: Icons.groups_rounded,
                      color: AppColors.saffronLight,
                    ),
                    _StatItem(
                      value: data.students,
                      label: context.l10n.stat_students,
                      icon: Icons.school_rounded,
                      color: AppColors.goldLight,
                    ),
                    _StatItem(
                      value: data.fortDrives,
                      label: context.l10n.stat_fort_drives,
                      icon: Icons.fort_rounded,
                      color: AppColors.coralOrange,
                    ),
                    _StatItem(
                      value: data.reliefDrives,
                      label: context.l10n.stat_relief_drives,
                      icon: Icons.health_and_safety_rounded,
                      color: AppColors.mintGreen,
                    ),
                    _StatItem(
                      value: data.districts,
                      label: context.l10n.stat_districts,
                      icon: Icons.location_on_rounded,
                      color: AppColors.locationBlue,
                    ),
                  ];

                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: stats
                        .map(
                          (stat) =>
                              _StatCard(stat: stat, isMobile: isMobile),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });
}

class _StatCard extends StatelessWidget {
  final _StatItem stat;
  final bool isMobile;

  const _StatCard({required this.stat, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? (MediaQuery.of(context).size.width - 48) / 2 : 200,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: stat.color.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: stat.color.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: stat.color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              stat.icon,
              color: stat.color,
              size: 26,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            stat.value,
            style: AppTypography.statValue(isMobile, stat.color),
          ),
          const SizedBox(height: 6),
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: AppTypography.statLabel,
          ),
        ],
      ),
    );
  }
}
