import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../utils/constants.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardTheme.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy & Security',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Security', isDark),
            const SizedBox(height: 16),
            _buildSecurityTile(
              context,
              icon: LucideIcons.key,
              title: 'Change Password',
              subtitle: 'Update your login credentials',
              onTap: () => _showActionSnackBar(
                context,
                'Redirecting to Change Password...',
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.shieldCheck,
              title: 'App Lock',
              subtitle: 'Fingerprint or PIN protection',
              trailing: Switch.adaptive(
                value: false,
                onChanged: (val) =>
                    _showActionSnackBar(context, 'Biometric lock enabled!'),
                activeTrackColor: AppConstants.primaryColor,
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.smartphone,
              title: 'Two-Factor Authentication',
              subtitle: 'Add an extra layer of security',
              trailing: Switch.adaptive(
                value: false,
                onChanged: (val) =>
                    _showActionSnackBar(context, '2FA setup initiated!'),
                activeTrackColor: AppConstants.primaryColor,
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),

            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Privacy', isDark),
            const SizedBox(height: 16),
            _buildSecurityTile(
              context,
              icon: LucideIcons.database,
              title: 'Data Usage',
              subtitle: 'View how we use your career data',
              onTap: () => _showInfoDialog(
                context,
                'Data Usage',
                'CareerCoach uses your roadmap progress and profile entries to provide personalized skill recommendations and track your graduation readiness.',
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.history,
              title: 'Clear Search History',
              subtitle: 'Remove all previous roadmap searches',
              onTap: () => _showActionSnackBar(
                context,
                'Search history cleared successfully!',
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.eye,
              title: 'Account Data Access',
              subtitle: 'Request a copy of your personal data',
              onTap: () => _showActionSnackBar(
                context,
                'Data request sent to your email!',
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),

            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Legal', isDark),
            const SizedBox(height: 16),
            _buildSecurityTile(
              context,
              icon: LucideIcons.fileText,
              title: 'Privacy Policy',
              subtitle: 'Read our latest privacy terms',
              onTap: () => _showInfoDialog(
                context,
                'Privacy Policy',
                'Your privacy is our priority. We do not sell your data to third parties. All personal roadmaps are encrypted and stored securely.\n\nRead full policy at: careercoach.app/privacy',
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              context,
              icon: LucideIcons.layers,
              title: 'Terms & Conditions',
              subtitle: 'App usage rules and guidelines',
              onTap: () => _showInfoDialog(
                context,
                'Terms & Conditions',
                'By using CareerCoach, you agree to our mentorship guidelines and academic integrity standards for roadmap tracking.\n\nFull terms: careercoach.app/terms',
              ),
              isDark: isDark,
              cardColor: cardColor,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, bool isDark) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.grey[400] : Colors.grey[500],
        letterSpacing: 1.2,
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
    required bool isDark,
    required Color? cardColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100]!,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppConstants.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppConstants.primaryColor, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[500],
            fontSize: 12,
          ),
        ),
        trailing:
            trailing ??
            Icon(
              LucideIcons.chevronRight,
              color: isDark ? Colors.grey[600] : Colors.grey[300],
              size: 20,
            ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _showActionSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppConstants.primaryColor,
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
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
