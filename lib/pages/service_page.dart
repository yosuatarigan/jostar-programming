import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> 
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildServicesSection(context),
          _buildProcessSection(context),
          _buildTechnologiesSection(context),
          _buildPricingSection(context),
          _buildTestimonialsSection(context),
          _buildCTASection(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenSize.isMobile(context) ? 600 : 700,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.8),
              AppColors.secondary.withOpacity(0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getResponsivePadding(context),
              vertical: 60,
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: ScreenSize.getMaxContentWidth(context),
                ),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColors.accent.withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                '🚀 SOLUSI DIGITAL TERBAIK',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'Layanan Pengembangan\nDigital Terdepan',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: ScreenSize.isMobile(context) ? 36 : 56,
                                color: AppColors.textLight,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              child: Text(
                                'Dari konsep hingga deployment, kami mengembangkan aplikasi mobile dan website berkualitas enterprise dengan teknologi terdepan',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textLight.withOpacity(0.9),
                                  fontSize: 18,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 40),
                            ResponsiveBuilder(
                              mobile: Column(
                                children: [
                                  _buildHeroButton(
                                    'Konsultasi Gratis', 
                                    () => context.go('/contact'),
                                    isPrimary: true,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildHeroButton(
                                    'Lihat Portfolio', 
                                    () => context.go('/portfolio'),
                                    isPrimary: false,
                                  ),
                                ],
                              ),
                              desktop: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildHeroButton(
                                    'Konsultasi Gratis', 
                                    () => context.go('/contact'),
                                    isPrimary: true,
                                  ),
                                  const SizedBox(width: 20),
                                  _buildHeroButton(
                                    'Lihat Portfolio', 
                                    () => context.go('/portfolio'),
                                    isPrimary: false,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
                            _buildHeroStats(context),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroButton(String text, VoidCallback onPressed, {required bool isPrimary}) {
    return Container(
      width: ScreenSize.isMobile(context) ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.accent : Colors.transparent,
          foregroundColor: AppColors.textLight,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isPrimary ? AppColors.accent : AppColors.textLight,
              width: 2,
            ),
          ),
          elevation: isPrimary ? 8 : 0,
          shadowColor: AppColors.accent.withOpacity(0.5),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroStats(BuildContext context) {
    final stats = [
      {'number': '50+', 'label': 'Projects Delivered'},
      {'number': '20+', 'label': 'Happy Clients'},
      {'number': '3+', 'label': 'Years Experience'},
      {'number': '24/7', 'label': 'Support Available'},
    ];

    return ResponsiveBuilder(
      mobile: Wrap(
        alignment: WrapAlignment.center,
        spacing: 30,
        runSpacing: 20,
        children: stats.map((stat) => _buildStatCard(context, stat)).toList(),
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.map((stat) => _buildStatCard(context, stat)).toList(),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, Map<String, String> stat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.textLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            stat['number']!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            stat['label']!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textLight.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
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
                'Layanan Unggulan Kami',
                'Solusi digital end-to-end yang disesuaikan dengan kebutuhan bisnis Anda',
              ),
              const SizedBox(height: 80),
              _buildServicesList(context),
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
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            subtitle,
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

  Widget _buildServicesList(BuildContext context) {
    final services = [
      DetailedService(
        icon: Icons.phone_android,
        title: 'Custom Mobile App Development',
        description: 'Aplikasi mobile native dengan Flutter untuk iOS dan Android, menghadirkan performance setara native dengan development time yang efisien.',
        features: [
          'Cross-platform development dengan single codebase',
          'UI/UX design yang modern dan user-friendly', 
          'Integration dengan API dan third-party services',
          'Push notification dan offline capability',
          'App Store & Play Store deployment',
          'Real-time data synchronization',
        ],
        pricing: 'Mulai dari Rp 15.000.000',
        timeline: '6-12 minggu',
        color: AppColors.primary,
        imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        technologies: ['Flutter', 'Dart', 'Firebase', 'REST API'],
      ),
      DetailedService(
        icon: Icons.web,
        title: 'Custom Website Development',
        description: 'Website responsif dan web application modern menggunakan teknologi terdepan untuk memberikan user experience yang optimal.',
        features: [
          'Responsive design untuk semua device',
          'SEO optimization untuk ranking Google',
          'Progressive Web App (PWA) capability',
          'Content Management System integration',
          'E-commerce functionality',
          'Advanced analytics dan reporting',
        ],
        pricing: 'Mulai dari Rp 8.000.000',
        timeline: '4-8 minggu',
        color: AppColors.secondary,
        imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2015&q=80',
        technologies: ['Flutter Web', 'HTML5', 'CSS3', 'JavaScript'],
      ),
      DetailedService(
        icon: Icons.shopping_cart,
        title: 'Ready-to-Use Business Solutions',
        description: 'Aplikasi bisnis siap pakai yang dapat langsung digunakan dan di-customize sesuai branding perusahaan Anda.',
        features: [
          'Point of Sale (POS) system',
          'Inventory management system',
          'Customer relationship management',
          'Online booking dan reservation',
          'Digital payment integration',
          'Business analytics dashboard',
        ],
        pricing: 'Mulai dari Rp 3.000.000',
        timeline: '1-3 minggu',
        color: AppColors.accent,
        imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        technologies: ['Flutter', 'Firebase', 'Cloud Functions', 'Analytics'],
      ),
    ];

    return Column(
      children: services.asMap().entries.map((entry) {
        int index = entry.key;
        DetailedService service = entry.value;
        bool isEven = index % 2 == 0;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: ResponsiveBuilder(
            mobile: _buildMobileServiceCard(context, service),
            desktop: _buildDesktopServiceCard(context, service, isEven),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopServiceCard(BuildContext context, DetailedService service, bool isEven) {
    Widget imageWidget = _buildServiceImage(context, service);
    Widget contentWidget = _buildServiceContent(context, service);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: service.color.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(
          children: isEven 
            ? [
                Expanded(flex: 5, child: contentWidget),
                const SizedBox(width: 50),
                Expanded(flex: 4, child: imageWidget),
              ]
            : [
                Expanded(flex: 4, child: imageWidget),
                const SizedBox(width: 50),
                Expanded(flex: 5, child: contentWidget),
              ],
        ),
      ),
    );
  }

  Widget _buildMobileServiceCard(BuildContext context, DetailedService service) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: service.color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildServiceImage(context, service),
          Padding(
            padding: const EdgeInsets.all(30),
            child: _buildServiceContent(context, service),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceImage(BuildContext context, DetailedService service) {
    return Container(
      height: ScreenSize.isMobile(context) ? 200 : 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(service.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              service.color.withOpacity(0.8),
              service.color.withOpacity(0.6),
            ],
          ),
        ),
        child: Center(
          child: Icon(
            service.icon,
            size: 60,
            color: AppColors.textLight,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceContent(BuildContext context, DetailedService service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: service.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            service.pricing,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: service.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          service.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          service.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        
        // Features
        Text(
          'Yang Anda Dapatkan:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...service.features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: service.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )),
        
        const SizedBox(height: 24),
        
        // Technologies
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: service.technologies.map((tech) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: service.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: service.color.withOpacity(0.3),
              ),
            ),
            child: Text(
              tech,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: service.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
        
        const SizedBox(height: 32),
        
        // Action Buttons
        ResponsiveBuilder(
          mobile: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton.primary(
                text: 'Mulai Project',
                onPressed: () => context.go('/contact'),
              ),
              const SizedBox(height: 12),
              CustomButton.secondary(
                text: 'Lihat Detail',
                onPressed: () => context.go('/portfolio'),
              ),
            ],
          ),
          desktop: Row(
            children: [
              Expanded(
                child: CustomButton.primary(
                  text: 'Mulai Project',
                  onPressed: () => context.go('/contact'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton.secondary(
                  text: 'Lihat Detail',
                  onPressed: () => context.go('/portfolio'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProcessSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80'
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.95),
        ),
        padding: const EdgeInsets.all(60),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: ScreenSize.getMaxContentWidth(context),
            ),
            child: Column(
              children: [
                Text(
                  'Proses Development yang Terbukti',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Metodologi Agile yang memastikan kualitas dan ketepatan waktu delivery',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textLight.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                _buildProcessSteps(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessSteps(BuildContext context) {
    final steps = [
      ProcessStep(
        number: '01',
        title: 'Discovery & Analysis',
        description: 'Memahami kebutuhan bisnis dan merencanakan arsitektur solusi',
        icon: Icons.search,
        imageUrl: 'https://images.unsplash.com/photo-1553484771-cc0d9b8c2b33?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
      ProcessStep(
        number: '02',
        title: 'UI/UX Design',
        description: 'Menciptakan wireframe, prototype, dan design system yang optimal',
        icon: Icons.design_services,
        imageUrl: 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
      ProcessStep(
        number: '03',
        title: 'Development',
        description: 'Pengembangan aplikasi dengan metodologi Agile dan best practices',
        icon: Icons.code,
        imageUrl: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
      ProcessStep(
        number: '04',
        title: 'Testing & QA',
        description: 'Pengujian menyeluruh untuk memastikan kualitas dan performa',
        icon: Icons.bug_report,
        imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
      ProcessStep(
        number: '05',
        title: 'Deployment',
        description: 'Peluncuran ke production dengan monitoring dan optimization',
        icon: Icons.rocket_launch,
        imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
      ProcessStep(
        number: '06',
        title: 'Maintenance',
        description: 'Support berkelanjutan, update, dan enhancement fitur',
        icon: Icons.support_agent,
        imageUrl: 'https://images.unsplash.com/photo-1559136555-9303baea8ebd?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: steps.map((step) => Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: _buildProcessCard(context, step),
        )).toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 0.9,
        ),
        itemCount: steps.length,
        itemBuilder: (context, index) => _buildProcessCard(context, steps[index]),
      ),
    );
  }

  Widget _buildProcessCard(BuildContext context, ProcessStep step) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(step.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.7),
                    AppColors.primary.withOpacity(0.5),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.textLight,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          step.number,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      step.icon,
                      size: 40,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  step.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologiesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
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
                'Teknologi & Tools Terdepan',
                'Stack teknologi modern yang kami gunakan untuk membangun solusi berkualitas enterprise',
              ),
              const SizedBox(height: 80),
              _buildTechStack(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechStack(BuildContext context) {
    final techCategories = [
      TechCategory(
        title: 'Mobile Development',
        technologies: [
          TechItem('Flutter', 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('Dart', 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('iOS SDK', 'https://images.unsplash.com/photo-1611606063065-ee7946f0787a?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('Android SDK', 'https://images.unsplash.com/photo-1607252650355-f7fd0460ccdb?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
        ],
        color: AppColors.primary,
        icon: Icons.phone_android,
      ),
      TechCategory(
        title: 'Web Development',
        technologies: [
          TechItem('Flutter Web', 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('HTML5', 'https://images.unsplash.com/photo-1621839673705-6617adf9e890?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('CSS3', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('JavaScript', 'https://images.unsplash.com/photo-1627398242454-45a1465c2479?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
        ],
        color: AppColors.secondary,
        icon: Icons.web,
      ),
      TechCategory(
        title: 'Backend & Database',
        technologies: [
          TechItem('Firebase', 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('Node.js', 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('PostgreSQL', 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
          TechItem('MongoDB', 'https://images.unsplash.com/photo-1553484771-99119a180ae6?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80'),
        ],
        color: AppColors.accent,
        icon: Icons.storage,
      ),
    ];

    return Column(
      children: techCategories.map((category) => Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: _buildTechCategoryCard(context, category),
      )).toList(),
    );
  }

  Widget _buildTechCategoryCard(BuildContext context, TechCategory category) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: category.color.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [category.color, category.color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  category.icon,
                  size: 30,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: category.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ResponsiveBuilder(
            mobile: Column(
              children: category.technologies.map((tech) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildTechItem(context, tech, category.color),
              )).toList(),
            ),
            desktop: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
              ),
              itemCount: category.technologies.length,
              itemBuilder: (context, index) => _buildTechItem(
                context, 
                category.technologies[index], 
                category.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechItem(BuildContext context, TechItem tech, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(tech.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color.withOpacity(0.8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            tech.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.primary.withOpacity(0.05),
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
              _buildSectionHeader(
                context,
                'Paket Harga Terjangkau',
                'Investasi yang tepat untuk transformasi digital bisnis Anda',
              ),
              const SizedBox(height: 80),
              _buildPricingCards(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCards(BuildContext context) {
    final packages = [
      PricingPackage(
        name: 'Starter',
        price: 'Rp 5.000.000',
        description: 'Perfect untuk startup dan bisnis kecil',
        features: [
          'Landing page responsif',
          'Basic SEO optimization',
          'Contact form integration',
          'Social media integration',
          '3 bulan support',
          'SSL certificate included',
        ],
        isPopular: false,
        color: AppColors.neutral,
        imageUrl: 'https://images.unsplash.com/photo-1559136555-9303baea8ebd?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
      PricingPackage(
        name: 'Professional',
        price: 'Rp 15.000.000',
        description: 'Solusi lengkap untuk bisnis berkembang',
        features: [
          'Mobile app (iOS & Android)',
          'Admin panel web dashboard',
          'Push notifications',
          'Database integration',
          'Payment gateway',
          'Advanced analytics',
          '6 bulan support',
        ],
        isPopular: true,
        color: AppColors.primary,
        imageUrl: 'https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
      PricingPackage(
        name: 'Enterprise',
        price: 'Custom Quote',
        description: 'Solusi enterprise untuk scale besar',
        features: [
          'Custom development',
          'Advanced integrations',
          'Scalable architecture',
          'DevOps & CI/CD',
          'Security audit',
          'Priority support',
          '12 bulan support',
        ],
        isPopular: false,
        color: AppColors.accent,
        imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: packages.map((package) => Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: _buildPricingCard(context, package),
        )).toList(),
      ),
      desktop: Row(
        children: packages.map((package) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: _buildPricingCard(context, package),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildPricingCard(BuildContext context, PricingPackage package) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: package.isPopular 
            ? Border.all(color: package.color, width: 3)
            : null,
        boxShadow: [
          BoxShadow(
            color: package.color.withOpacity(0.1),
            blurRadius: package.isPopular ? 30 : 20,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with image
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              image: DecorationImage(
                image: NetworkImage(package.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                gradient: LinearGradient(
                  colors: [
                    package.color.withOpacity(0.8),
                    package.color.withOpacity(0.6),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  if (package.isPopular)
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '🔥 MOST POPULAR',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textLight,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      package.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  package.price,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: package.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  package.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                
                // Features
                ...package.features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 20,
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
                
                const SizedBox(height: 30),
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
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.95),
        ),
        padding: const EdgeInsets.all(60),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: ScreenSize.getMaxContentWidth(context),
            ),
            child: Column(
              children: [
                Text(
                  'Apa Kata Klien Kami',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                ResponsiveBuilder(
                  mobile: Column(
                    children: [
                      _buildTestimonialCard(context),
                    ],
                  ),
                  desktop: Row(
                    children: [
                      Expanded(child: _buildTestimonialCard(context)),
                      const SizedBox(width: 30),
                      Expanded(child: _buildTestimonialCard(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote,
            size: 40,
            color: AppColors.accent,
          ),
          const SizedBox(height: 20),
          Text(
            '"Jostar Programming berhasil mengembangkan aplikasi mobile yang sempurna untuk bisnis kami. Tim yang profesional dan hasil yang memuaskan!"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primary,
                child: Text(
                  'BS',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budi Santoso',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'CEO, TokoBagus Indonesia',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 40,
      ),
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.9),
              AppColors.secondary.withOpacity(0.8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '🚀',
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 20),
                Text(
                  'Siap Memulai Project Digital Anda?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    'Mari diskusikan ide digital Anda dan wujudkan menjadi kenyataan dengan teknologi terbaik',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textLight.withOpacity(0.9),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                ResponsiveBuilder(
                  mobile: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomButton.large(
                        text: 'Konsultasi Gratis Sekarang',
                        backgroundColor: AppColors.accent,
                        onPressed: () => context.go('/contact'),
                      ),
                      const SizedBox(height: 16),
                      _buildSecondaryButton(context),
                    ],
                  ),
                  desktop: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton.large(
                        text: 'Konsultasi Gratis Sekarang',
                        backgroundColor: AppColors.accent,
                        onPressed: () => context.go('/contact'),
                      ),
                      const SizedBox(width: 20),
                      _buildSecondaryButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.go('/portfolio'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textLight,
        side: BorderSide(color: AppColors.textLight, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        'Lihat Portfolio',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Data Models
class DetailedService {
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;
  final String pricing;
  final String timeline;
  final Color color;
  final String imageUrl;
  final List<String> technologies;

  DetailedService({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.pricing,
    required this.timeline,
    required this.color,
    required this.imageUrl,
    required this.technologies,
  });
}

class ProcessStep {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final String imageUrl;

  ProcessStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.imageUrl,
  });
}

class TechCategory {
  final String title;
  final List<TechItem> technologies;
  final Color color;
  final IconData icon;

  TechCategory({
    required this.title,
    required this.technologies,
    required this.color,
    required this.icon,
  });
}

class TechItem {
  final String name;
  final String imageUrl;

  TechItem(this.name, this.imageUrl);
}

class PricingPackage {
  final String name;
  final String price;
  final String description;
  final List<String> features;
  final bool isPopular;
  final Color color;
  final String imageUrl;

  PricingPackage({
    required this.name,
    required this.price,
    required this.description,
    required this.features,
    required this.isPopular,
    required this.color,
    required this.imageUrl,
  });
}