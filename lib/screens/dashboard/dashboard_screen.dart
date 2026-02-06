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

    // Sync UserProvider if it's empty but AuthService has a user
    if (userProvider.user == null && authService.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserProvider>().setUser(authService.currentUser!);
      });
    }

    final user = userProvider.user ?? authService.currentUser;
    final firstName = user?.name.split(' ').first ?? 'Developer';

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardTheme.color;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Welcome Message
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$firstName! 👋',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppConstants.primaryColor.withValues(
                      alpha: 0.2,
                    ),
                    child: const Icon(
                      LucideIcons.user,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Step 3: Functional Search Bar
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.3 : 0.05,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
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
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for roadmaps...',
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                    ),
                    prefixIcon: Icon(
                      LucideIcons.search,
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              LucideIcons.x,
                              color: isDark
                                  ? Colors.grey[500]
                                  : Colors.grey[400],
                              size: 18,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Filter Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Tech', 'Medical', 'Commerce'].map((field) {
                    final isSelected = _selectedField == field;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(field),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedField = field);
                        },
                        selectedColor: AppConstants.primaryColor.withValues(
                          alpha: 0.2,
                        ),
                        checkmarkColor: AppConstants.primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppConstants.primaryColor
                              : isDark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        backgroundColor: cardColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? AppConstants.primaryColor
                                : isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.grey[200]!,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              // Section Header
              Text(
                'Explore Career Domains',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              // Step 4: Domain Grid / No Results UI
              _filteredCache.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Icon(
                              LucideIcons.searchX,
                              size: 64,
                              color: isDark
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No roadmaps found for "$_searchQuery"',
                              style: TextStyle(
                                color: isDark
                                    ? Colors.grey[500]
                                    : Colors.grey[500],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try searching for another domain or field.',
                              style: TextStyle(
                                color: isDark
                                    ? Colors.grey[600]
                                    : Colors.grey[400],
                                fontSize: 13,
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
                            childAspectRatio: 0.85,
                          ),
                      itemCount: _filteredCache.length,
                      itemBuilder: (context, index) {
                        return _buildDomainCard(
                          _filteredCache[index],
                          isDark,
                          cardColor,
                        );
                      },
                    ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            if (index == 1) context.push('/progress');
            if (index == 2) context.push('/profile');
            if (index == 3) context.push('/settings');
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(
            context,
          ).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: isDark ? Colors.grey[600] : Colors.grey[400],
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
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

  Widget _buildDomainCard(CareerDomain domain, bool isDark, Color? cardColor) {
    return InkWell(
      onTap: () => context.push('/roadmap/${domain.id}'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.grey[100]!,
          ),
          boxShadow: [
            BoxShadow(
              color: domain.color.withValues(alpha: isDark ? 0.05 : 0.1),
              blurRadius: 15,
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
                color: domain.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(domain.icon, color: domain.color, size: 28),
            ),
            const Spacer(),
            Text(
              domain.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              domain.description,
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[500],
                fontSize: 11,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
