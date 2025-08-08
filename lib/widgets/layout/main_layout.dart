import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ScreenSize.isMobile(context) ? _buildMobileDrawer() : null,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.textLight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.code,
                        color: AppColors.textLight,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Jostar Programming',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textLight,
                            ),
                          ),
                          Text(
                            'Mobile App & Website Solutions',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.textLight.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Navigation Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem('Home', Icons.home, '/'),
                _buildDrawerItem('Services', Icons.work, '/services'),
                _buildDrawerItem('Portfolio', Icons.folder_open, '/portfolio'),
                _buildDrawerItem('Store', Icons.store, '/store'),
                _buildDrawerItem('About', Icons.person, '/about'),
                _buildDrawerItem('Contact', Icons.contact_mail, '/contact'),
                
                const Divider(),
                
                // Quick Contact
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Contact',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomButton.primary(
                        text: 'WhatsApp',
                        icon: const Icon(Icons.chat, size: 16, color: AppColors.textLight),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Open WhatsApp
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomButton.secondary(
                        text: 'Email',
                        icon: const Icon(Icons.email, size: 16),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Open Email
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, String route) {
    final isActive = GoRouterState.of(context).matchedLocation == route;
    
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isActive,
      selectedTileColor: AppColors.primary.withOpacity(0.1),
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ResponsiveBuilder(
        mobile: _buildMobileHeader(),
        desktop: _buildDesktopHeader(),
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(),
          _buildNavItems(),
          const SizedBox(width: 24),
          CustomButton.primary(
            text: 'Konsultasi Gratis',
            onPressed: () => context.go('/contact'),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.code,
              color: AppColors.textLight,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Jostar Programming',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItems() {
    final navItems = [
      ('Home', '/'),
      ('Services', '/services'),
      ('Portfolio', '/portfolio'),
      ('Store', '/store'),
      ('About', '/about'),
      ('Contact', '/contact'),
    ];

    return Row(
      children: navItems.map((item) => _buildNavItem(item.$1, item.$2)).toList(),
    );
  }

  Widget _buildNavItem(String title, String route) {
    final isActive = GoRouterState.of(context).matchedLocation == route;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isActive ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}