import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../utils/constants.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security', style: theme.textTheme.titleLarge),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        leading: IconButton(
          icon: Icon(
            LucideIcons.chevronLeft,
            size: 24,
            color: colors.onSurface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Security Safeguards'),
            const SizedBox(height: 16),
            _buildSecurityTile(
              context,
              icon: LucideIcons.key,
              title: 'Reset Access Key',
              subtitle: 'Update your authentication credentials',
              onTap: () => _showActionSnackBar(
                context,
                'Security link sent to your email! 🔑',
              ),
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.shieldCheck,
              title: 'Biometric Lock',
              subtitle: 'Fingerprint or FaceID protection',
              trailing: Switch(
                value: false,
                onChanged: (val) =>
                    _showActionSnackBar(context, 'Biometrics enabled!'),
              ),
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.smartphone,
              title: 'Double Protection',
              subtitle: 'Two-factor auth layer active',
              trailing: Switch(
                value: true,
                onChanged: (val) =>
                    _showActionSnackBar(context, '2FA configuration updated!'),
              ),
            ),

            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Data Governance'),
            const SizedBox(height: 16),
            _buildSecurityTile(
              context,
              icon: LucideIcons.database,
              title: 'Utilization Insights',
              subtitle: 'How we process your career data',
              onTap: () => _showInfoDialog(
                context,
                'Data Usage Policy',
                'CareerCoach utilizes your trajectory and profile benchmarks to synthesize personalized roadmap optimizations and track verified graduation readiness indices.',
              ),
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.history,
              title: 'Purge Search Records',
              subtitle: 'Remove all historical roadmap queries',
              onTap: () =>
                  _showActionSnackBar(context, 'Search archives purged!'),
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.eye,
              title: 'Data Portability',
              subtitle: 'Request a secure copy of your logs',
              onTap: () =>
                  _showActionSnackBar(context, 'Data synthesis initiated!'),
            ),

            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Legal Framework'),
            const SizedBox(height: 16),
            _buildSecurityTile(
              context,
              icon: LucideIcons.fileText,
              title: 'Privacy Manifesto',
              subtitle: 'Our latest data protection terms',
              onTap: () => _showInfoDialog(
                context,
                'Privacy Manifesto',
                'Your privacy is our core mandate. We operate on a zero-sale data policy. All career trajectories are end-to-end encrypted.\n\nRead full manifesto at: careercoach.app/privacy',
              ),
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.layers,
              title: 'Terms of Engagement',
              subtitle: 'Service rules and user obligations',
              onTap: () => _showInfoDialog(
                context,
                'Engagement Terms',
                'By utilizing the ecosystem, you adhere to our mentorship protocols and academic integrity frameworks for validated roadmap execution.\n\nFull terms: careercoach.app/legal',
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
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

  Widget _buildSecurityTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
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

  void _showActionSnackBar(BuildContext context, String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardTheme.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.7),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Acknowledge',
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  --- FUTURE SCOPE & INTEGRATION NOTES ---
  
  1. Biometric Authentication:
     - Use 'local_auth' package.
     - Check 'canCheckBiometrics' and 'isDeviceSupported'.
     - Call 'authenticate' with stickyAuth: true.

  2. Secure Storage:
     - Use 'flutter_secure_storage' to save PIN/Bio preferences.
     - Encrypt local cache using AES-256.

  3. Backend Password Reset:
     - Integrate FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail).
     - Handle deep links for password reset redirect.

  4. GDPR-Compliant Data Controls:
     - Implement API endpoints to 'Export JSON Data' and 'Delete Account Permanentely'.
     - Set up clear consent toggles for marketing cookies/analytics.
  */
}
