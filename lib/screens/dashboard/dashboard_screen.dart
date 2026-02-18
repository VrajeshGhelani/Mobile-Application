import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../services/auth_service.dart';
import '../../providers/user_provider.dart';
import '../../models/career_domain_data.dart';
import '../../models/career_domain_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String _selectedField = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final List<CareerDomain> _allDomains = CareerDomainData.getAllDomains();

  List<CareerDomain> _filteredCache = [];
  String _lastQuery = '';
  String _lastField = '';

  void _updateFilteredDomains() {
    if (_lastQuery == _searchQuery &&
        _lastField == _selectedField &&
        _filteredCache.isNotEmpty) {
      return;
    }

    _filteredCache = _allDomains.where((domain) {
      final query = _searchQuery.toLowerCase();
      final matchesFieldFilter =
          _selectedField == 'All' || domain.field == _selectedField;
      final matchesSearchQuery =
          domain.name.toLowerCase().contains(query) ||
          domain.description.toLowerCase().contains(query) ||
          domain.field.toLowerCase().contains(query);
      return matchesFieldFilter && matchesSearchQuery;
    }).toList();

    _lastQuery = _searchQuery;
    _lastField = _selectedField;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateFilteredDomains();
    final userProvider = context.watch<UserProvider>();
    final authService = context.watch<AuthService>();

    if (userProvider.user == null && authService.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserProvider>().setUser(authService.currentUser!);
      });
    }

    final user = userProvider.user ?? authService.currentUser;
    final firstName = user?.name.split(' ').first ?? 'Developer';

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Welcome Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        '$firstName! 👋',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: colors.primary.withValues(alpha: 0.1),
                      child: Icon(
                        LucideIcons.user,
                        color: colors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- Modern Search Bar ---
              Container(
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search career roadmaps...',
                    prefixIcon: Icon(
                      LucideIcons.search,
                      color: colors.primary.withValues(alpha: 0.6),
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(LucideIcons.x, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: colors.primary, width: 2),
                    ),
                    filled: false,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Filter Chips ---
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Tech', 'Medical', 'Commerce'].map((field) {
                    final isSelected = _selectedField == field;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterChip(
                        label: Text(field),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedField = field);
                        },
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // --- Grid Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Domains',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- Results Grid ---
              _filteredCache.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: colors.surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LucideIcons.searchX,
                                size: 48,
                                color: colors.onSurfaceVariant.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Oops! No results found',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try searching for something else.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.82,
                          ),
                      itemCount: _filteredCache.length,
                      itemBuilder: (context, index) {
                        return _buildDomainCard(_filteredCache[index], theme);
                      },
                    ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: colors.surface,
          selectedItemColor: colors.primary,
          unselectedItemColor: colors.onSurface.withValues(alpha: 0.6),
          onTap: (index) {
            setState(() => _currentIndex = index);
            if (index == 1) context.push('/progress');
            if (index == 2) context.push('/profile');
            if (index == 3) context.push('/settings');
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.trendingUp),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainCard(CareerDomain domain, ThemeData theme) {
    final colors = theme.colorScheme;
    return InkWell(
      onTap: () => context.push('/roadmap/${domain.id}'),
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
              color: domain.color.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: domain.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(domain.icon, color: domain.color, size: 28),
            ),
            const Spacer(),
            Text(
              domain.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    domain.field,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  LucideIcons.chevronRight,
                  size: 16,
                  color: colors.primary.withValues(alpha: 0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
