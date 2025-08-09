import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

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

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.surface,
            AppColors.background.withOpacity(0.5),
            AppColors.surface,
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(context),
              const SizedBox(height: 80),
              _buildServicesGrid(context),
              const SizedBox(height: 80),
              _buildCTAButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        // Badge
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
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star_rounded,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'LAYANAN PREMIUM',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Main Title
        Text(
          'Solusi Digital Terlengkap',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: ScreenSize.isMobile(context) ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16),
        
        // Subtitle with Gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(bounds),
          child: Text(
            'untuk Transformasi Bisnis Anda',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: ScreenSize.isMobile(context) ? 24 : 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Description
        Container(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            'Dari aplikasi mobile hingga website enterprise, kami menyediakan layanan '
            'pengembangan digital yang komprehensif dengan teknologi terdepan untuk '
            'mendukung pertumbuhan bisnis Anda.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: AppColors.textSecondary,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      ServiceItem(
        icon: Icons.phone_android_rounded,
        title: 'Custom Mobile App',
        subtitle: 'Flutter Development',
        description: 'Aplikasi mobile native dengan Flutter untuk iOS dan Android dengan performance tinggi dan UI/UX yang memukau.',
        features: [
          'Cross-platform development',
          'Performance setara native',
          'UI/UX modern & responsive',
          'Push notifications',
          'Offline capability',
        ],
        imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
        color: AppColors.primary,
        price: 'Mulai Rp 15 Juta',
      ),
      ServiceItem(
        icon: Icons.web_rounded,
        title: 'Custom Website',
        subtitle: 'Modern Web Solutions',
        description: 'Website responsif dan aplikasi web dengan teknologi terdepan, SEO optimized, dan loading speed yang optimal.',
        features: [
          'Responsive design',
          'SEO optimized',
          'Fast loading speed',
          'CMS integration',
          'Analytics dashboard',
        ],
        imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=2015&q=80',
        color: AppColors.secondary,
        price: 'Mulai Rp 8 Juta',
      ),
      ServiceItem(
        icon: Icons.shopping_bag_rounded,
        title: 'Ready-to-Use Apps',
        subtitle: 'Instant Business Solutions',
        description: 'Aplikasi bisnis siap pakai yang dapat langsung digunakan dengan customization sesuai branding Anda.',
        features: [
          'Plug & play solution',
          'Quick deployment',
          'Custom branding',
          'Full documentation',
          'Support included',
        ],
        imageUrl: 'https://images.unsplash.com/photo-1551650975-87deedd944c3?ixlib=rb-4.0.3&auto=format&fit=crop&w=2074&q=80',
        color: AppColors.accent,
        price: 'Mulai Rp 3 Juta',
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: services.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _buildServiceCard(context, entry.value, entry.key),
          );
        }).toList(),
      ),
      desktop: Row(
        children: services.asMap().entries.map((entry) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildServiceCard(context, entry.value, entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceItem service, int index) {
    return AnimatedBuilder(
      animation: _cardAnimations[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _cardAnimations[index].value)),
          child: Opacity(
            opacity: _cardAnimations[index].value,
            child: Container(
              height: ScreenSize.isMobile(context) ? 580 : 620,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: service.color.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: AppColors.neutral.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Header
                  _buildCardHeader(service),
                  
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Service Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: service.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              service.subtitle,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: service.color,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Title
                          Text(
                            service.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Price
                          Text(
                            service.price,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: service.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Description
                          Text(
                            service.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Features
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Features:',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...service.features.map((feature) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 6),
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: service.color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.textSecondary,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Action Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () => context.go('/services'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: service.color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Pelajari Lebih Lanjut',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardHeader(ServiceItem service) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        image: DecorationImage(
          image: NetworkImage(service.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              service.color.withOpacity(0.7),
              service.color.withOpacity(0.3),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.textLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.textLight.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  service.icon,
                  size: 28,
                  color: AppColors.textLight,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.textLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Premium Service',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.secondary.withOpacity(0.1),
            AppColors.accent.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Siap Memulai Project Anda?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Konsultasikan kebutuhan digital Anda dengan tim expert kami',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ResponsiveBuilder(
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/services'),
                    icon: const Icon(
                      Icons.rocket_launch_rounded,
                      color: AppColors.textLight,
                      size: 18,
                    ),
                    label: Text(
                      'Lihat Semua Layanan',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/contact'),
                    icon: const Icon(
                      Icons.chat_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    label: Text(
                      'Konsultasi Gratis',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/services'),
                    icon: const Icon(
                      Icons.rocket_launch_rounded,
                      color: AppColors.textLight,
                      size: 18,
                    ),
                    label: Text(
                      'Lihat Semua Layanan',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/contact'),
                    icon: const Icon(
                      Icons.chat_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    label: Text(
                      'Konsultasi Gratis',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary, width: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final String imageUrl;
  final Color color;
  final String price;

  ServiceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.imageUrl,
    required this.color,
    required this.price,
  });
}