import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';

class PratidnyaSection extends StatelessWidget {
  const PratidnyaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.deepMaroonBg,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 40 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              // Regal Parchment Oath Card
              Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.pledgeCardGradient,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.saffron.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.7),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 40,
                  vertical: isMobile ? 24 : 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Card Header with Logo
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.logo,
                            width: 72,
                            height: 72,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Text('🚩', style: TextStyle(fontSize: 28)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            context.l10n.pledge_heading,
                            textAlign: TextAlign.center,
                            style: AppTypography.pledgeHeading(isMobile),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            context.l10n.pledge_subheading,
                            textAlign: TextAlign.center,
                            style: AppTypography.pledgeSubheading(isMobile),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: 140,
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: AppGradients.goldDivider,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Paragraph 1 - The Invocation
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p1,
                      isInvocation: true,
                      isMobile: isMobile,
                    ),

                    const SizedBox(height: 20),

                    // Paragraph 2 - Dharma & Social Welfare
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p2,
                      number: '१',
                      isMobile: isMobile,
                    ),

                    const SizedBox(height: 20),

                    // Paragraph 3 - Authentic History
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p3,
                      number: '२',
                      isMobile: isMobile,
                    ),

                    const SizedBox(height: 20),

                    // Paragraph 4 - Lifelong Dedication to Organization
                    _buildPledgeClause(
                      context,
                      text: context.l10n.pledge_p4,
                      number: '३',
                      isMobile: isMobile,
                    ),

                    const SizedBox(height: 32),

                    // Slogans Footer Strip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.saffronDark.withValues(alpha: 0.4),
                            AppColors.goldDark.withValues(alpha: 0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          context.l10n.pledge_slogans,
                          textAlign: TextAlign.center,
                          style: AppTypography.pledgeSlogans(isMobile),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPledgeClause(
    BuildContext context, {
    required String text,
    String? number,
    bool isInvocation = false,
    required bool isMobile,
  }) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 14 : 18),
      decoration: BoxDecoration(
        color: isInvocation
            ? AppColors.gold.withValues(alpha: 0.06)
            : AppColors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isInvocation
              ? AppColors.gold.withValues(alpha: 0.3)
              : AppColors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (number != null) ...[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.saffron.withValues(alpha: 0.25),
                border: Border.all(
                  color: AppColors.saffronLight,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldLight,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ] else if (isInvocation) ...[
            const Icon(
              Icons.stars_rounded,
              color: AppColors.gold,
              size: 22,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              text,
              style: isInvocation
                  ? AppTypography.pledgeInvocation(isMobile)
                  : AppTypography.pledgeBody(isMobile),
            ),
          ),
        ],
      ),
    );
  }
}
