import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../common/responsive_builder.dart';
import 'dart:math' show cos, sin;

class WhyChooseUs extends StatefulWidget {
  const WhyChooseUs({Key? key}) : super(key: key);

  @override
  State<WhyChooseUs> createState() => _WhyChooseUsState();
}

class _WhyChooseUsState extends State<WhyChooseUs>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _counterController;
  late List<Animation<double>> _advantageAnimations;
  late List<Animation<double>> _statAnimations;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _counterController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _advantageAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.2 + (index * 0.1),
            0.6 + (index * 0.1),
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _statAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.4 + (index * 0.1),
            0.8 + (index * 0.1),
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _animationController.forward();
        _counterController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _counterController.dispose();
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
            AppColors.background,
            AppColors.primary.withOpacity(0.02),
            AppColors.background,
          ],
        ),
      ),
      child: Stack(
        children: [
          _buildBackgroundPattern(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.primary.withOpacity(0.02),
              AppColors.secondary.withOpacity(0.03),
              AppColors.background,
            ],
          ),
        ),
        child: CustomPaint(
          painter: GeometricPatternPainter(),
          child: Container(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: ResponsiveBuilder(
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _buildMainContent(context),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 4,
          child: _buildStatsGrid(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildMainContent(context),
        const SizedBox(height: 60),
        _buildStatsGrid(context),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _headerAnimation.value,
          child: Transform.translate(
            offset: Offset(-50 * (1 - _headerAnimation.value), 0),
            child: Column(
              crossAxisAlignment: ScreenSize.isMobile(context)
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.accent.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.emoji_events_rounded,
                        size: 16,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'MENGAPA PILIH KAMI',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Main Title
                Text(
                  'Partner Terpercaya untuk',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 32 : 44,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLight,
                  ),
                  textAlign: ScreenSize.isMobile(context)
                      ? TextAlign.center
                      : TextAlign.left,
                ),

                const SizedBox(height: 8),

                // Gradient Title
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                      AppColors.accent,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Transformasi Digital Anda',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: ScreenSize.isMobile(context) ? 32 : 44,
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
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    'Dengan pengalaman 3+ tahun dan 50+ project sukses, kami memahami '
                    'kebutuhan bisnis Indonesia dan berkomitmen memberikan solusi digital '
                    'terbaik dengan teknologi terdepan.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: AppColors.textLight,
                      fontSize: 18,
                    ),
                    textAlign: ScreenSize.isMobile(context)
                        ? TextAlign.center
                        : TextAlign.left,
                  ),
                ),

                const SizedBox(height: 40),

                // Main Advantages
                _buildMainAdvantages(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainAdvantages(BuildContext context) {
    final advantages = [
      MainAdvantage(
        icon: Icons.flash_on_rounded,
        title: 'Development Lightning Fast',
        description: 'Proses pengembangan yang efisien dengan metodologi Agile modern dan tools terdepan',
        color: AppColors.primary,
        gradient: [AppColors.primary, AppColors.secondary],
      ),
      MainAdvantage(
        icon: Icons.support_agent_rounded,
        title: 'Support Premium 24/7',
        description: 'Tim support yang siap membantu kapan saja dengan response time terbaik di kelasnya',
        color: AppColors.success,
        gradient: [AppColors.success, AppColors.primary],
      ),
      MainAdvantage(
        icon: Icons.trending_up_rounded,
        title: 'Scalable & Future-Ready',
        description: 'Solusi yang dapat berkembang mengikuti pertumbuhan bisnis dengan arsitektur modern',
        color: AppColors.accent,
        gradient: [AppColors.accent, AppColors.secondary],
      ),
    ];

    return Column(
      children: advantages.asMap().entries.map((entry) {
        final advantage = entry.value;
        final index = entry.key;

        return AnimatedBuilder(
          animation: _advantageAnimations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                -30 * (1 - _advantageAnimations[index].value),
                0,
              ),
              child: Opacity(
                opacity: _advantageAnimations[index].value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: advantage.color.withOpacity(0.1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: advantage.color.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon Container
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: advantage.gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: advantage.color.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          advantage.icon,
                          size: 28,
                          color: AppColors.textLight,
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              advantage.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              advantage.description,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final stats = [
      StatItem(
        number: 100,
        suffix: '%',
        label: 'Client Satisfaction',
        description: 'Rating sempurna dari semua klien',
        icon: Icons.sentiment_very_satisfied_rounded,
        color: AppColors.success,
      ),
      StatItem(
        number: 50,
        suffix: '+',
        label: 'Projects Completed',
        description: 'Project berhasil diselesaikan',
        icon: Icons.assignment_turned_in_rounded,
        color: AppColors.primary,
      ),
      StatItem(
        number: 3,
        suffix: '+',
        label: 'Years Experience',
        description: 'Tahun pengalaman profesional',
        icon: Icons.access_time_rounded,
        color: AppColors.secondary,
      ),
      StatItem(
        number: 24,
        suffix: '/7',
        label: 'Support Available',
        description: 'Support tersedia setiap saat',
        icon: Icons.support_agent_rounded,
        color: AppColors.accent,
      ),
    ];

    return ResponsiveBuilder(
      mobile: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) => _buildStatCard(context, stats[index], index),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.2,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) => _buildStatCard(context, stats[index], index),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, StatItem stat, int index) {
    return AnimatedBuilder(
      animation: _statAnimations[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _statAnimations[index].value)),
          child: Opacity(
            opacity: _statAnimations[index].value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: stat.color.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: stat.color.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: stat.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      stat.icon,
                      size: 28,
                      color: stat.color,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Animated Number
                  AnimatedBuilder(
                    animation: _counterController,
                    builder: (context, child) {
                      final animatedValue = (stat.number * _counterController.value).round();
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: animatedValue.toString(),
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: stat.color,
                                fontSize: ScreenSize.isMobile(context) ? 24 : 28,
                              ),
                            ),
                            TextSpan(
                              text: stat.suffix,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: stat.color,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  // Label
                  Text(
                    stat.label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 4),

                  // Description
                  Text(
                    stat.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Data Models
class MainAdvantage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final List<Color> gradient;

  MainAdvantage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.gradient,
  });
}

class StatItem {
  final int number;
  final String suffix;
  final String label;
  final String description;
  final IconData icon;
  final Color color;

  StatItem({
    required this.number,
    required this.suffix,
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// Custom Painter for Geometric Pattern
class GeometricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.primary.withOpacity(0.1);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.secondary.withOpacity(0.05);

    // Draw subtle geometric shapes
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 6; j++) {
        final x = (size.width / 8) * i;
        final y = (size.height / 6) * j;
        
        // Hexagon pattern
        final hexPath = Path();
        final radius = 30.0;
        
        for (int k = 0; k < 6; k++) {
          final angle = (k * 60) * (3.14159 / 180);
          final dx = x + radius * cos(angle);
          final dy = y + radius * sin(angle);
          
          if (k == 0) {
            hexPath.moveTo(dx, dy);
          } else {
            hexPath.lineTo(dx, dy);
          }
        }
        hexPath.close();
        
        // Only draw some hexagons for subtle effect
        if ((i + j) % 3 == 0) {
          canvas.drawPath(hexPath, fillPaint);
          canvas.drawPath(hexPath, paint);
        }
      }
    }

    // Add some floating circles
    final circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.accent.withOpacity(0.03);

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 50, circlePaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), 30, circlePaint);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.8), 40, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}