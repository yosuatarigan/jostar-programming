import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

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
          _buildCTASection(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.secondary.withOpacity(0.1),
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
              Text(
                'Layanan Pengembangan Digital',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: ScreenSize.isMobile(context) ? 32 : 48,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Solusi lengkap untuk kebutuhan digital bisnis Anda, dari konsep hingga deployment',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              Text(
                'Layanan Kami',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildServicesList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesList(BuildContext context) {
    final services = [
      DetailedService(
        icon: Icons.phone_android,
        title: 'Custom Mobile App Development',
        description: 'Pengembangan aplikasi mobile native menggunakan Flutter untuk iOS dan Android',
        features: [
          'Cross-platform development dengan satu codebase',
          'Performance tinggi setara aplikasi native',
          'UI/UX design yang modern dan intuitif',
          'Integrasi dengan API dan database',
          'Push notification dan offline capability',
          'App Store & Play Store deployment',
        ],
        pricing: 'Mulai dari Rp 15.000.000',
        timeline: '4-12 minggu',
        color: AppColors.primary,
      ),
      DetailedService(
        icon: Icons.web,
        title: 'Custom Website Development',
        description: 'Pembuatan website responsif dan aplikasi web menggunakan teknologi terdepan',
        features: [
          'Responsive design untuk semua device',
          'SEO optimized untuk ranking Google',
          'Fast loading speed dan performance',
          'CMS integration untuk mudah dikelola',
          'E-commerce functionality',
          'SSL certificate dan security',
        ],
        pricing: 'Mulai dari Rp 8.000.000',
        timeline: '3-8 minggu',
        color: AppColors.secondary,
      ),
      DetailedService(
        icon: Icons.shopping_cart,
        title: 'Ready-to-Use Applications',
        description: 'Aplikasi bisnis siap pakai yang dapat langsung digunakan untuk berbagai industri',
        features: [
          'Point of Sale (POS) system',
          'Inventory management system',
          'Restaurant ordering system',
          'Online learning platform',
          'Healthcare management system',
          'Customization sesuai branding',
        ],
        pricing: 'Mulai dari Rp 3.000.000',
        timeline: '1-3 minggu',
        color: AppColors.accent,
      ),
    ];

    return Column(
      children: services.map((service) => Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: _buildDetailedServiceCard(context, service),
      )).toList(),
    );
  }

  Widget _buildDetailedServiceCard(BuildContext context, DetailedService service) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ResponsiveBuilder(
        mobile: _buildMobileServiceCard(context, service),
        desktop: _buildDesktopServiceCard(context, service),
      ),
    );
  }

  Widget _buildDesktopServiceCard(BuildContext context, DetailedService service) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and basic info
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: service.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  service.icon,
                  size: 40,
                  color: service.color,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                service.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                service.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _buildPricingInfo(context, service),
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Features
        Expanded(
          flex: 4,
          child: _buildFeaturesList(context, service),
        ),
      ],
    );
  }

  Widget _buildMobileServiceCard(BuildContext context, DetailedService service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: service.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                service.icon,
                size: 32,
                color: service.color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    service.pricing,
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
        const SizedBox(height: 20),
        Text(
          service.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        _buildFeaturesList(context, service),
        const SizedBox(height: 20),
        _buildPricingInfo(context, service),
      ],
    );
  }

  Widget _buildFeaturesList(BuildContext context, DetailedService service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yang Anda Dapatkan:',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildPricingInfo(BuildContext context, DetailedService service) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: service.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: service.color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.payments,
                size: 20,
                color: service.color,
              ),
              const SizedBox(width: 8),
              Text(
                service.pricing,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: service.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                'Timeline: ${service.timeline}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomButton.secondary(
              text: 'Konsultasi Sekarang',
              onPressed: () => context.go('/contact'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 80,
      ),
      color: AppColors.background,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              Text(
                'Proses Pengembangan',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Metodologi yang terbukti untuk menghasilkan produk digital berkualitas tinggi',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildProcessSteps(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessSteps(BuildContext context) {
    final steps = [
      ProcessStep(
        number: '01',
        title: 'Konsultasi & Analisis',
        description: 'Memahami kebutuhan bisnis dan merencanakan solusi terbaik',
        icon: Icons.chat,
      ),
      ProcessStep(
        number: '02',
        title: 'Design & Prototype',
        description: 'Membuat wireframe dan prototype untuk validasi konsep',
        icon: Icons.design_services,
      ),
      ProcessStep(
        number: '03',
        title: 'Development',
        description: 'Pengembangan aplikasi dengan metodologi Agile',
        icon: Icons.code,
      ),
      ProcessStep(
        number: '04',
        title: 'Testing & QA',
        description: 'Pengujian menyeluruh untuk memastikan kualitas',
        icon: Icons.bug_report,
      ),
      ProcessStep(
        number: '05',
        title: 'Deployment',
        description: 'Peluncuran ke production dan monitoring',
        icon: Icons.rocket_launch,
      ),
      ProcessStep(
        number: '06',
        title: 'Support & Maintenance',
        description: 'Dukungan berkelanjutan dan update fitur',
        icon: Icons.support_agent,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: steps.map((step) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildProcessCard(context, step),
        )).toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.1,
        ),
        itemCount: steps.length,
        itemBuilder: (context, index) => _buildProcessCard(context, steps[index]),
      ),
    );
  }

  Widget _buildProcessCard(BuildContext context, ProcessStep step) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  step.icon,
                  size: 24,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              Text(
                step.number,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            step.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.description,
            style: Theme.of(context).textTheme.bodyMedium,
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
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              Text(
                'Teknologi yang Kami Gunakan',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
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
        technologies: ['Flutter', 'Dart', 'iOS SDK', 'Android SDK'],
        color: AppColors.primary,
      ),
      TechCategory(
        title: 'Web Development',
        technologies: ['Flutter Web', 'HTML5', 'CSS3', 'JavaScript'],
        color: AppColors.secondary,
      ),
      TechCategory(
        title: 'Backend & Database',
        technologies: ['Firebase', 'Node.js', 'PostgreSQL', 'MongoDB'],
        color: AppColors.accent,
      ),
      TechCategory(
        title: 'Design & Tools',
        technologies: ['Figma', 'Adobe XD', 'Git', 'VS Code'],
        color: AppColors.success,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: techCategories.map((category) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildTechCard(context, category),
        )).toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.5,
        ),
        itemCount: techCategories.length,
        itemBuilder: (context, index) => _buildTechCard(context, techCategories[index]),
      ),
    );
  }

  Widget _buildTechCard(BuildContext context, TechCategory category) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: category.color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: category.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.technologies.map((tech) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.neutral.withOpacity(0.3),
                ),
              ),
              child: Text(
                tech,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )).toList(),
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
        vertical: 80,
      ),
      color: AppColors.background,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              Text(
                'Paket Harga Terjangkau',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Pilih paket yang sesuai dengan kebutuhan dan budget Anda',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
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
        description: 'Cocok untuk bisnis kecil yang baru memulai',
        features: [
          'Landing page responsif',
          'Basic SEO optimization',
          'Contact form',
          '3 bulan support',
        ],
        isPopular: false,
        color: AppColors.neutral,
      ),
      PricingPackage(
        name: 'Professional',
        price: 'Rp 15.000.000',
        description: 'Solusi lengkap untuk bisnis berkembang',
        features: [
          'Mobile app (iOS & Android)',
          'Admin panel web',
          'Push notifications',
          'Database integration',
          '6 bulan support',
        ],
        isPopular: true,
        color: AppColors.primary,
      ),
      PricingPackage(
        name: 'Enterprise',
        price: 'Custom Quote',
        description: 'Solusi khusus untuk enterprise',
        features: [
          'Custom development',
          'Advanced integrations',
          'Scalable architecture',
          'Priority support',
          '12 bulan support',
        ],
        isPopular: false,
        color: AppColors.accent,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: packages.map((package) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildPricingCard(context, package),
        )).toList(),
      ),
      desktop: Row(
        children: packages.map((package) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildPricingCard(context, package),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildPricingCard(BuildContext context, PricingPackage package) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: package.isPopular 
            ? Border.all(color: package.color, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          if (package.isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: package.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'TERPOPULER',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          if (package.isPopular) const SizedBox(height: 16),
          
          Text(
            package.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            package.price,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: package.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            package.description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
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
          
          const SizedBox(height: 32),
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
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 40,
      ),
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Siap Memulai Project Anda?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Konsultasikan kebutuhan digital Anda dengan kami sekarang juga',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textLight.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton.large(
              text: 'Konsultasi Gratis Sekarang',
              backgroundColor: AppColors.textLight,
              onPressed: () => context.go('/contact'),
            ),
          ],
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

  DetailedService({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.pricing,
    required this.timeline,
    required this.color,
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

class TechCategory {
  final String title;
  final List<String> technologies;
  final Color color;

  TechCategory({
    required this.title,
    required this.technologies,
    required this.color,
  });
}

class PricingPackage {
  final String name;
  final String price;
  final String description;
  final List<String> features;
  final bool isPopular;
  final Color color;

  PricingPackage({
    required this.name,
    required this.price,
    required this.description,
    required this.features,
    required this.isPopular,
    required this.color,
  });
}