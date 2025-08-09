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
  late AnimationController _mainController;
  late AnimationController _floatingController;
  late AnimationController _typingController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatingAnimation;

  String _displayText = '';
  final List<String> _typingTexts = [
    'Mobile App Development',
    'Website Development', 
    'Digital Solutions',
    'Flutter Expert',
  ];
  int _currentTextIndex = 0;
  int _currentCharIndex = 0;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startTypingAnimation();
  }

  void _setupAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _typingController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));

    _floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    _mainController.forward();
    _floatingController.repeat(reverse: true);
  }

  void _startTypingAnimation() {
    Future.delayed(const Duration(milliseconds: 2000), _typeText);
  }

  void _typeText() {
    if (!mounted) return;

    final currentText = _typingTexts[_currentTextIndex];
    
    if (!_isDeleting && _currentCharIndex < currentText.length) {
      setState(() {
        _displayText = currentText.substring(0, _currentCharIndex + 1);
        _currentCharIndex++;
      });
      Future.delayed(const Duration(milliseconds: 100), _typeText);
    } else if (!_isDeleting && _currentCharIndex == currentText.length) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          _isDeleting = true;
        });
        _typeText();
      });
    } else if (_isDeleting && _currentCharIndex > 0) {
      setState(() {
        _displayText = currentText.substring(0, _currentCharIndex - 1);
        _currentCharIndex--;
      });
      Future.delayed(const Duration(milliseconds: 50), _typeText);
    } else if (_isDeleting && _currentCharIndex == 0) {
      setState(() {
        _isDeleting = false;
        _currentTextIndex = (_currentTextIndex + 1) % _typingTexts.length;
      });
      Future.delayed(const Duration(milliseconds: 500), _typeText);
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatingController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenSize.isMobile(context) ? 700 : 800,
      child: Stack(
        children: [
          _buildBackgroundImage(),
          _buildGradientOverlay(),
          _buildContent(),
          _buildFloatingElements(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80'
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
                AppColors.primary.withOpacity(0.8),
                AppColors.secondary.withOpacity(0.6),
                AppColors.accent.withOpacity(0.7),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned.fill(
      child: Container(
        constraints: const BoxConstraints(minHeight: 600),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.getResponsivePadding(context),
          vertical: 80,
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: ScreenSize.getMaxContentWidth(context),
            ),
            child: ResponsiveBuilder(
              mobile: _buildMobileContent(),
              desktop: _buildDesktopContent(),
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
          child: _buildHeroText(),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 4,
          child: _buildHeroVisual(),
        ),
      ],
    );
  }

  Widget _buildMobileContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroText(),
        const SizedBox(height: 40),
        _buildHeroVisual(),
      ],
    );
  }

  Widget _buildHeroText() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: ScreenSize.isMobile(context)
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                // Animated Badge
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.textLight.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.textLight.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
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
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '🚀 Professional Flutter Developer',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Main Heading
                Text(
                  'Wujudkan Bisnis Digital Anda Bersama',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLight,
                    height: 1.1,
                  ),
                  textAlign: ScreenSize.isMobile(context) 
                      ? TextAlign.center 
                      : TextAlign.left,
                ),
                
                const SizedBox(height: 16),
                
                // Company Name with Gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      AppColors.accent,
                      Colors.white,
                      AppColors.secondary,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Jostar Programming',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: ScreenSize.isMobile(context) ? 36 : 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                    textAlign: ScreenSize.isMobile(context) 
                        ? TextAlign.center 
                        : TextAlign.left,
                  ),
                ),

                const SizedBox(height: 24),

                // Typing Animation
                Container(
                  height: 60,
                  alignment: ScreenSize.isMobile(context) 
                      ? Alignment.center 
                      : Alignment.centerLeft,
                  child: RichText(
                    textAlign: ScreenSize.isMobile(context) 
                        ? TextAlign.center 
                        : TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Specializing in ',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textLight.withOpacity(0.9),
                            fontSize: ScreenSize.isMobile(context) ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: _displayText,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenSize.isMobile(context) ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: '|',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.accent,
                            fontSize: ScreenSize.isMobile(context) ? 20 : 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Description
                Text(
                  'Kami mengembangkan aplikasi mobile dan website berkualitas tinggi '
                  'untuk bisnis Indonesia. Dari konsep hingga deployment, kami siap '
                  'mewujudkan visi digital Anda dengan teknologi terdepan.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 16 : 18,
                    color: AppColors.textLight.withOpacity(0.9),
                    height: 1.6,
                  ),
                  textAlign: ScreenSize.isMobile(context) 
                      ? TextAlign.center 
                      : TextAlign.left,
                ),

                const SizedBox(height: 40),

                // Action Buttons
                _buildActionButtons(),

                const SizedBox(height: 40),

                // Stats
                _buildStatsRow(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return ResponsiveBuilder(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () => context.go('/contact'),
              icon: const Icon(
                Icons.rocket_launch_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
              label: Text(
                'Mulai Konsultasi Gratis',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 56,
            child: OutlinedButton.icon(
              onPressed: () => context.go('/portfolio'),
              icon: const Icon(
                Icons.folder_open_rounded,
                color: AppColors.textLight,
                size: 20,
              ),
              label: Text(
                'Lihat Portfolio',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textLight,
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
        ],
      ),
      desktop: Row(
        mainAxisAlignment: ScreenSize.isMobile(context) 
            ? MainAxisAlignment.center 
            : MainAxisAlignment.start,
        children: [
          Container(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () => context.go('/contact'),
              icon: const Icon(
                Icons.rocket_launch_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
              label: Text(
                'Mulai Konsultasi Gratis',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textLight,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            height: 56,
            child: OutlinedButton.icon(
              onPressed: () => context.go('/portfolio'),
              icon: const Icon(
                Icons.folder_open_rounded,
                color: AppColors.textLight,
                size: 20,
              ),
              label: Text(
                'Lihat Portfolio',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textLight,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.textLight.withOpacity(0.8),
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      ('50+', 'Project Selesai'),
      ('20+', 'Client Puas'),
      ('3+', 'Tahun Pengalaman'),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: stats.asMap().entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildStatItem(entry.value.$1, entry.value.$2, entry.key),
          );
        }).toList(),
      ),
      desktop: Row(
        mainAxisAlignment: ScreenSize.isMobile(context) 
            ? MainAxisAlignment.center 
            : MainAxisAlignment.start,
        children: stats.asMap().entries.map((entry) {
          return Expanded(
            child: _buildStatItem(entry.value.$1, entry.value.$2, entry.key),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatItem(String number, String label, int index) {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _mainController,
              curve: Interval(0.6 + (index * 0.1), 1.0, curve: Curves.easeOut),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: ScreenSize.isMobile(context) 
                  ? CrossAxisAlignment.center 
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenSize.isMobile(context) ? 28 : 36,
                  ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textLight.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroVisual() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              height: ScreenSize.isMobile(context) ? 300 : 400,
              child: Stack(
                children: [
                  // Main Device Mockup
                  Center(
                    child: Container(
                      width: 200,
                      height: 320,
                      decoration: BoxDecoration(
                        color: AppColors.textLight,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          children: [
                            // Screen Content
                            Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primary,
                                    AppColors.secondary,
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.flutter_dash,
                                    size: 60,
                                    color: AppColors.textLight,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Flutter App',
                                    style: TextStyle(
                                      color: AppColors.textLight,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Notch
                            Positioned(
                              top: 0,
                              left: 60,
                              right: 60,
                              child: Container(
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.neutral,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Floating Code Blocks
                  _buildFloatingCodeBlock(
                    top: 40,
                    right: 20,
                    'Flutter',
                    AppColors.primary,
                    0.5,
                  ),
                  _buildFloatingCodeBlock(
                    bottom: 80,
                    left: 10,
                    'Firebase',
                    AppColors.accent,
                    0.8,
                  ),
                  _buildFloatingCodeBlock(
                    top: 160,
                    left: 0,
                    'Dart',
                    AppColors.secondary,
                    0.3,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingCodeBlock(
    String text,
    Color color,
    double delay, {
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: _mainController,
        builder: (context, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _mainController,
                curve: Interval(delay, 1.0, curve: Curves.easeOut),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingElements() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating Icons
            Positioned(
              top: 100 + _floatingAnimation.value * 0.5,
              left: 50,
              child: _buildFloatingIcon(Icons.code_rounded, AppColors.accent, 1.0),
            ),
            Positioned(
              top: 300 + _floatingAnimation.value * 0.8,
              right: 80,
              child: _buildFloatingIcon(Icons.smartphone_rounded, AppColors.success, 0.8),
            ),
            Positioned(
              bottom: 200 + _floatingAnimation.value * 0.6,
              left: 100,
              child: _buildFloatingIcon(Icons.web_rounded, AppColors.secondary, 0.6),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color, double opacity) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2 * opacity),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3 * opacity),
        ),
      ),
      child: Icon(
        icon,
        color: color.withOpacity(opacity),
        size: 20,
      ),
    );
  }
}