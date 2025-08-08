import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.secondary.withOpacity(0.1),
            AppColors.surface,
          ],
        ),
      ),
      child: ResponsiveBuilder(
        mobile: _buildMobileHero(),
        desktop: _buildDesktopHero(),
      ),
    );
  }

  Widget _buildDesktopHero() {
    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: _buildHeroContent(),
              ),
              const SizedBox(width: 80),
              Expanded(
                flex: 4,
                child: _buildHeroVisual(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileHero() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      child: Column(
        children: [
          _buildHeroContent(),
          const SizedBox(height: 40),
          _buildHeroVisual(),
        ],
      ),
    );
  }

  Widget _buildHeroContent() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                  ),
                  child: Text(
                    '🚀 Mobile App & Website Solutions',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Wujudkan Bisnis Digital Anda Bersama',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 32 : 48,
                  ),
                ),
                const SizedBox(height: 8),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ).createShader(bounds),
                  child: Text(
                    'Jostar Programming',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: ScreenSize.isMobile(context) ? 32 : 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Kami mengembangkan aplikasi mobile dan website berkualitas tinggi untuk bisnis Indonesia. '
                  'Dari konsep hingga deployment, kami siap mewujudkan visi digital Anda.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 16 : 18,
                  ),
                ),
                const SizedBox(height: 32),
                _buildHeroButtons(),
                const SizedBox(height: 40),
                _buildHeroStats(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroButtons() {
    return ResponsiveBuilder(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton.large(
            text: 'Mulai Konsultasi Gratis',
            onPressed: () => context.go('/contact'),
          ),
          const SizedBox(height: 16),
          CustomButton.secondary(
            text: 'Lihat Portfolio',
            onPressed: () => context.go('/portfolio'),
          ),
        ],
      ),
      desktop: Row(
        children: [
          CustomButton.large(
            text: 'Mulai Konsultasi Gratis',
            onPressed: () => context.go('/contact'),
          ),
          const SizedBox(width: 16),
          CustomButton.secondary(
            text: 'Lihat Portfolio',
            onPressed: () => context.go('/portfolio'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStats() {
    final stats = [
      ('50+', 'Project Selesai'),
      ('20+', 'Client Puas'),
      ('3+', 'Tahun Pengalaman'),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: stats.map((stat) => _buildStatItem(stat.$1, stat.$2)).toList(),
      ),
      desktop: Row(
        children: stats
            .map((stat) => Expanded(child: _buildStatItem(stat.$1, stat.$2)))
            .toList(),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: ScreenSize.isMobile(context) 
            ? CrossAxisAlignment.start 
            : CrossAxisAlignment.center,
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroVisual() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            height: ScreenSize.isMobile(context) ? 300 : 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.2),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Code Animation Background
                Positioned.fill(
                  child: _buildCodeAnimation(),
                ),
                // Device Mockups
                Center(
                  child: _buildDeviceMockups(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeAnimation() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCodeLine('class JostarApp extends StatelessWidget {', 0.1),
          _buildCodeLine('  @override', 0.2),
          _buildCodeLine('  Widget build(BuildContext context) {', 0.3),
          _buildCodeLine('    return MaterialApp(', 0.4),
          _buildCodeLine('      title: "Your Dream App",', 0.5),
          _buildCodeLine('      theme: ThemeData.light(),', 0.6),
          _buildCodeLine('      home: HomePage(),', 0.7),
          _buildCodeLine('    );', 0.8),
          _buildCodeLine('  }', 0.9),
          _buildCodeLine('}', 1.0),
        ],
      ),
    );
  }

  Widget _buildCodeLine(String code, double delay) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(delay, 1.0, curve: Curves.easeOut),
          ),
        );

        return FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDeviceMockups() {
    return Stack(
      children: [
        // Phone Mockup
        Positioned(
          right: 40,
          top: 50,
          child: Container(
            width: 60,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neutral.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.phone_android,
              color: AppColors.primary,
              size: 30,
            ),
          ),
        ),
        // Laptop Mockup
        Positioned(
          left: 20,
          bottom: 30,
          child: Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neutral.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.laptop_mac,
              color: AppColors.secondary,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}