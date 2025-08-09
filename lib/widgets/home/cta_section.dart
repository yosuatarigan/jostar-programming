import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';
import '../../core/url_launcher_utils.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

class CTASection extends StatefulWidget {
  const CTASection({Key? key}) : super(key: key);

  @override
  State<CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<CTASection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
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
      margin: EdgeInsets.symmetric(
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
                  child: _buildMainCTA(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainCTA() {
    return Container(
      padding: EdgeInsets.all(ScreenSize.isMobile(context) ? 32 : 60),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
            AppColors.accent,
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 20),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.textLight.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1559136555-9303baea8ebd?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80'
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.primary.withOpacity(0.7),
                  BlendMode.multiply,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.9),
                    AppColors.secondary.withOpacity(0.8),
                    AppColors.accent.withOpacity(0.9),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(ScreenSize.isMobile(context) ? 24 : 40),
                child: ResponsiveBuilder(
                  mobile: _buildMobileContent(),
                  desktop: _buildDesktopContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildActionSection(),
        ),
      ],
    );
  }

  Widget _buildMobileContent() {
    return Column(
      children: [
        _buildTextContent(),
        const SizedBox(height: 40),
        _buildActionSection(),
      ],
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Icon Badge
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.textLight.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.textLight.withOpacity(0.3),
            ),
          ),
          child: const Icon(
            Icons.rocket_launch_rounded,
            size: 40,
            color: AppColors.textLight,
          ),
        ),

        const SizedBox(height: 32),

        // Main Heading
        Text(
          'Siap Memulai Project Digital Anda?',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: ScreenSize.isMobile(context) ? 28 : 42,
            fontWeight: FontWeight.bold,
            color: AppColors.textLight,
            height: 1.2,
          ),
          textAlign: ScreenSize.isMobile(context)
              ? TextAlign.center
              : TextAlign.left,
        ),

        const SizedBox(height: 20),

        // Description
        Text(
          'Mari wujudkan visi digital Anda bersama kami. Dapatkan konsultasi gratis '
          'dan solusi terbaik yang sesuai dengan kebutuhan bisnis Anda.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textLight.withOpacity(0.9),
            height: 1.6,
            fontSize: 18,
          ),
          textAlign: ScreenSize.isMobile(context)
              ? TextAlign.center
              : TextAlign.left,
        ),

        const SizedBox(height: 32),

        // Benefits List
        _buildBenefitsList(),
      ],
    );
  }

  Widget _buildBenefitsList() {
    final benefits = [
      'Konsultasi gratis 30 menit',
      'Estimasi project & timeline akurat',
      'Rekomendasi teknologi terbaik',
      'Guarantee 100% satisfaction',
    ];

    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: benefits.map((benefit) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisSize: ScreenSize.isMobile(context)
                ? MainAxisSize.min
                : MainAxisSize.max,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.textLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 14,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                benefit,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textLight.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionSection() {
    return Column(
      children: [
        // Urgent Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.textLight,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Limited Time Offer',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Action Buttons
        ResponsiveBuilder(
          mobile: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildActionButtons(),
          ),
          desktop: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildActionButtons(),
          ),
        ),

        const SizedBox(height: 32),

        // Contact Info Card
        _buildContactInfoCard(),
      ],
    );
  }

  List<Widget> _buildActionButtons() {
    return [
      // Primary CTA Button
      Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textLight.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () => context.go('/contact'),
          icon: const Icon(
            Icons.chat_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          label: Text(
            'Konsultasi Gratis Sekarang',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
        ),
      ),

      const SizedBox(height: 16),

      // WhatsApp Button
      Container(
        height: 56,
        child: OutlinedButton.icon(
          onPressed: () => UrlLauncherUtils.openWhatsApp(),
          icon: const Icon(
            Icons.phone_rounded,
            color: AppColors.textLight,
            size: 20,
          ),
          label: Text(
            'WhatsApp Langsung',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: AppColors.textLight.withOpacity(0.8),
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      const SizedBox(height: 16),

      // Secondary CTA
      Container(
        height: 56,
        child: TextButton.icon(
          onPressed: () => context.go('/portfolio'),
          icon: const Icon(
            Icons.visibility_rounded,
            color: AppColors.textLight,
            size: 18,
          ),
          label: Text(
            'Lihat Portfolio',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textLight.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.textLight.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildContactInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.textLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Response Guarantee',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16,
                color: AppColors.textLight.withOpacity(0.8),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'WhatsApp: 2 jam • Email: 4 jam',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.phone_rounded,
                size: 16,
                color: AppColors.textLight.withOpacity(0.8),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '+62 xxx-xxxx-xxxx',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}