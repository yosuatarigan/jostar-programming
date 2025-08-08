import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

class ServicesOverview extends StatelessWidget {
  const ServicesOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              _buildSectionHeader(context),
              const SizedBox(height: 60),
              _buildServicesGrid(context),
              const SizedBox(height: 60),
              CustomButton.primary(
                text: 'Lihat Semua Layanan',
                onPressed: () => context.go('/services'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'LAYANAN KAMI',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Solusi Digital Terlengkap',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Dari aplikasi mobile hingga website, kami menyediakan layanan pengembangan digital yang komprehensif untuk mendukung pertumbuhan bisnis Anda.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      ServiceItem(
        icon: Icons.phone_android,
        title: 'Custom Mobile App',
        description: 'Aplikasi mobile native dengan Flutter untuk iOS dan Android',
        features: ['Cross-platform', 'Performance tinggi', 'UI/UX modern'],
        color: AppColors.primary,
      ),
      ServiceItem(
        icon: Icons.web,
        title: 'Custom Website',
        description: 'Website responsif dan aplikasi web dengan teknologi terdepan',
        features: ['Responsive design', 'SEO optimized', 'Fast loading'],
        color: AppColors.secondary,
      ),
      ServiceItem(
        icon: Icons.shopping_cart,
        title: 'Ready-to-Use Apps',
        description: 'Aplikasi bisnis siap pakai yang dapat langsung digunakan',
        features: ['Plug & play', 'Harga terjangkau', 'Support included'],
        color: AppColors.accent,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: services.map((service) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildServiceCard(context, service),
        )).toList(),
      ),
      desktop: Row(
        children: services.map((service) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildServiceCard(context, service),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceItem service) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
          const SizedBox(height: 20),
          ...service.features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: service.color,
                ),
                const SizedBox(width: 8),
                Text(
                  feature,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CustomButton.secondary(
              text: 'Pelajari Lebih Lanjut',
              onPressed: () => context.go('/services'),
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
  final String description;
  final List<String> features;
  final Color color;

  ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.color,
  });
}