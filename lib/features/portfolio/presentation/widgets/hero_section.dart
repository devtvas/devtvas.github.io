import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/terminal_prompt.dart';
import '../../domain/entities/portfolio_content.dart';

class HeroSection extends StatelessWidget {
  final PortfolioContent content;

  const HeroSection({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: isMobile ? 64 : 120,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusBadge(content: content),
            const SizedBox(height: 28),
            const TerminalPrompt(command: 'whoami'),
            const SizedBox(height: 16),
            Text(
              content.name,
              style: isMobile
                  ? AppTypography.displayLarge.copyWith(fontSize: 36)
                  : AppTypography.displayLarge,
            ),
            const SizedBox(height: 10),
            Text(
              content.role,
              style: AppTypography.displayMedium.copyWith(
                color: AppColors.accentAlert,
                fontSize: isMobile ? 18 : 22,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              content.summary,
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              '📍 ${content.location}',
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final PortfolioContent content;

  const _StatusBadge({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: content.status
                ? AppColors.accentPrimary.withValues(alpha: 0.3)
                : AppColors.accentAlert.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: content.status
                  ? AppColors.accentPrimary
                  : AppColors.accentAlert,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'status: ${content.status ? "disponível" : "indisponível"} para novas oportunidades',
            style: AppTypography.label.copyWith(
                color: content.status
                    ? AppColors.accentPrimary
                    : AppColors.accentAlert),
          ),
        ],
      ),
    );
  }
}
