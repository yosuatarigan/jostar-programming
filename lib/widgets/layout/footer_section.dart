import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jostar_programming/core/constant.dart';
import '../../core/app_theme.dart';
import '../../core/url_launcher_utils.dart';
import '../common/responsive_builder.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textPrimary,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 60,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: ResponsiveBuilder(
            mobile: _buildMobileFooter(context),
            desktop: _buildDesktopFooter(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _buildCompanySection(context),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: _buildQuickLinksSection(context),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _buildServicesSection(context),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _buildContactSection(context),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Divider(color: AppColors.neutral.withOpacity(0.3)),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© 2024 ${AppConstants.companyName}. All rights reserved.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textLight.withOpacity(0.7),
              ),
            ),
            Row(
              children: [
                _buildSocialIcon(context, Icons.code, AppConstants.githubUrl),
                const SizedBox(width: 12),
                _buildSocialIcon(context, Icons.work, AppConstants.linkedinUrl),
                const SizedBox(width: 12),
                _buildSocialIcon(context, Icons.photo_camera, AppConstants.instagramUrl),
                const SizedBox(width: 12),
                _buildSocialIcon(context, Icons.play_arrow, AppConstants.youtubeUrl),
              ],
            ),
            Text(
              'Made with ❤️ in Indonesia',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textLight.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildCompanySection(context),
        const SizedBox(height: 32),
        
        Row(
          children: [
            Expanded(child: _buildQuickLinksSection(context)),
            const SizedBox(width: 32),
            Expanded(child: _buildServicesSection(context)),
          ],
        ),
        
        const SizedBox(height: 32),
        _buildContactSection(context),
        
        const SizedBox(height: 32),
        
        // Social Media
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(context, Icons.code, AppConstants.githubUrl),
            const SizedBox(width: 16),
            _buildSocialIcon(context, Icons.work, AppConstants.linkedinUrl),
            const SizedBox(width: 16),
            _buildSocialIcon(context, Icons.photo_camera, AppConstants.instagramUrl),
            const SizedBox(width: 16),
            _buildSocialIcon(context, Icons.play_arrow, AppConstants.youtubeUrl),
          ],
        ),
        
        const SizedBox(height: 24),
        Divider(color: AppColors.neutral.withOpacity(0.3)),
        const SizedBox(height: 20),
        
        Text(
          '© 2024 ${AppConstants.companyName}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textLight.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Made with ❤️ in Indonesia',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textLight.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCompanySection(BuildContext context) {
    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context) 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: [
        // Logo and Company Name
        Row(
          mainAxisSize: ScreenSize.isMobile(context) 
              ? MainAxisSize.min 
              : MainAxisSize.max,
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
              AppConstants.companyName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Text(
          AppConstants.companyTagline,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        
        const SizedBox(height: 12),
        
        Text(
          'Mengembangkan aplikasi mobile dan website berkualitas tinggi '
          'untuk transformasi digital bisnis Indonesia.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textLight.withOpacity(0.8),
            height: 1.6,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
          maxLines: 3,
        ),
        
        if (!ScreenSize.isMobile(context)) ...[
          const SizedBox(height: 20),
          
          // Quick Contact Buttons
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () => UrlLauncherUtils.openWhatsApp(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.chat,
                        size: 16,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'WhatsApp',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textLight.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () => UrlLauncherUtils.openEmail(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.email,
                        size: 16,
                        color: AppColors.textLight.withOpacity(0.8),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textLight.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {
    final links = [
      ('Home', '/'),
      ('Services', '/services'),
      ('Portfolio', '/portfolio'),
      ('Store', '/store'),
      ('About', '/about'),
      ('Contact', '/contact'),
    ];

    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context) 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () => context.go(link.$2),
            child: Text(
              link.$1,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textLight.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final services = [
      'Mobile App Development',
      'Website Development',
      'E-commerce Solutions',
      'Custom Development',
      'Ready-to-Use Apps',
      'Consultation Services',
    ];

    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context) 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...services.map((service) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            service,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textLight.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: ScreenSize.isMobile(context) 
                ? TextAlign.center 
                : TextAlign.left,
          ),
        )),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context) 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildContactItem(
          context,
          icon: Icons.email,
          text: AppConstants.email,
          onTap: () => UrlLauncherUtils.openEmail(),
        ),
        
        const SizedBox(height: 8),
        
        _buildContactItem(
          context,
          icon: Icons.phone,
          text: AppConstants.phone,
          onTap: () => UrlLauncherUtils.openPhone(),
        ),
        
        const SizedBox(height: 8),
        
        _buildContactItem(
          context,
          icon: Icons.location_on,
          text: AppConstants.location,
          onTap: () => UrlLauncherUtils.openGoogleMaps(),
        ),
        
        const SizedBox(height: 8),
        
        _buildContactItem(
          context,
          icon: Icons.schedule,
          text: AppConstants.businessHours,
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: ScreenSize.isMobile(context) 
            ? MainAxisSize.min 
            : MainAxisSize.max,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textLight.withOpacity(0.6),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textLight.withOpacity(0.8),
                height: 1.5,
              ),
              textAlign: ScreenSize.isMobile(context) 
                  ? TextAlign.center 
                  : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String url) {
    return GestureDetector(
      onTap: () => UrlLauncherUtils.launchExternalUrl(url),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.textLight.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.textLight.withOpacity(0.2),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppColors.textLight.withOpacity(0.8),
        ),
      ),
    );
  }
}