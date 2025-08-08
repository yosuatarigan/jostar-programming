import 'package:flutter/material.dart';
import '../widgets/home/portofolio_preview.dart';
import '../widgets/home/why_chosse_us.dart';
import '../widgets/home/testimonial.dart';
import '../widgets/home/cta_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _floatingButtonController;
  late AnimationController _backgroundController;
  late AnimationController _particleController;
  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _floatingButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );
    
    _scrollController.addListener(_onScroll);
    _backgroundController.repeat();
    _particleController.repeat();
  }

  void _onScroll() {
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
    _backgroundController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Epic animated background
          _buildEpicBackground(),
          
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const EpicHeroSection(),
                const SizedBox(height: 60),
                const EpicServicesOverview(),
                const SizedBox(height: 60),
                const PortfolioPreview(),
                const SizedBox(height: 60),
                const WhyChooseUs(),
                const SizedBox(height: 60),
                const Testimonials(),
                const SizedBox(height: 60),
                const CTASection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
          
          // Epic floating WhatsApp button
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
                child: const EpicFloatingWhatsAppButton(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEpicBackground() {
    return AnimatedBuilder(
      animation: Listenable.merge([_backgroundController, _particleController]),
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 2.0,
              colors: [
                const Color(0xFF1a1a2e).withOpacity(0.8),
                const Color(0xFF16213e).withOpacity(0.6),
                const Color(0xFF0f0f23).withOpacity(0.9),
                const Color(0xFF0A0A0F),
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Animated grid pattern
              _buildAnimatedGrid(),
              
              // Floating particles
              ..._buildParticleSystem(),
              
              // Scan lines effect
              _buildScanLines(),
              
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0A0A0F).withOpacity(0.3),
                      const Color(0xFF0A0A0F).withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.7, 1.0],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedGrid() {
    return CustomPaint(
      size: Size.infinite,
      painter: GridPainter(
        animation: _backgroundController.value,
        color: const Color(0xFF00ff88).withOpacity(0.1),
      ),
    );
  }

  List<Widget> _buildParticleSystem() {
    return List.generate(25, (index) {
      final random = (index * 7) % 10 / 10;
      final size = 2.0 + (index % 4);
      final speed = 0.5 + (index % 3) * 0.3;
      
      return Positioned(
        left: MediaQuery.of(context).size.width * random,
        top: (index * 50.0) % MediaQuery.of(context).size.height,
        child: Transform.translate(
          offset: Offset(
            50 * _particleController.value * speed * (index.isEven ? 1 : -1),
            20 * _particleController.value * speed,
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  [
                    const Color(0xFF00ff88),
                    const Color(0xFF00d4ff),
                    const Color(0xFFff006e),
                    const Color(0xFF8338ec),
                  ][index % 4],
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: [
                    const Color(0xFF00ff88),
                    const Color(0xFF00d4ff),
                    const Color(0xFFff006e),
                    const Color(0xFF8338ec),
                  ][index % 4].withOpacity(0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildScanLines() {
    return Positioned.fill(
      child: CustomPaint(
        painter: ScanLinesPainter(
          animation: _backgroundController.value,
        ),
      ),
    );
  }
}

// Epic Hero Section
class EpicHeroSection extends StatefulWidget {
  const EpicHeroSection({Key? key}) : super(key: key);

  @override
  State<EpicHeroSection> createState() => _EpicHeroSectionState();
}

class _EpicHeroSectionState extends State<EpicHeroSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _glowController;
  late AnimationController _rotationController;
  late List<Animation<double>> _staggeredAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _staggeredAnimations = [
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
        ),
      ),
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.2, 0.6, curve: Curves.elasticOut),
        ),
      ),
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.4, 0.8, curve: Curves.elasticOut),
        ),
      ),
    ];

    _animationController.forward();
    _glowController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _glowController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 700 : 800,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 60,
          vertical: 80,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: isMobile 
                ? _buildMobileLayout() 
                : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildEpicHeroContent(),
        ),
        const SizedBox(width: 100),
        Expanded(
          flex: 5,
          child: _buildEpicHeroVisual(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildEpicHeroContent(),
        const SizedBox(height: 60),
        _buildEpicHeroVisual(),
      ],
    );
  }

  Widget _buildEpicHeroContent() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: isMobile 
              ? CrossAxisAlignment.center 
              : CrossAxisAlignment.start,
          children: [
            // Epic animated badge
            FadeTransition(
              opacity: _staggeredAnimations[0],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[0]),
                child: AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24, 
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00ff88).withOpacity(0.2),
                            const Color(0xFF00d4ff).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFF00ff88).withOpacity(0.6),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00ff88).withOpacity(
                              0.3 + 0.2 * _glowController.value,
                            ),
                            blurRadius: 20 + 10 * _glowController.value,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00ff88),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00ff88),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                const Color(0xFF00ff88),
                                const Color(0xFF00d4ff),
                              ],
                            ).createShader(bounds),
                            child: Text(
                              '⚡ FLUTTER DEVELOPER ELITE',
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Epic main headline
            FadeTransition(
              opacity: _staggeredAnimations[1],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[1]),
                child: Column(
                  crossAxisAlignment: isMobile 
                      ? CrossAxisAlignment.center 
                      : CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.white,
                          const Color(0xFF00d4ff),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'REVOLUSI',
                        style: TextStyle(
                          fontSize: isMobile ? 48 : 72,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _glowController,
                      builder: (context, child) {
                        return ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              const Color(0xFF00ff88),
                              const Color(0xFFff006e),
                              const Color(0xFF8338ec),
                            ],
                          ).createShader(bounds),
                          child: Text(
                            'DIGITAL',
                            style: TextStyle(
                              fontSize: isMobile ? 48 : 72,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                              color: Colors.white,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color: const Color(0xFF00ff88).withOpacity(
                                    0.5 + 0.3 * _glowController.value,
                                  ),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            textAlign: isMobile ? TextAlign.center : TextAlign.left,
                          ),
                        );
                      },
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          const Color(0xFF8338ec),
                          Colors.white,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'DIMULAI SEKARANG',
                        style: TextStyle(
                          fontSize: isMobile ? 48 : 72,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Epic description
            FadeTransition(
              opacity: _staggeredAnimations[2],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[2]),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : 550,
                  ),
                  child: Text(
                    'Kami menciptakan pengalaman digital yang menakjubkan dengan teknologi Flutter terdepan. Aplikasi mobile dan website yang tidak hanya fungsional, tapi juga memukau secara visual.',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 20,
                      height: 1.8,
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Epic action buttons
            FadeTransition(
              opacity: _staggeredAnimations[2],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(_staggeredAnimations[2]),
                child: _buildEpicActionButtons(isMobile),
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Epic stats
            FadeTransition(
              opacity: _staggeredAnimations[2],
              child: _buildEpicStats(isMobile),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEpicActionButtons(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEpicPrimaryButton(),
          const SizedBox(height: 20),
          _buildEpicSecondaryButton(),
        ],
      );
    }
    
    return Row(
      children: [
        _buildEpicPrimaryButton(),
        const SizedBox(width: 24),
        _buildEpicSecondaryButton(),
      ],
    );
  }

  Widget _buildEpicPrimaryButton() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00ff88),
                const Color(0xFF00d4ff),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00ff88).withOpacity(
                  0.4 + 0.3 * _glowController.value,
                ),
                blurRadius: 25 + 15 * _glowController.value,
                offset: const Offset(0, 10),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {}, // Navigate to contact
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.rocket_launch,
                      color: Color(0xFF0A0A0F),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'MULAI REVOLUSI',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0A0A0F),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEpicSecondaryButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF8338ec),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8338ec).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {}, // Navigate to portfolio
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_circle_outline,
                  color: const Color(0xFF8338ec),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'LIHAT KARYA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF8338ec),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEpicStats(bool isMobile) {
    final stats = [
      {'number': '50+', 'label': 'PROJECT EPIC', 'icon': Icons.rocket_launch},
      {'number': '100%', 'label': 'CLIENT BAHAGIA', 'icon': Icons.favorite},
      {'number': '24/7', 'label': 'SUPPORT ELITE', 'icon': Icons.support_agent},
    ];

    if (isMobile) {
      return Column(
        children: stats.map((stat) => Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: _buildEpicStatCard(stat),
        )).toList(),
      );
    }

    return Row(
      children: stats.map((stat) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildEpicStatCard(stat),
        ),
      )).toList(),
    );
  }

  Widget _buildEpicStatCard(Map<String, dynamic> stat) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00ff88).withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00ff88).withOpacity(
                  0.1 + 0.1 * _glowController.value,
                ),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00ff88).withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  stat['icon'],
                  color: const Color(0xFF00ff88),
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFF00ff88),
                    const Color(0xFF00d4ff),
                  ],
                ).createShader(bounds),
                child: Text(
                  stat['number'],
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stat['label'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEpicHeroVisual() {
    return AnimatedBuilder(
      animation: Listenable.merge([_glowController, _rotationController]),
      builder: (context, child) {
        return Container(
          height: 500,
          child: Stack(
            children: [
              // Main holographic container
              Center(
                // child: Transform.rotateY(_rotationController.value * 0.1),
                child: Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF00ff88).withOpacity(0.1),
                        const Color(0xFF00d4ff).withOpacity(0.2),
                        const Color(0xFF8338ec).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFF00ff88).withOpacity(0.6),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00ff88).withOpacity(
                          0.3 + 0.2 * _glowController.value,
                        ),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Holographic grid
                      CustomPaint(
                        size: Size.infinite,
                        painter: HolographicGridPainter(
                          animation: _rotationController.value,
                        ),
                      ),
                      
                      // Central device
                      Center(
                        child: Transform.scale(
                          scale: 1.0 + 0.05 * _glowController.value,
                          child: Container(
                            width: 180,
                            height: 320,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black,
                                  const Color(0xFF1a1a2e),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF00ff88),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00ff88).withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(27),
                              child: Stack(
                                children: [
                                  // Screen content
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          const Color(0xFF00ff88),
                                          const Color(0xFF00d4ff),
                                          const Color(0xFF8338ec),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  
                                  // App interface elements
                                  Positioned(
                                    top: 40,
                                    left: 30,
                                    right: 30,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 6,
                                          margin: const EdgeInsets.symmetric(horizontal: 50),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        ...List.generate(5, (index) => Container(
                                          height: 24,
                                          margin: const EdgeInsets.only(bottom: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(6),
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
                      ),
                    ],
                  ),
                ),
              ),
              
              // Floating tech icons
              ..._buildFloatingTechIcons(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildFloatingTechIcons() {
    final icons = [
      {'icon': Icons.flutter_dash, 'color': const Color(0xFF00ff88), 'position': const Offset(50, 100)},
      {'icon': Icons.web, 'color': const Color(0xFF00d4ff), 'position': const Offset(320, 150)},
      {'icon': Icons.phone_android, 'color': const Color(0xFFff006e), 'position': const Offset(80, 350)},
      {'icon': Icons.code, 'color': const Color(0xFF8338ec), 'position': const Offset(300, 380)},
      {'icon': Icons.api, 'color': const Color(0xFF00ff88), 'position': const Offset(40, 250)},
    ];

    return icons.map((iconData) {
      return Positioned(
        left: (iconData['position'] as Offset?)?.dx ?? 0.0,
        top: (iconData['position'] as Offset?)?.dy ?? 0.0,
        child: Transform.translate(
          offset: Offset(
            10 * _glowController.value,
            5 * _glowController.value,
          ),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  (iconData['color'] as Color).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: iconData['color'] as Color,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: (iconData['color'] as Color).withOpacity(0.6),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              iconData['icon'] as IconData,
              color: iconData['color'] as Color,
              size: 28,
            ),
          ),
        ),
      );
    }).toList();
  }
}

// Epic Services Overview
class EpicServicesOverview extends StatefulWidget {
  const EpicServicesOverview({Key? key}) : super(key: key);

  @override
  State<EpicServicesOverview> createState() => _EpicServicesOverviewState();
}

class _EpicServicesOverviewState extends State<EpicServicesOverview>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _glowController;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _cardAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.3,
            0.7 + (index * 0.1),
            curve: Curves.elasticOut,
          ),
        ),
      );
    });

    _animationController.forward();
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 100,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              _buildEpicSectionHeader(),
              const SizedBox(height: 80),
              _buildEpicServicesGrid(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEpicSectionHeader() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8338ec).withOpacity(0.2),
                    const Color(0xFFff006e).withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color(0xFF8338ec).withOpacity(0.6),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8338ec).withOpacity(
                      0.3 + 0.2 * _glowController.value,
                    ),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFF8338ec),
                    const Color(0xFFff006e),
                  ],
                ).createShader(bounds),
                child: Text(
                  '⚡ LAYANAN ELITE',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.white,
                  const Color(0xFF00d4ff),
                  const Color(0xFF8338ec),
                ],
              ).createShader(bounds),
              child: Text(
                'TEKNOLOGI MASA DEPAN',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 768 ? 32 : 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: const Color(0xFF00d4ff).withOpacity(
                        0.5 + 0.3 * _glowController.value,
                      ),
                      blurRadius: 20,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Text(
                'Pengalaman digital yang revolusioner dengan teknologi terdepan. Kami menciptakan aplikasi yang tidak hanya berfungsi, tetapi mengubah cara bisnis Anda berinteraksi dengan dunia.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.7,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEpicServicesGrid(bool isMobile) {
    final services = [
      EpicService(
        icon: Icons.phone_android,
        title: 'MOBILE REVOLUTION',
        description: 'Aplikasi mobile yang menghadirkan pengalaman pengguna luar biasa dengan teknologi Flutter terdepan',
        features: ['Neural Performance', 'Quantum UI/UX', 'Holographic Design'],
        primaryColor: const Color(0xFF00ff88),
        secondaryColor: const Color(0xFF00d4ff),
      ),
      EpicService(
        icon: Icons.web,
        title: 'WEB DOMINATION',
        description: 'Website futuristik yang memukau dengan kecepatan lightning dan design yang menghipnotis',
        features: ['Cyber Speed', 'Matrix Integration', 'Neural Networks'],
        primaryColor: const Color(0xFF00d4ff),
        secondaryColor: const Color(0xFF8338ec),
      ),
      EpicService(
        icon: Icons.rocket_launch,
        title: 'INSTANT DEPLOY',
        description: 'Solusi instant deployment dengan kustomisasi penuh untuk dominasi pasar digital',
        features: ['Zero Latency', 'Infinite Scale', 'Quantum Ready'],
        primaryColor: const Color(0xFF8338ec),
        secondaryColor: const Color(0xFFff006e),
      ),
    ];

    if (isMobile) {
      return Column(
        children: services.asMap().entries.map((entry) {
          return AnimatedBuilder(
            animation: _cardAnimations[entry.key],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 100 * (1 - _cardAnimations[entry.key].value)),
                child: Opacity(
                  opacity: _cardAnimations[entry.key].value,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: _buildEpicServiceCard(entry.value),
                  ),
                ),
              );
            },
          );
        }).toList(),
      );
    }

    return Row(
      children: services.asMap().entries.map((entry) {
        return Expanded(
          child: AnimatedBuilder(
            animation: _cardAnimations[entry.key],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 100 * (1 - _cardAnimations[entry.key].value)),
                child: Opacity(
                  opacity: _cardAnimations[entry.key].value,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildEpicServiceCard(entry.value),
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEpicServiceCard(EpicService service) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  service.primaryColor.withOpacity(0.1),
                  service.secondaryColor.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: service.primaryColor.withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: service.primaryColor.withOpacity(
                    0.2 + 0.1 * _glowController.value,
                  ),
                  blurRadius: 25,
                  offset: const Offset(0, 15),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Epic icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        service.primaryColor.withOpacity(0.3),
                        service.secondaryColor.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: service.primaryColor,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: service.primaryColor.withOpacity(0.6),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    service.icon,
                    size: 40,
                    color: service.primaryColor,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Epic title
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      service.primaryColor,
                      service.secondaryColor,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    service.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Description
                Text(
                  service.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Features
                ...service.features.map((feature) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [service.primaryColor, service.secondaryColor],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: service.primaryColor.withOpacity(0.6),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                
                const SizedBox(height: 30),
                
                // CTA Button
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        service.primaryColor.withOpacity(0.2),
                        service.secondaryColor.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: service.primaryColor.withOpacity(0.6),
                      width: 2,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'EXPLORE NOW',
                              style: TextStyle(
                                fontSize: 14,
                                color: service.primaryColor,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: service.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Epic floating WhatsApp button (placeholder)
class EpicFloatingWhatsAppButton extends StatelessWidget {
  const EpicFloatingWhatsAppButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00ff88),
            const Color(0xFF00d4ff),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00ff88).withOpacity(0.6),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Icons.chat,
        color: const Color(0xFF0A0A0F),
        size: 32,
      ),
    );
  }
}

// Data Models
class EpicService {
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;
  final Color primaryColor;
  final Color secondaryColor;

  EpicService({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

// Custom Painters
class GridPainter extends CustomPainter {
  final double animation;
  final Color color;

  GridPainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final spacing = 50.0;
    final offsetX = (animation * spacing) % spacing;
    final offsetY = (animation * spacing) % spacing;

    // Draw vertical lines
    for (double x = offsetX; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double y = offsetY; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ScanLinesPainter extends CustomPainter {
  final double animation;

  ScanLinesPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00ff88).withOpacity(0.1)
      ..strokeWidth = 2;

    final y = (animation * size.height * 2) % size.height;
    
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HolographicGridPainter extends CustomPainter {
  final double animation;

  HolographicGridPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00ff88).withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final spacing = 20.0;
    final offset = animation * spacing;

    // Draw animated grid
    for (double x = -offset; x < size.width + spacing; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    for (double y = -offset; y < size.height + spacing; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Extension for 3D transforms
extension Transform3D on Transform {
  static Widget rotateY(double angle, {required Widget child}) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle),
      child: child,
    );
  }
}