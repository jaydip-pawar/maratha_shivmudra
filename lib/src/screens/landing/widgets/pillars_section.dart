import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

import 'package:maratha_shivmudra/core/theme/theme_service.dart';

class PillarsSection extends StatelessWidget {
  final bool? isDark;

  const PillarsSection({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDark ?? ThemeService.instance.isDarkMode(context);
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final isMarathi = context.isMarathi;

    final pillars = [
      _PillarData(
        icon: Icons.local_hospital_rounded,
        title: context.l10n.pillar_health_title,
        description: context.l10n.pillar_health_desc,
        tag: isMarathi ? 'आरोग्य सेवा' : 'Health & Aid',
        accentColor: AppColors.healthRed,
      ),
      _PillarData(
        icon: Icons.school_rounded,
        title: context.l10n.pillar_education_title,
        description: context.l10n.pillar_education_desc,
        tag: isMarathi ? 'शिक्षण सहाय्य' : 'Education',
        accentColor: AppColors.educationBlue,
      ),
      _PillarData(
        icon: Icons.fort_rounded,
        title: context.l10n.pillar_forts_title,
        description: context.l10n.pillar_forts_desc,
        tag: isMarathi ? 'दुर्ग संवर्धन' : 'Fort Heritage',
        accentColor: AppColors.saffron,
      ),
      _PillarData(
        icon: Icons.brightness_high_rounded,
        title: context.l10n.pillar_dharma_title,
        description: context.l10n.pillar_dharma_desc,
        tag: isMarathi ? 'धर्म व संस्कृती' : 'Dharma & Culture',
        accentColor: AppColors.gold,
      ),
      _PillarData(
        icon: Icons.auto_stories_rounded,
        title: context.l10n.pillar_history_title,
        description: context.l10n.pillar_history_desc,
        tag: isMarathi ? 'सत्य इतिहास' : 'True History',
        accentColor: AppColors.historyAmber,
      ),
      _PillarData(
        icon: Icons.trending_up_rounded,
        title: context.l10n.pillar_entrepreneurship_title,
        description: context.l10n.pillar_entrepreneurship_desc,
        tag: isMarathi ? 'उद्योग विकास' : 'Entrepreneurship',
        accentColor: AppColors.entrepreneurshipGreen,
      ),
      _PillarData(
        icon: Icons.volunteer_activism_rounded,
        title: context.l10n.pillar_social_service_title,
        description: context.l10n.pillar_social_service_desc,
        tag: isMarathi ? 'आपत्ती निवारण' : 'Disaster Relief',
        accentColor: AppColors.reliefPurple,
      ),
    ];

    return Container(
      width: double.infinity,
      color: isDarkMode ? AppColors.darkBg : AppColors.lightBg,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 40 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Title
              Text(
                context.l10n.pillars_title,
                textAlign: TextAlign.center,
                style: AppTypography.sectionTitle(isMobile, isDark: isDarkMode),
              ),

              const SizedBox(height: 8),

              // Subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  context.l10n.pillars_subtitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.sectionSubtitle(isMobile, isDark: isDarkMode),
                ),
              ),

              const SizedBox(height: 40),

              // Grid of 7 Pillars
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = isMobile
                      ? 1
                      : (isTablet || constraints.maxWidth < 900 ? 2 : 3);

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: pillars.map((pillar) {
                      final itemWidth = isMobile
                          ? constraints.maxWidth
                          : (constraints.maxWidth -
                                  (crossAxisCount - 1) * 20) /
                              crossAxisCount;

                      return SizedBox(
                        width: itemWidth,
                        child: _PillarCard(pillar: pillar, isDark: isDarkMode),
                      );
                    }).toList(),
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

class _PillarData {
  final IconData icon;
  final String title;
  final String description;
  final String tag;
  final Color accentColor;

  const _PillarData({
    required this.icon,
    required this.title,
    required this.description,
    required this.tag,
    required this.accentColor,
  });
}

class _PillarCard extends StatefulWidget {
  final _PillarData pillar;
  final bool isDark;

  const _PillarCard({required this.pillar, this.isDark = true});

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.pillar;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
          constraints: const BoxConstraints(minHeight: 210),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark
                ? (_isHovered ? AppColors.cardDarkElevated : AppColors.cardDark)
                : (_isHovered ? AppColors.lightSurfaceElevated : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? p.accentColor.withValues(alpha: 0.8)
                  : (isDark ? AppColors.darkBorder : AppColors.lightCardBorder),
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? p.accentColor.withValues(alpha: isDark ? 0.2 : 0.15)
                    : (isDark
                        ? AppColors.black.withValues(alpha: 0.3)
                        : AppColors.goldShadow.withValues(alpha: 0.08)),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Icon + Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: p.accentColor.withValues(alpha: isDark ? 0.15 : 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: p.accentColor.withValues(alpha: isDark ? 0.4 : 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      p.icon,
                      color: p.accentColor,
                      size: 24,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.white.withValues(alpha: 0.05)
                          : p.accentColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? AppColors.white.withValues(alpha: 0.1)
                            : p.accentColor.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      p.tag,
                      style: AppTypography.cardTag(isDark: isDark),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Pillar Title
              Text(
                p.title,
                style: AppTypography.cardTitle(isDark: isDark),
              ),

              const SizedBox(height: 10),

              // Description
              Text(
                p.description,
                style: AppTypography.cardBody(isDark: isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
