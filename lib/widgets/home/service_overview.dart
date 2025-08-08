import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';

// Modern Services Overview Component
class ServicesOverview extends StatefulWidget {
  const ServicesOverview({Key? key}) : super(key: key);

  @override
  State<ServicesOverview> createState() => _ServicesOverviewState();
}

class _ServicesOverviewState extends State<ServicesOverview>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create staggered animations for each service card
    _cardAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.2,
            0.6 + (index * 0.2),
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildSectionHeader(),
              const SizedBox(height: 60),
              _buildServicesGrid(isMobile),
              const SizedBox(height: 50),
              _buildViewAllButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.secondary.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Text(
            '💼 LAYANAN KAMI',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Solusi Digital Premium',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Dari aplikasi mobile yang powerfull hingga website yang menawan, kami menyediakan layanan pengembangan digital yang komprehensif untuk mendukung kesuksesan bisnis Anda.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(bool isMobile) {
    final services = [
      ServiceItem(
        icon: Icons.phone_android,
        title: 'Mobile App Premium',
        description: 'Aplikasi mobile native dengan Flutter untuk iOS dan Android dengan performa yang luar biasa',
        features: ['Cross-platform Development', 'Native Performance', 'Modern UI/UX Design'],
        color: AppColors.primary,
        gradient: [AppColors.primary, AppColors.secondary],
      ),
      ServiceItem(
        icon: Icons.web,
        title: 'Website Profesional',
        description: 'Website responsif dan aplikasi web dengan teknologi terdepan dan design yang memukau',
        features: ['Responsive Design', 'SEO Optimized', 'Lightning Fast'],
        color: AppColors.secondary,
        gradient: [AppColors.secondary, AppColors.accent],
      ),
      ServiceItem(
        icon: Icons.rocket_launch,
        title: 'Ready-to-Launch Apps',
        description: 'Aplikasi bisnis siap pakai yang dapat langsung digunakan dengan customization penuh',
        features: ['Instant Deployment', 'Full Customization', 'Premium Support'],
        color: AppColors.accent,
        gradient: [AppColors.accent, AppColors.primary],
      ),
    ];

    if (isMobile) {
      return Column(
        children: services.asMap().entries.map((entry) {
          return AnimatedBuilder(
            animation: _cardAnimations[entry.key],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _cardAnimations[entry.key].value)),
                child: Opacity(
                  opacity: _cardAnimations[entry.key].value,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: _buildServiceCard(entry.value),
                  ),
                ),
              );
            },
          );
        }).toList(),
      );
    }

    return Row(
      children: services.asMap().entries.map((entry) {
        return Expanded(
          child: AnimatedBuilder(
            animation: _cardAnimations[entry.key],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _cardAnimations[entry.key].value)),
                child: Opacity(
                  opacity: _cardAnimations[entry.key].value,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(entry.value),
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildServiceCard(ServiceItem service) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                service.color.withOpacity(0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: service.color.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: service.color.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon with gradient background
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: service.gradient,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: service.color.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  service.icon,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Title
              Text(
                service.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  fontSize: 22,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Description
              Text(
                service.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Features
              ...service.features.map((feature) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: service.gradient),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              
              const SizedBox(height: 24),
              
              // CTA Button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: service.color.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => context.go('/services'),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pelajari Lebih Lanjut',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: service.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: service.color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewAllButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.go('/services'),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.explore,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Lihat Semua Layanan',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Service Item Model
class ServiceItem {
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;
  final Color color;
  final List<Color> gradient;

  ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.color,
    required this.gradient,
  });
}