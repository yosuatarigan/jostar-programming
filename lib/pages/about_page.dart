import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';
import '../widgets/layout/footer_section.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _heroAnimationController;
  late AnimationController _skillsAnimationController;
  late Animation<double> _heroFadeAnimation;
  late Animation<Offset> _heroSlideAnimation;

  @override
  void initState() {
    super.initState();
    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _skillsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _heroFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _heroAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _heroSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _heroAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _heroAnimationController.forward();
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _skillsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildStatsSection(context),
          _buildSkillsSection(context),
          _buildJourneySection(context),
          _buildValuesSection(context),
          _buildTestimonialSection(context),
          _buildCTASection(context),
          const FooterSection(),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: ScreenSize.isMobile(context) ? 800 : 900,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.primary.withOpacity(0.95),
            AppColors.secondary.withOpacity(0.85),
            AppColors.accent.withOpacity(0.75),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=1200&q=80',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
            ),
          ),
          
          // Animated Floating Elements
          _buildFloatingElements(context),
          
          // Hero Content
          Positioned.fill(
            child: Container(
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
                    animation: _heroAnimationController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _heroFadeAnimation,
                        child: SlideTransition(
                          position: _heroSlideAnimation,
                          child: ResponsiveBuilder(
                            mobile: _buildMobileHeroContent(context),
                            desktop: _buildDesktopHeroContent(context),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElements(BuildContext context) {
    return Stack(
      children: [
        // Floating Circle 1
        Positioned(
          top: 100,
          right: 50,
          child: _buildFloatingCircle(
            size: 120,
            color: AppColors.accent.withOpacity(0.1),
            duration: 4000,
          ),
        ),
        // Floating Circle 2
        Positioned(
          bottom: 150,
          left: 30,
          child: _buildFloatingCircle(
            size: 80,
            color: AppColors.secondary.withOpacity(0.15),
            duration: 6000,
          ),
        ),
        // Floating Circle 3
        Positioned(
          top: 300,
          left: 100,
          child: _buildFloatingCircle(
            size: 60,
            color: Colors.white.withOpacity(0.1),
            duration: 8000,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingCircle({
    required double size,
    required Color color,
    required int duration,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: duration),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -20 * value),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopHeroContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _buildHeroText(context),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 2,
          child: _buildHeroImage(context),
        ),
      ],
    );
  }

  Widget _buildMobileHeroContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroImage(context),
        const SizedBox(height: 40),
        _buildHeroText(context),
      ],
    );
  }

  Widget _buildHeroText(BuildContext context) {
    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.flutter_dash,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'FLUTTER DEVELOPER',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Main Title
        Text(
          'Hi, Saya Yosua Tarigan',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: ScreenSize.isMobile(context) ? 36 : 56,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
          textAlign: ScreenSize.isMobile(context)
              ? TextAlign.center
              : TextAlign.left,
        ),
        const SizedBox(height: 16),
        
        // Subtitle with gradient
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.accent, Colors.white],
          ).createShader(bounds),
          child: Text(
            'Founder & Lead Developer',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: ScreenSize.isMobile(context) ? 20 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: ScreenSize.isMobile(context)
                ? TextAlign.center
                : TextAlign.left,
          ),
        ),
        const SizedBox(height: 24),
        
        // Description
        Text(
          'Mengembangkan aplikasi mobile & website yang mengubah cara bisnis berinteraksi dengan pelanggan. Spesialisasi dalam Flutter, Firebase, dan solusi digital yang inovatif.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white.withOpacity(0.9),
            height: 1.6,
            fontSize: 18,
          ),
          textAlign: ScreenSize.isMobile(context)
              ? TextAlign.center
              : TextAlign.left,
        ),
        const SizedBox(height: 40),
        
        // CTA Buttons
        Row(
          mainAxisAlignment: ScreenSize.isMobile(context)
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Mari Berkolaborasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.rocket_launch, size: 18),
                ],
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => context.go('/portfolio'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lihat Portfolio',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Stack(
      children: [
        // Glassmorphism Container
        Container(
          width: ScreenSize.isMobile(context) ? 280 : 400,
          height: ScreenSize.isMobile(context) ? 280 : 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white.withOpacity(0.7),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Floating Badge
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              Icons.verified,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final stats = [
      {'number': '50+', 'label': 'Project Selesai'},
      {'number': '25+', 'label': 'Klien Puas'},
      {'number': '3+', 'label': 'Tahun Experience'},
      {'number': '15+', 'label': 'Teknologi Dikuasai'},
    ];

    return Container(
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
          child: ResponsiveBuilder(
            mobile: _buildMobileStats(context, stats),
            desktop: _buildDesktopStats(context, stats),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopStats(BuildContext context, List<Map<String, String>> stats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stats.map((stat) => _buildStatCard(context, stat)).toList(),
    );
  }

  Widget _buildMobileStats(BuildContext context, List<Map<String, String>> stats) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) => _buildStatCard(context, stats[index]),
    );
  }

  Widget _buildStatCard(BuildContext context, Map<String, String> stat) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 800 + (100 * int.parse(stat['number']!.replaceAll(RegExp(r'[^0-9]'), '')))),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stat['number']!,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    stat['label']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final skills = [
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Development',
        'subtitle': 'Flutter, React Native',
        'description': 'Mengembangkan aplikasi mobile cross-platform dengan performa native',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.web,
        'title': 'Web Development',
        'subtitle': 'Flutter Web, React, Vue',
        'description': 'Membangun website responsif dan progressive web apps',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.cloud,
        'title': 'Backend & Cloud',
        'subtitle': 'Firebase, Node.js, AWS',
        'description': 'Mengintegrasikan aplikasi dengan layanan cloud dan database',
        'color': AppColors.accent,
      },
    ];

    return Container(
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
              Text(
                'Keahlian & Spesialisasi',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Teknologi terdepan untuk solusi digital yang powerful',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              ResponsiveBuilder(
                mobile: _buildMobileSkills(context, skills),
                desktop: _buildDesktopSkills(context, skills),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopSkills(BuildContext context, List<Map<String, dynamic>> skills) {
    return Row(
      children: skills.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> skill = entry.value;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index < skills.length - 1 ? 24 : 0,
            ),
            child: _buildSkillCard(context, skill, index),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileSkills(BuildContext context, List<Map<String, dynamic>> skills) {
    return Column(
      children: skills.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> skill = entry.value;
        return Container(
          margin: EdgeInsets.only(
            bottom: index < skills.length - 1 ? 24 : 0,
          ),
          child: _buildSkillCard(context, skill, index),
        );
      }).toList(),
    );
  }

  Widget _buildSkillCard(BuildContext context, Map<String, dynamic> skill, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    skill['color'].withOpacity(0.05),
                    skill['color'].withOpacity(0.02),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: skill['color'].withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: skill['color'],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: skill['color'].withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      skill['icon'],
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    skill['title'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    skill['subtitle'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: skill['color'],
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    skill['description'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildJourneySection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
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
                'Perjalanan Profesional',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildTimeline(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final journeySteps = [
      {
        'year': '2021',
        'title': 'Memulai Journey Flutter',
        'description': 'Belajar Flutter secara autodidak dan membangun project pertama',
        'color': AppColors.accent,
      },
      {
        'year': '2022',
        'title': 'Freelance Mobile Developer',
        'description': 'Mengerjakan berbagai project freelance dan membangun portofolio',
        'color': AppColors.secondary,
      },
      {
        'year': '2023',
        'title': 'Founding Jostar Programming',
        'description': 'Mendirikan perusahaan dan fokus pada solusi digital untuk UMKM',
        'color': AppColors.primary,
      },
      {
        'year': '2024',
        'title': 'Ekspansi & Inovasi',
        'description': 'Mengembangkan ready-to-use apps dan melayani 25+ klien',
        'color': AppColors.success,
      },
    ];

    return Column(
      children: journeySteps.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> step = entry.value;
        return _buildTimelineItem(context, step, index, journeySteps.length);
      }).toList(),
    );
  }

  Widget _buildTimelineItem(BuildContext context, Map<String, dynamic> step, int index, int total) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 800 + (index * 300)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(-50 * (1 - value), 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline Visual
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: step['color'],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: step['color'].withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          step['year'],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (index < total - 1)
                      Container(
                        width: 3,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              step['color'].withOpacity(0.5),
                              step['color'].withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(width: 24),
                
                // Content
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neutral.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['title'],
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: step['color'],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          step['description'],
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
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

  Widget _buildValuesSection(BuildContext context) {
    final values = [
      {
        'icon': Icons.lightbulb_outline,
        'title': 'Inovasi',
        'description': 'Selalu mencari solusi terbaru dan teknologi terdepan',
        'color': AppColors.accent,
      },
      {
        'icon': Icons.handshake_outlined,
        'title': 'Kolaborasi',
        'description': 'Bekerja sama untuk mencapai tujuan bersama',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.speed,
        'title': 'Efisiensi',
        'description': 'Mengoptimalkan proses untuk hasil maksimal',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.verified_user,
        'title': 'Kualitas',
        'description': 'Komitmen pada standar tinggi di setiap project',
        'color': AppColors.success,
      },
    ];

    return Container(
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
              Text(
                'Nilai-Nilai Kami',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              ResponsiveBuilder(
                mobile: _buildMobileValues(context, values),
                desktop: _buildDesktopValues(context, values),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopValues(BuildContext context, List<Map<String, dynamic>> values) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
        childAspectRatio: 1.4,
      ),
      itemCount: values.length,
      itemBuilder: (context, index) => _buildValueCard(context, values[index], index),
    );
  }

  Widget _buildMobileValues(BuildContext context, List<Map<String, dynamic>> values) {
    return Column(
      children: values.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> value = entry.value;
        return Container(
          margin: EdgeInsets.only(
            bottom: index < values.length - 1 ? 24 : 0,
          ),
          child: _buildValueCard(context, value, index),
        );
      }).toList(),
    );
  }

  Widget _buildValueCard(BuildContext context, Map<String, dynamic> value, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + (index * 150)),
      builder: (context, animationValue, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * animationValue),
          child: Opacity(
            opacity: animationValue,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    value['color'].withOpacity(0.05),
                    value['color'].withOpacity(0.02),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: value['color'].withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: value['color'],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      value['icon'],
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    value['title'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    value['description'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestimonialSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.secondary.withOpacity(0.02),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 800,
          ),
          child: Column(
            children: [
              Icon(
                Icons.format_quote,
                size: 60,
                color: AppColors.primary.withOpacity(0.3),
              ),
              const SizedBox(height: 32),
              Text(
                '"Flutter memungkinkan saya mengembangkan aplikasi berkualitas tinggi untuk iOS dan Android dengan satu codebase. Hot reload yang cepat, performance yang excellent, dan ecosystem yang kuat membuat development menjadi lebih efisien dan menyenangkan."',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=60&q=80',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primary.withOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yosua Tarigan',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Founder & Lead Developer',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
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
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 800,
          ),
          child: Column(
            children: [
              Text(
                '🚀 Mari Berkolaborasi!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Siap mengubah ide Anda menjadi aplikasi yang mengagumkan? Mari diskusikan project impian Anda!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ResponsiveBuilder(
                mobile: _buildMobileCTAButtons(context),
                desktop: _buildDesktopCTAButtons(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopCTAButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => context.go('/contact'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Mulai Project',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.rocket_launch, size: 20),
            ],
          ),
        ),
        const SizedBox(width: 24),
        OutlinedButton(
          onPressed: () => context.go('/portfolio'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.white, width: 2),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lihat Portfolio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCTAButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go('/contact'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mulai Project',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.rocket_launch, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => context.go('/portfolio'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lihat Portfolio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}