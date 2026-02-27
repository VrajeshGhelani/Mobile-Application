import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'roadmap_provider.dart';
import '../../utils/constants.dart';
import '../../models/career_domain_model.dart';
import '../../widgets/skill_card.dart';
import '../../widgets/technology_card.dart';
import '../../data/skill_recommendation_data.dart';
import '../../data/domain_learning_duration.dart';
import '../../data/domain_technology_data.dart';

class RoadmapScreen extends StatefulWidget {
  final String roadmapId;
  const RoadmapScreen({super.key, required this.roadmapId});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoadmapProvider>().loadDomain(widget.roadmapId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RoadmapProvider>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final domain = provider.selectedDomain;
    if (domain == null) {
      return const Scaffold(body: Center(child: Text('Domain not found')));
    }

    final completedSteps = domain.steps.where((s) => s.isCompleted).length;
    final totalSteps = domain.steps.length;
    final progress = totalSteps > 0 ? completedSteps / totalSteps : 0.0;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            stretch: true,
            backgroundColor: colors.surface,
            foregroundColor: colors.onSurface,
            leading: IconButton(
              icon: Icon(
                LucideIcons.chevronLeft,
                color: colors.onSurface,
                size: 28,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              title: Text(
                domain.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colors.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          domain.color,
                          domain.color.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(
                      domain.icon,
                      size: 160,
                      color: colors.onPrimary.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Progress Insight Card ---
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(AppConstants.defaultPadding),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PATHWAY PROGRESS',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.onSurface.withValues(alpha: 0.4),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Keep going, ${((1 - progress) * 10).toInt()} steps left!',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: domain.color,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: colors.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      color: domain.color,
                      minHeight: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Domain Learning Duration Banner ---
          _buildDomainDurationBanner(context, domain.id, colors),

          // --- Interactive Roadmap Timeline ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final step = domain.steps[index];
                final isLast = index == domain.steps.length - 1;
                return _buildStepItem(
                  context,
                  index,
                  step,
                  isLast,
                  provider,
                  domain,
                );
              }, childCount: domain.steps.length),
            ),
          ),

          // --- Technologies to Learn Section ---
          _buildTechSection(context, domain.id, colors),

          // --- Recommended Skills Section ---
          _buildSkillsSection(context, domain.id, colors),

          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }

  Widget _buildDomainDurationBanner(
    BuildContext context,
    String domainId,
    ColorScheme colors,
  ) {
    final theme = Theme.of(context);
    final duration = DomainLearningDuration.getDurationForDomain(domainId);

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colors.primary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.timer_outlined,
                size: 20,
                color: colors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ESTIMATED TIME TO BE JOB-READY',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.primary.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    duration,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechSection(
    BuildContext context,
    String domainId,
    ColorScheme colors,
  ) {
    final theme = Theme.of(context);
    final techs = DomainTechnologyData.getTechnologiesForDomain(domainId);

    if (techs.isEmpty)
      return const SliverToBoxAdapter(child: SizedBox.shrink());

    final isDark = theme.brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    colors.surfaceContainerHighest.withValues(alpha: 0.3),
                    colors.surface.withValues(alpha: 0.1),
                  ]
                : [colors.primary.withValues(alpha: 0.05), colors.surface],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'CORE TECHNOLOGIES & TOOLS',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: colors.onSurface.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: techs
                    .map((tech) => TechnologyCard(tech: tech))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(
    BuildContext context,
    String domainId,
    ColorScheme colors,
  ) {
    final skills = SkillRecommendationData.getSkillsForDomain(domainId);
    final theme = Theme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'RECOMMENDED SKILLS',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: colors.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (skills.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colors.outline.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    LucideIcons.sparkles,
                    size: 40,
                    color: colors.onSurface.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No skill recommendations available',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          else
            ...skills.map((skill) => SkillCard(skill: skill)),
        ]),
      ),
    );
  }

  Widget _buildStepItem(
    BuildContext context,
    int index,
    RoadmapStep step,
    bool isLast,
    RoadmapProvider provider,
    CareerDomain domain,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isCompleted = step.isCompleted;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Custom Timeline Component ---
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted ? colors.primary : colors.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? colors.primary
                      : colors.outline.withValues(alpha: 0.3),
                  width: 2.5,
                ),
                boxShadow: isCompleted
                    ? [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: isCompleted
                  ? Icon(LucideIcons.check, size: 16, color: colors.onPrimary)
                  : Center(
                      child: Text(
                        '${index + 1}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            if (!isLast)
              Container(
                width: 3,
                height: 120,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? colors.primary.withValues(alpha: 0.3)
                      : colors.outline.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20),

        // --- Modern Step Card ---
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isCompleted
                    ? colors.primary.withValues(alpha: 0.2)
                    : colors.outline.withValues(alpha: 0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.02),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: isCompleted
                                  ? colors.onSurface.withValues(alpha: 0.4)
                                  : colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            step.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurface.withValues(alpha: 0.6),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        value: isCompleted,
                        activeColor: colors.primary,
                        checkColor: colors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        onChanged: (_) => provider.toggleStep(domain.id, index),
                      ),
                    ),
                  ],
                ),
                if (step.certification != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: domain.color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.award, size: 16, color: domain.color),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            step.certification!,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: domain.color,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
