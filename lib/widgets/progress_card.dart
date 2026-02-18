import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final double percentage;

  const ProgressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularPercentIndicator(
            radius: 45.0,
            lineWidth: 10.0,
            percent: percentage,
            animation: true,
            animationDuration: 1200,
            center: Text(
              "${(percentage * 100).toInt()}%",
              style: TextStyle(
                color: colors.onPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            progressColor: colors.onPrimary,
            backgroundColor: colors.onPrimary.withValues(alpha: 0.2),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
