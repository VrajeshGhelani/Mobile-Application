import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../services/auth_service.dart';
import '../../utils/constants.dart';
import '../../theme/theme_provider.dart';
import 'privacy_security_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Preferences'),
            const SizedBox(height: 16),
            SettingsTile(
              icon: LucideIcons.bell,
              title: 'Notifications',
              subtitle: 'Enable career goal reminders',
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) =>
                    setState(() => _notificationsEnabled = value),
              ),
            ),
            const SizedBox(height: 12),
            SettingsTile(
              icon: LucideIcons.moon,
              title: 'Dark Mode',
              subtitle: themeProvider.isDarkMode
                  ? 'Dark theme enabled'
                  : 'Light theme enabled',
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(value),
              ),
            ),
            const SizedBox(height: 32),

            const SectionHeader(title: 'Account & Privacy'),
            const SizedBox(height: 16),
            SettingsTile(
              icon: LucideIcons.user,
              title: 'Profile Settings',
              subtitle: 'Update your personal info',
              onTap: () => context.push('/profile'),
            ),
            const SizedBox(height: 12),
            SettingsTile(
              icon: LucideIcons.lock,
              title: 'Privacy & Security',
              subtitle: 'Manage your data permissions',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PrivacySecurityScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            const SectionHeader(title: 'Support'),
            const SizedBox(height: 16),
            SettingsTile(
              icon: LucideIcons.helpCircle,
              title: 'Help Center',
              subtitle: 'FAQs and support guides',
              onTap: () {},
            ),
            const SizedBox(height: 48),

            // --- Logout Action ---
            OutlinedButton(
              onPressed: () => _showLogoutDialog(context, authService),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.error,
                side: BorderSide(color: colors.error.withValues(alpha: 0.5)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.logOut, size: 20, color: colors.error),
                  const SizedBox(width: 12),
                  const Text('Logout Account'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Version 1.0.0 (Stable)',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.4),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthService authService) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardTheme.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          'Confirm Logout?',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out of CareerCoach? Your progress is saved.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
            ),
          ),
          TextButton(
            onPressed: () {
              authService.logout();
              context.go('/login');
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: colors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: theme.cardTheme.shape is RoundedRectangleBorder
            ? Border.fromBorderSide(
                (theme.cardTheme.shape as RoundedRectangleBorder).side,
              )
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: colors.primary, size: 24),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.5),
          ),
        ),
        trailing:
            trailing ??
            Icon(
              LucideIcons.chevronRight,
              color: colors.onSurface.withValues(alpha: 0.3),
              size: 20,
            ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
