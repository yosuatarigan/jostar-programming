import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jostar_programming/widgets/home/cta_section.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _selectedService = 'Mobile App';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildServicesSection(context),
            _buildProcessSection(context),
            _buildTechnologiesSection(context),
            _buildPricingSection(context),
            CTASection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: ScreenSize.isMobile(context) ? 400 : 500,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.08),
            AppColors.secondary.withOpacity(0.12),
            AppColors.surface,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.getResponsivePadding(context),
            vertical: ScreenSize.isMobile(context) ? 40 : 60,
          ),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: ScreenSize.getMaxContentWidth(context),
              ),
              child: AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.rocket_launch,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'LAYANAN PREMIUM',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: ScreenSize.isMobile(context) ? 24 : 32),
                        
                        // Main Title
                        Text(
                          'Solusi Digital Terbaik\nUntuk Bisnis Anda',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: ScreenSize.isMobile(context) ? 28 : 48,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: ScreenSize.isMobile(context) ? 16 : 24),
                        
                        // Subtitle
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: ScreenSize.isMobile(context) ? double.infinity : 600,
                          ),
                          child: Text(
                            'Dari konsep hingga deployment, kami mengembangkan aplikasi mobile dan website yang mengangkat bisnis Anda ke level berikutnya',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.6,
                              fontSize: ScreenSize.isMobile(context) ? 16 : 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        SizedBox(height: ScreenSize.isMobile(context) ? 32 : 40),
                        
                        // Action Buttons
                        ResponsiveBuilder(
                          mobile: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton.large(
                                  text: 'Konsultasi Gratis',
                                  onPressed: () => context.go('/contact'),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton.secondary(
                                  text: 'Lihat Portfolio',
                                  onPressed: () => context.go('/portfolio'),
                                ),
                              ),
                            ],
                          ),
                          desktop: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton.large(
                                text: 'Konsultasi Gratis',
                                onPressed: () => context.go('/contact'),
                              ),
                              const SizedBox(width: 16),
                              CustomButton.secondary(
                                text: 'Lihat Portfolio',
                                onPressed: () => context.go('/portfolio'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final services = [
      ServiceDetail(
        icon: Icons.phone_android,
        title: 'Mobile App Development',
        subtitle: 'iOS & Android Apps',
        description: 'Aplikasi mobile berkualitas tinggi dengan Flutter untuk performa optimal di semua platform.',
        features: [
          'Cross-platform development',
          'Native performance',
          'Modern UI/UX design',
          'Push notifications',
          'Offline functionality',
          'App Store deployment',
        ],
        startingPrice: 'Mulai Rp 15jt',
        color: AppColors.primary,
        gradient: [AppColors.primary, AppColors.secondary],
      ),
      ServiceDetail(
        icon: Icons.web,
        title: 'Website Development',
        subtitle: 'Responsive & Fast',
        description: 'Website responsif dan aplikasi web dengan teknologi modern untuk performa dan SEO terbaik.',
        features: [
          'Responsive design',
          'SEO optimized',
          'Fast loading speed',
          'CMS integration',
          'E-commerce ready',
          'SSL & security',
        ],
        startingPrice: 'Mulai Rp 8jt',
        color: AppColors.secondary,
        gradient: [AppColors.secondary, AppColors.accent],
      ),
      ServiceDetail(
        icon: Icons.shopping_cart,
        title: 'E-commerce Solutions',
        subtitle: 'Complete Online Store',
        description: 'Solusi e-commerce lengkap dengan payment gateway dan sistem manajemen yang powerful.',
        features: [
          'Product management',
          'Payment gateway',
          'Inventory tracking',
          'Order management',
          'Customer analytics',
          'Mobile optimized',
        ],
        startingPrice: 'Mulai Rp 25jt',
        color: AppColors.accent,
        gradient: [AppColors.accent, AppColors.primary],
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: ScreenSize.isMobile(context) ? 60 : 80,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(
                context,
                'Layanan Kami',
                'Solusi digital komprehensif untuk setiap kebutuhan bisnis Anda',
              ),
              
              SizedBox(height: ScreenSize.isMobile(context) ? 40 : 60),
              
              ResponsiveBuilder(
                mobile: Column(
                  children: services
                      .map((service) => Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _buildServiceCard(context, service),
                          ))
                      .toList(),
                ),
                desktop: Column(
                  children: services
                      .map((service) => Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: _buildServiceCard(context, service),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.isMobile(context) ? 24 : 32,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.isMobile(context) ? double.infinity : 600,
          ),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceDetail service) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: service.color.withOpacity(0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ResponsiveBuilder(
        mobile: _buildMobileServiceCard(context, service),
        desktop: _buildDesktopServiceCard(context, service),
      ),
    );
  }

  Widget _buildMobileServiceCard(BuildContext context, ServiceDetail service) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: service.color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: service.gradient.map((c) => c.withOpacity(0.1)).toList(),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: service.gradient),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        service.icon,
                        color: AppColors.textLight,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            service.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            service.subtitle,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: service.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  service.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Fitur Unggulan:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Features using Wrap instead of GridView
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: service.features.map((feature) => Container(
                    constraints: BoxConstraints(
                      maxWidth: (MediaQuery.of(context).size.width - 80) / 2 - 4,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: service.color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: service.color.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: service.color,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            feature,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
                
                const SizedBox(height: 20),
                
                // Price and CTA
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Harga',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            service.startingPrice,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: service.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: CustomButton.primary(
                        text: 'Konsultasi',
                        onPressed: () => context.go('/contact'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopServiceCard(BuildContext context, ServiceDetail service) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: service.color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Left Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: service.gradient),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          service.icon,
                          color: AppColors.textLight,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.title,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              service.subtitle,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: service.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    service.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        service.startingPrice,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: service.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CustomButton.primary(
                        text: 'Konsultasi Sekarang',
                        onPressed: () => context.go('/contact'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Right Features
          Expanded(
            child: Container(
              height: 280,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: service.gradient.map((c) => c.withOpacity(0.05)).toList(),
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fitur Unggulan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      children: service.features
                          .map((feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: service.color.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 12,
                                        color: service.color,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSection(BuildContext context) {
    final steps = [
      ProcessStep(
        number: '01',
        title: 'Konsultasi',
        description: 'Diskusi kebutuhan dan goals bisnis Anda',
        icon: Icons.chat_bubble_outline,
      ),
      ProcessStep(
        number: '02',
        title: 'Perencanaan',
        description: 'Buat roadmap dan timeline yang jelas',
        icon: Icons.timeline,
      ),
      ProcessStep(
        number: '03',
        title: 'Development',
        description: 'Pengembangan dengan metodologi Agile',
        icon: Icons.code,
      ),
      ProcessStep(
        number: '04',
        title: 'Testing',
        description: 'Quality assurance dan user testing',
        icon: Icons.verified,
      ),
      ProcessStep(
        number: '05',
        title: 'Launch',
        description: 'Deployment dan go-live support',
        icon: Icons.rocket_launch,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: ScreenSize.isMobile(context) ? 60 : 80,
      ),
      color: AppColors.background,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(
                context,
                'Proses Kerja Kami',
                'Metodologi yang terbukti untuk hasil terbaik',
              ),
              
              SizedBox(height: ScreenSize.isMobile(context) ? 40 : 60),
              
              ResponsiveBuilder(
                mobile: _buildMobileProcessSteps(context, steps),
                desktop: _buildDesktopProcessSteps(context, steps),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileProcessSteps(BuildContext context, List<ProcessStep> steps) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLast = index == steps.length - 1;
        
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neutral.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            step.icon,
                            color: AppColors.textLight,
                            size: 24,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Center(
                              child: Text(
                                step.number,
                                style: const TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!isLast) 
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Container(
                      width: 2,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary.withOpacity(0.5),
                            AppColors.secondary.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDesktopProcessSteps(BuildContext context, List<ProcessStep> steps) {
    return Row(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLast = index == steps.length - 1;
        
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neutral.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                step.icon,
                                color: AppColors.textLight,
                                size: 28,
                              ),
                            ),
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.surface,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    step.number,
                                    style: const TextStyle(
                                      color: AppColors.textLight,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        step.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.primary.withOpacity(0.5),
                    size: 24,
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTechnologiesSection(BuildContext context) {
    final techStacks = [
      TechStack(
        title: 'Mobile',
        icon: Icons.phone_android,
        color: AppColors.primary,
        technologies: ['Flutter', 'Dart', 'iOS SDK', 'Android SDK'],
      ),
      TechStack(
        title: 'Frontend',
        icon: Icons.web,
        color: AppColors.secondary,
        technologies: ['Flutter Web', 'HTML5', 'CSS3', 'JavaScript'],
      ),
      TechStack(
        title: 'Backend',
        icon: Icons.cloud,
        color: AppColors.accent,
        technologies: ['Firebase', 'Node.js', 'PostgreSQL', 'MongoDB'],
      ),
      TechStack(
        title: 'Tools',
        icon: Icons.build,
        color: AppColors.success,
        technologies: ['Git', 'Figma', 'VS Code', 'Postman'],
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: ScreenSize.isMobile(context) ? 60 : 80,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(
                context,
                'Teknologi yang Kami Gunakan',
                'Stack teknologi modern untuk performa optimal',
              ),
              
              SizedBox(height: ScreenSize.isMobile(context) ? 40 : 60),
              
              ResponsiveBuilder(
                mobile: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: techStacks.length,
                  itemBuilder: (context, index) => _buildTechCard(context, techStacks[index]),
                ),
                desktop: Row(
                  children: techStacks
                      .map((tech) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: _buildTechCard(context, tech),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechCard(BuildContext context, TechStack tech) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: tech.color.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: tech.color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: tech.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              tech.icon,
              color: tech.color,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            tech.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tech.technologies
                .map((technology) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tech.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        technology,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: tech.color,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenSize.isMobile(context) ? 10 : 12,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    final packages = [
      PricingPackage(
        name: 'Starter',
        price: 'Rp 5jt',
        period: 'per project',
        description: 'Cocok untuk bisnis kecil',
        features: [
          'Landing page responsive',
          'Basic SEO optimization',
          'Contact form integration',
          '3 bulan support',
        ],
        color: AppColors.neutral,
        isPopular: false,
      ),
      PricingPackage(
        name: 'Professional',
        price: 'Rp 15jt',
        period: 'per project',
        description: 'Solusi lengkap bisnis',
        features: [
          'Mobile app (iOS & Android)',
          'Admin panel web',
          'Push notifications',
          'Database integration',
          '6 bulan support',
        ],
        color: AppColors.primary,
        isPopular: true,
      ),
      PricingPackage(
        name: 'Enterprise',
        price: 'Custom',
        period: 'quote',
        description: 'Solusi skala enterprise',
        features: [
          'Custom development',
          'Advanced integrations',
          'Scalable architecture',
          'Priority support',
          '12 bulan support',
        ],
        color: AppColors.accent,
        isPopular: false,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: ScreenSize.isMobile(context) ? 60 : 80,
      ),
      color: AppColors.background,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(
                context,
                'Paket Harga Terjangkau',
                'Pilih paket yang sesuai dengan kebutuhan Anda',
              ),
              
              SizedBox(height: ScreenSize.isMobile(context) ? 40 : 60),
              
              ResponsiveBuilder(
                mobile: Column(
                  children: packages
                      .map((package) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _buildPricingCard(context, package),
                          ))
                      .toList(),
                ),
                desktop: Row(
                  children: packages
                      .map((package) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: _buildPricingCard(context, package),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard(BuildContext context, PricingPackage package) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: package.isPopular
            ? Border.all(color: package.color, width: 2)
            : Border.all(color: AppColors.neutral.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: package.isPopular 
                ? package.color.withOpacity(0.2) 
                : AppColors.neutral.withOpacity(0.1),
            blurRadius: package.isPopular ? 16 : 8,
            offset:  Offset(0, package.isPopular ? 8 : 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (package.isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: package.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'TERPOPULER',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          
          if (package.isPopular) const SizedBox(height: 16),
          
          Text(
            package.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: package.price,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: package.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' / ${package.period}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          Text(
            package.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          ...package.features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 18,
                  color: package.color,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feature,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          )),
          
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: package.isPopular
                ? CustomButton.primary(
                    text: 'Pilih Paket',
                    onPressed: () => context.go('/contact'),
                  )
                : CustomButton.secondary(
                    text: 'Pilih Paket',
                    onPressed: () => context.go('/contact'),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(ScreenSize.getResponsivePadding(context)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.isMobile(context) ? 32 : 48),
        child: Column(
          children: [
            Icon(
              Icons.rocket_launch,
              size: ScreenSize.isMobile(context) ? 48 : 64,
              color: AppColors.textLight,
            ),
            SizedBox(height: ScreenSize.isMobile(context) ? 20 : 24),
            Text(
              'Siap Memulai Project Anda?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textLight,
                fontWeight: FontWeight.bold,
                fontSize: ScreenSize.isMobile(context) ? 24 : 32,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              constraints: BoxConstraints(
                maxWidth: ScreenSize.isMobile(context) ? double.infinity : 500,
              ),
              child: Text(
                'Konsultasikan kebutuhan digital Anda dengan kami. Dapatkan solusi terbaik yang sesuai dengan budget dan timeline Anda.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textLight.withOpacity(0.9),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: ScreenSize.isMobile(context) ? 24 : 32),
            ResponsiveBuilder(
              mobile: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton.large(
                      text: 'Konsultasi Gratis Sekarang',
                      backgroundColor: AppColors.textLight,
                      onPressed: () => context.go('/contact'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton.secondary(
                      text: 'Lihat Portfolio',
                      onPressed: () => context.go('/portfolio'),
                    ),
                  ),
                ],
              ),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton.large(
                    text: 'Konsultasi Gratis Sekarang',
                    backgroundColor: AppColors.textLight,
                    onPressed: () => context.go('/contact'),
                  ),
                  const SizedBox(width: 16),
                  CustomButton.secondary(
                    text: 'Lihat Portfolio',
                    onPressed: () => context.go('/portfolio'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data Models
class ServiceDetail {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final String startingPrice;
  final Color color;
  final List<Color> gradient;

  ServiceDetail({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.startingPrice,
    required this.color,
    required this.gradient,
  });
}

class ProcessStep {
  final String number;
  final String title;
  final String description;
  final IconData icon;

  ProcessStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class TechStack {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> technologies;

  TechStack({
    required this.title,
    required this.icon,
    required this.color,
    required this.technologies,
  });
}

class PricingPackage {
  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final Color color;
  final bool isPopular;

  PricingPackage({
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.color,
    required this.isPopular,
  });
}