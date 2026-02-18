import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../roadmap/roadmap_provider.dart';
import '../../utils/constants.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoadmapProvider>().loadAllDomains();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RoadmapProvider>();
    final progress = provider.overallProgress;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final overallGradient = LinearGradient(
      colors: isDark
          ? [
              const Color(0xFF1E1B4B), // Deep Indigo
              const Color(0xFF312E81), // Royal Indigo
              const Color(0xFF020617), // Rich Black
            ]
          : [
              const Color(0xFF6366F1), // Indigo
              const Color(0xFF8B5CF6), // Violet
              const Color(0xFFEC4899), // Pink
            ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text('Your Progress', style: theme.textTheme.titleLarge),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        centerTitle: true,
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(colors.primary),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Redesigned Overall Progress Card ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      gradient: overallGradient,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.5)
                              : colors.primary.withValues(alpha: 0.25),
                          blurRadius: 25,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Overall Completion'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            height: 1,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Thicker, Modern Progress Bar
                        Stack(
                          children: [
                            Container(
                              height: 14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: progress,
                              child: Container(
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Stats Row with Circular Icon Backgrounds
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                'Steps Completed',
                                provider.totalCompletedSteps.toString(),
                                LucideIcons.checkCircle2,
                                Colors.white,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Steps Pending',
                                provider.totalPendingSteps.toString(),
                                LucideIcons.timer,
                                Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Domain Breakdowns',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Render all domains with their individual progress
                  ...provider.allDomains.map((domain) {
                    final domainProgress = domain.steps.isEmpty
                        ? 0.0
                        : domain.steps.where((s) => s.isCompleted).length /
                              domain.steps.length;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colors.outline.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: domain.color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  domain.icon,
                                  color: domain.color,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  domain.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: colors.onSurface,
                                  ),
                                ),
                              ),
                              Text(
                                '${(domainProgress * 100).toInt()}%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: domain.color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: LinearProgressIndicator(
                              value: domainProgress,
                              backgroundColor: colors.surfaceContainerHighest,
                              color: domain.color,
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${domain.steps.where((s) => s.isCompleted).length} of ${domain.steps.length} steps completed',
                            style: TextStyle(
                              color: colors.onSurfaceVariant,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color contentColor,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: contentColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: contentColor, size: 20),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
            color: contentColor,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: contentColor.withValues(alpha: 0.6),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
