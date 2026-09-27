import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';
import 'package:maratha_shivmudra/src/screens/landing/services/landing_firebase_service.dart';

import 'package:maratha_shivmudra/core/theme/theme_service.dart';

class UpcomingEventsSection extends StatelessWidget {
  final bool? isDark;

  const UpcomingEventsSection({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDark ?? ThemeService.instance.isDarkMode(context);
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;
    final isMobile = width < 700;
    final isMarathi = context.isMarathi;

    return StreamBuilder<List<EventItemModel>>(
      stream: LandingFirebaseService.instance.getUpcomingEventsStream(),
      builder: (context, snapshot) {
        // If there are 0 upcoming events or data is empty/null, hide the section completely
        if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final colorPalette = [
          AppColors.saffron,
          AppColors.gold,
          AppColors.emeraldGreen,
          AppColors.coralOrange,
          AppColors.educationBlue,
        ];

        final displayEvents = snapshot.data!.asMap().entries.map((entry) {
          final index = entry.key;
          final e = entry.value;
          final title = isMarathi
              ? (e.titleMr.isNotEmpty ? e.titleMr : e.titleEn)
              : (e.titleEn.isNotEmpty ? e.titleEn : e.titleMr);
          final date = isMarathi
              ? (e.dateMr.isNotEmpty ? e.dateMr : e.dateEn)
              : (e.dateEn.isNotEmpty ? e.dateEn : e.dateMr);
          final loc = isMarathi
              ? (e.locationMr.isNotEmpty ? e.locationMr : e.locationEn)
              : (e.locationEn.isNotEmpty ? e.locationEn : e.locationMr);
          final desc = isMarathi
              ? (e.descriptionMr.isNotEmpty ? e.descriptionMr : e.descriptionEn)
              : (e.descriptionEn.isNotEmpty ? e.descriptionEn : e.descriptionMr);
          final cat = isMarathi
              ? (e.categoryMr.isNotEmpty ? e.categoryMr : e.categoryEn)
              : (e.categoryEn.isNotEmpty ? e.categoryEn : e.categoryMr);

          return _EventData(
            title: title,
            date: date,
            location: loc,
            description: desc,
            category: cat.isNotEmpty
                ? cat
                : (isMarathi ? 'दुर्ग संवर्धन' : 'Fort Heritage'),
            color: colorPalette[index % colorPalette.length],
          );
        }).toList();

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
                    context.l10n.events_title,
                    textAlign: TextAlign.center,
                    style: AppTypography.sectionTitle(isMobile, isDark: isDarkMode),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    context.l10n.events_subtitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.sectionSubtitle(isMobile, isDark: isDarkMode),
                  ),

                  const SizedBox(height: 40),

                  // Event Cards Layout
                  isDesktop
                      ? IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: displayEvents.map((e) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: _EventCard(
                                    event: e,
                                    isDesktopRow: true,
                                    isDark: isDarkMode,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : Column(
                          children: displayEvents
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 20),
                                  child: _EventCard(
                                    event: e,
                                    isDesktopRow: false,
                                    isDark: isDarkMode,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EventData {
  final String title;
  final String date;
  final String location;
  final String description;
  final String category;
  final Color color;

  const _EventData({
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.category,
    required this.color,
  });
}

class _EventCard extends StatefulWidget {
  final _EventData event;
  final bool isDesktopRow;
  final bool isDark;

  const _EventCard({
    required this.event,
    required this.isDesktopRow,
    this.isDark = true,
  });

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final e = widget.event;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: isDark
              ? (_isHovered ? AppColors.cardDarkElevated : AppColors.cardDark)
              : (_isHovered ? AppColors.lightSurfaceElevated : AppColors.lightSurface),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? e.color.withValues(alpha: 0.8)
                : (isDark ? AppColors.darkBorder : AppColors.lightCardBorder),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? e.color.withValues(alpha: isDark ? 0.2 : 0.15)
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
          mainAxisSize:
              widget.isDesktopRow ? MainAxisSize.max : MainAxisSize.min,
          children: [
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: e.color.withValues(alpha: isDark ? 0.15 : 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: e.color.withValues(alpha: isDark ? 0.4 : 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                e.category,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: e.color,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Event Title
            Text(
              e.title,
              style: AppTypography.eventTitle(isDark: isDark),
            ),

            const SizedBox(height: 12),

            // Date Row
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 15,
                  color: isDark ? AppColors.gold : AppColors.saffronDark,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    e.date,
                    style: AppTypography.eventDate(isDark: isDark),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Location Row
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: isDark ? AppColors.saffronLight : AppColors.saffron,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    e.location,
                    style: AppTypography.eventLocation(isDark: isDark),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Description
            Text(
              e.description,
              style: AppTypography.eventBody(isDark: isDark),
            ),

            if (widget.isDesktopRow) ...[
              const Spacer(),
              const SizedBox(height: 16),
            ] else ...[
              const SizedBox(height: 20),
            ],

            // Participate Action Button with empty onTap for now
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: e.color.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  context.l10n.event_register_btn,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: e.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
