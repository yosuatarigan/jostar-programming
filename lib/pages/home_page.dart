import 'package:flutter/material.dart';
import 'package:jostar_programming/widgets/common/floating_action_button.dart';
import '../widgets/home/service_overview.dart';
import '../widgets/home/portofolio_preview.dart';
import '../widgets/home/why_chosse_us.dart';
import '../widgets/home/testimonial.dart';
import '../widgets/home/cta_section.dart';
import '../core/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _floatingButtonController;
  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _floatingButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Show floating button after scrolling past hero section
    if (_scrollController.offset > 200 && !_showFloatingButton) {
      setState(() => _showFloatingButton = true);
      _floatingButtonController.forward();
    } else if (_scrollController.offset <= 200 && _showFloatingButton) {
      setState(() => _showFloatingButton = false);
      _floatingButtonController.reverse();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _floatingButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.02),
                  AppColors.secondary.withOpacity(0.05),
                  AppColors.accent.withOpacity(0.03),
                  Colors.white,
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),
          
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const HeroSection(),
                const SizedBox(height: 40),
                const ServicesOverview(),
                const SizedBox(height: 40),
                const PortfolioPreview(),
                const SizedBox(height: 40),
                const WhyChooseUs(),
                const SizedBox(height: 40),
                const Testimonials(),
                const SizedBox(height: 40),
                const CTASection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          
          // Floating WhatsApp Button
          if (_showFloatingButton)
            Positioned(
              right: 20,
              bottom: 20,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.2, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _floatingButtonController,
                  curve: Curves.elasticOut,
                )),
                child: const FloatingWhatsAppButton(),
              ),
            ),
        ],
      ),
    );
  }
}

// Modern Hero Section with epic design
class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingController;
  late List<Animation<double>> _staggeredAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Staggered animations for different elements
    _staggeredAnimations = [
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
        ),
      ),
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
        ),
      ),
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
        ),
      ),
    ];

    _animationController.forward();
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 600 : 700,
      ),
      child: Stack(
        children: [
          // Animated background particles
          ...List.generate(6, (index) => _buildFloatingParticle(index)),
          
          // Main content
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 60,
              vertical: 60,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isMobile 
                    ? _buildMobileLayout() 
                    : _buildDesktopLayout(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildHeroContent(),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 5,
          child: _buildHeroVisual(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildHeroContent(),
        const SizedBox(height: 50),
        _buildHeroVisual(),
      ],
    );
  }

  Widget _buildHeroContent() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: isMobile 
              ? CrossAxisAlignment.center 
              : CrossAxisAlignment.start,
          children: [
            // Animated badge
            FadeTransition(
              opacity: _staggeredAnimations[0],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[0]),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20, 
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withOpacity(0.2),
                        AppColors.primary.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.accent.withOpacity(0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '🚀 Flutter Developer Professional',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Main headline with enhanced typography
            FadeTransition(
              opacity: _staggeredAnimations[1],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[1]),
                child: Column(
                  crossAxisAlignment: isMobile 
                      ? CrossAxisAlignment.center 
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wujudkan',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 40 : 64,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                          AppColors.accent,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'Aplikasi Impian',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 40 : 64,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          color: Colors.white,
                        ),
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                    ),
                    Text(
                      'Anda Bersama Kami',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 40 : 64,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 25),
            
            // Description with better spacing
            FadeTransition(
              opacity: _staggeredAnimations[2],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[2]),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : 500,
                  ),
                  child: Text(
                    'Transformasi digital dimulai dari sini. Kami mengembangkan aplikasi mobile dan website premium yang menghadirkan pengalaman luar biasa untuk pengguna Anda.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.7,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.3,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Enhanced action buttons
            FadeTransition(
              opacity: _staggeredAnimations[2],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[2]),
                child: _buildActionButtons(isMobile),
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Enhanced stats
            FadeTransition(
              opacity: _staggeredAnimations[2],
              child: _buildEnhancedStats(isMobile),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButtons(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPrimaryButton(),
          const SizedBox(height: 16),
          _buildSecondaryButton(),
        ],
      );
    }
    
    return Row(
      children: [
        _buildPrimaryButton(),
        const SizedBox(width: 20),
        _buildSecondaryButton(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {}, // Navigate to contact
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 18,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.rocket_launch,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Mulai Project Sekarang',
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

  Widget _buildSecondaryButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {}, // Navigate to portfolio
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 18,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_circle_outline,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Lihat Portfolio',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
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

  Widget _buildEnhancedStats(bool isMobile) {
    final stats = [
      {'number': '50+', 'label': 'Project Sukses', 'icon': Icons.check_circle},
      {'number': '20+', 'label': 'Client Bahagia', 'icon': Icons.favorite},
      {'number': '3+', 'label': 'Tahun Experti', 'icon': Icons.star},
    ];

    if (isMobile) {
      return Column(
        children: stats.map((stat) => Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: _buildStatCard(stat),
        )).toList(),
      );
    }

    return Row(
      children: stats.map((stat) => Expanded(
        child: _buildStatCard(stat),
      )).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              stat['icon'],
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            stat['number'],
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['label'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroVisual() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 10 * _floatingController.value),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.2),
                  AppColors.accent.withOpacity(0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Glassmorphism effect
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                
                // Central device mockup
                Center(
                  child: Container(
                    width: 160,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(
                        children: [
                          // Screen gradient
                          Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primary,
                                  AppColors.secondary,
                                  AppColors.accent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          
                          // App elements
                          Positioned(
                            top: 30,
                            left: 20,
                            right: 20,
                            child: Column(
                              children: [
                                Container(
                                  height: 4,
                                  margin: const EdgeInsets.symmetric(horizontal: 40),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ...List.generate(4, (index) => Container(
                                  height: 20,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Floating elements
                _buildFloatingIcon(
                  Icons.flutter_dash,
                  const Offset(50, 80),
                  AppColors.primary,
                ),
                _buildFloatingIcon(
                  Icons.web,
                  const Offset(300, 120),
                  AppColors.secondary,
                ),
                _buildFloatingIcon(
                  Icons.phone_android,
                  const Offset(80, 280),
                  AppColors.accent,
                ),
                _buildFloatingIcon(
                  Icons.code,
                  const Offset(280, 300),
                  AppColors.success,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingIcon(IconData icon, Offset position, Color color) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: AnimatedBuilder(
        animation: _floatingController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              5 * _floatingController.value,
              3 * _floatingController.value,
            ),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    final random = [0.3, 0.7, 0.2, 0.8, 0.5, 0.9][index];
    final size = [6.0, 8.0, 4.0, 10.0, 5.0, 7.0][index];
    
    return Positioned(
      left: MediaQuery.of(context).size.width * random,
      top: 100 + (index * 80.0),
      child: AnimatedBuilder(
        animation: _floatingController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              20 * _floatingController.value * (index.isEven ? 1 : -1),
              10 * _floatingController.value,
            ),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: [
                  AppColors.primary,
                  AppColors.secondary,
                  AppColors.accent,
                  AppColors.success,
                ][index % 4].withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }
}