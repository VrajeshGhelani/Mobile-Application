import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../services/auth_service.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user ?? authService.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please login to view profile')),
      );
    }

    if (userProvider.user == null && authService.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserProvider>().setUser(authService.currentUser!);
      });
    }

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: theme.textTheme.titleLarge),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        actions: [
          IconButton(
            icon: Icon(LucideIcons.settings, color: colors.onSurface),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: 20,
        ),
        child: Column(
          children: [
            // --- Premium Avatar Section ---
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [colors.primary, colors.secondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.scaffoldBackgroundColor,
                              width: 4,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://api.dicebear.com/7.x/avataaars/png?seed=CareerCoach',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.scaffoldBackgroundColor,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          LucideIcons.edit2,
                          color: colors.onPrimary,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user.email,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- Info Cards ---
            _buildProfileItem(
              context,
              icon: LucideIcons.briefcase,
              label: 'Career Domain',
              value: user.careerDomain,
              accentColor: colors.primary,
            ),
            const SizedBox(height: 16),
            _buildProfileItem(
              context,
              icon: LucideIcons.mail,
              label: 'Personal Email',
              value: user.email,
              accentColor: colors.tertiary.withValues(
                alpha: 0.8,
              ), // Using tertiary instead of orange
            ),
            const SizedBox(height: 16),
            _buildProfileItem(
              context,
              icon: LucideIcons.shieldCheck,
              label: 'Account Type',
              value: 'Verified Scholar',
              accentColor: colors.primary, // Using primary instead of green
            ),
            const SizedBox(height: 40),

            // --- Action Buttons ---
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              child: const Text('Edit Profile Information'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                authService.logout();
                context.go('/login');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.error,
                side: BorderSide(color: colors.error.withValues(alpha: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.logOut, size: 18, color: colors.error),
                  const SizedBox(width: 10),
                  const Text('Logout Account'),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color accentColor,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: theme.cardTheme.shape is RoundedRectangleBorder
            ? Border.fromBorderSide(
                (theme.cardTheme.shape as RoundedRectangleBorder).side,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: accentColor, size: 22),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.4),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            size: 18,
            color: colors.onSurface.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }
}
