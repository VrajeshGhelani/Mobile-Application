import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../models/career_domain_data.dart';
import '../../models/career_domain_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  // Single Source of Truth: Load all domains from centralized data
  final List<CareerDomain> _allDomains = CareerDomainData.getAllDomains();
  late String _selectedDomain;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().user;

    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');

    // Initialize selected domain from user profile
    // Fallback to first domain if user's domain is not in the list or is null
    final userDomain = user?.careerDomain;
    if (userDomain != null && _allDomains.any((d) => d.name == userDomain)) {
      _selectedDomain = userDomain;
    } else {
      _selectedDomain = _allDomains.first.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      context.read<UserProvider>().updateProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        careerDomain: _selectedDomain,
      );

      final theme = Theme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile updated successfully! 🎉',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: theme.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: theme.textTheme.titleLarge),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        leading: IconButton(
          icon: Icon(
            LucideIcons.chevronLeft,
            size: 24,
            color: colors.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Avatar Edit ---
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [colors.primary, colors.secondary],
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.scaffoldBackgroundColor,
                            width: 3,
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
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        LucideIcons.camera,
                        color: colors.onPrimary,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              _buildLabel('Full Name', theme),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  prefixIcon: Icon(LucideIcons.user, size: 20),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your name'
                    : null,
              ),
              const SizedBox(height: 24),

              _buildLabel('Email Address', theme),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(LucideIcons.mail, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              _buildLabel('Career Domain', theme),
              DropdownButtonFormField<String>(
                initialValue: _selectedDomain,
                decoration: const InputDecoration(
                  prefixIcon: Icon(LucideIcons.briefcase, size: 20),
                ),
                isExpanded: true,
                items: _allDomains.map((domain) {
                  return DropdownMenuItem(
                    value: domain.name,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            domain.name,
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: domain.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            domain.field,
                            style: TextStyle(
                              fontSize: 10,
                              color: domain.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedDomain = value);
                },
              ),
              const SizedBox(height: 48),

              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile Changes'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
