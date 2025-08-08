import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

class CTASection extends StatelessWidget {
  const CTASection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 40,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: ScreenSize.getMaxContentWidth(context),
        ),
        child: ResponsiveBuilder(
          mobile: _buildMobileCTA(context),
          desktop: _buildDesktopCTA(context),
        ),
      ),
    );
  }

  Widget _buildDesktopCTA(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _buildCTAContent(context),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 3,
            child: _buildCTAButtons(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCTA(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          _buildCTAContent(context),
          const SizedBox(height: 32),
          _buildCTAButtons(context),
        ],
      ),
    );
  }

  Widget _buildCTAContent(BuildContext context) {
    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context) 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.textLight.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.rocket_launch,
            size: 32,
            color: AppColors.textLight,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Main Heading
        Text(
          'Siap Memulai Project Digital Anda?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.isMobile(context) ? 28 : 36,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        
        const SizedBox(height: 16),
        
        // Description
        Text(
          'Konsultasikan ide bisnis digital Anda dengan kami. '
          'Dapatkan solusi terbaik yang sesuai dengan kebutuhan dan budget Anda.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textLight.withOpacity(0.9),
            height: 1.6,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        
        const SizedBox(height: 24),
        
        // Features List
        _buildFeaturesList(context),
      ],
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final features = [
      'Konsultasi gratis 30 menit',
      'Estimasi project & timeline',
      'Rekomendasi teknologi terbaik',
    ];

    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context) 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: features.map((feature) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisSize: ScreenSize.isMobile(context) 
              ? MainAxisSize.min 
              : MainAxisSize.max,
          children: [
            Icon(
              Icons.check_circle,
              size: 20,
              color: AppColors.textLight,
            ),
            const SizedBox(width: 12),
            Text(
              feature,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textLight.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildCTAButtons(BuildContext context) {
    return ResponsiveBuilder(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton.large(
            text: 'Konsultasi Gratis Sekarang',
            backgroundColor: AppColors.textLight,
            onPressed: () => context.go('/contact'),
          ),
          const SizedBox(height: 16),
          _buildSecondaryButton(context),
        ],
      ),
      desktop: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton.large(
            text: 'Konsultasi Gratis',
            backgroundColor: AppColors.textLight,
            onPressed: () => context.go('/contact'),
          ),
          const SizedBox(height: 16),
          _buildSecondaryButton(context),
          const SizedBox(height: 24),
          _buildContactInfo(context),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.go('/portfolio'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textLight,
        side: BorderSide(color: AppColors.textLight.withOpacity(0.8), width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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

  Widget _buildContactInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 18,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 8),
              Text(
                '+62 xxx-xxxx-xxxx',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 18,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 8),
              Text(
                'yosua@jostar.dev',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}