import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../common/responsive_builder.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({Key? key}) : super(key: key);

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late AnimationController _autoScrollController;
  late Animation<double> _headerAnimation;

  int _currentIndex = 0;
  bool _isAutoScrolling = true;

  final List<TestimonialItem> _testimonials = [
    TestimonialItem(
      name: 'Budi Santoso',
      position: 'CEO',
      company: 'TokoBagusku',
      companyType: 'E-commerce Platform',
      message: 'Jostar Programming berhasil mengembangkan aplikasi mobile yang sempurna untuk toko online kami. '
          'Performance yang excellent, UI/UX yang intuitive, dan fitur-fitur yang comprehensive. '
          'Hasilnya melebihi ekspektasi dan ROI sangat memuaskan!',
      rating: 5,
      avatar: 'BS',
      avatarColor: AppColors.primary,
      projectValue: 'Rp 25 Juta',
      completionTime: '3 Bulan',
      results: [
        '300+ downloads dalam bulan pertama',
        '25% peningkatan penjualan online',
        '4.8 rating di App Store',
      ],
      image: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=2340&q=80',
    ),
    TestimonialItem(
      name: 'Sari Dewi',
      position: 'Founder & Owner',
      company: 'RestoKita Chain',
      companyType: 'Restaurant Business',
      message: 'Website restaurant yang dibuat sangat profesional dan user-friendly. '
          'Sistem reservasi meja dan online ordering bekerja dengan sempurna. '
          'Customer kami sangat puas dan penjualan online meningkat drastis!',
      rating: 5,
      avatar: 'SD',
      avatarColor: AppColors.secondary,
      projectValue: 'Rp 18 Juta',
      completionTime: '2 Bulan',
      results: [
        '200% peningkatan online orders',
        '50% reduction dalam phone orders',
        '4.9 customer satisfaction rating',
      ],
      image: 'https://images.unsplash.com/photo-1559329007-40df8a9345d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=2340&q=80',
    ),
    TestimonialItem(
      name: 'Dr. Ahmad Rahman',
      position: 'Medical Director',
      company: 'HealthPlus Hospital',
      companyType: 'Healthcare Provider',
      message: 'Sistem manajemen rumah sakit yang dibangun sangat comprehensive dan user-friendly. '
          'Proses booking appointment jadi lebih efisien, medical records tersimpan dengan aman, '
          'dan telemedicine feature sangat membantu di era digital ini.',
      rating: 5,
      avatar: 'AR',
      avatarColor: AppColors.success,
      projectValue: 'Rp 45 Juta',
      completionTime: '4 Bulan',
      results: [
        '60% reduction dalam waiting time',
        '100% digitalization medical records',
        '40% peningkatan patient satisfaction',
      ],
      image: 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?ixlib=rb-4.0.3&auto=format&fit=crop&w=2340&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupAutoScroll();
  }

  void _setupAnimations() {
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _autoScrollController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  void _setupAutoScroll() {
    _autoScrollController.addStatusListener((status) {
      if (status == AnimationStatus.completed && _isAutoScrolling) {
        _nextTestimonial();
        _autoScrollController.reset();
        _autoScrollController.forward();
      }
    });
    _autoScrollController.forward();
  }

  void _nextTestimonial() {
    if (_currentIndex < _testimonials.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    _updatePage();
  }

  void _previousTestimonial() {
    if (_currentIndex > 0) {
      _currentIndex--;
    } else {
      _currentIndex = _testimonials.length - 1;
    }
    _updatePage();
  }

  void _updatePage() {
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _pauseAutoScroll() {
    setState(() {
      _isAutoScrolling = false;
    });
    _autoScrollController.stop();
  }

  void _resumeAutoScroll() {
    setState(() {
      _isAutoScrolling = true;
    });
    _autoScrollController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.surface,
            AppColors.primary.withOpacity(0.02),
            AppColors.surface,
          ],
        ),
      ),
      child: Stack(
        children: [
          _buildBackgroundElements(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=2071&q=80'
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.surface.withOpacity(0.98),
              BlendMode.overlay,
            ),
          ),
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
          child: Column(
            children: [
              _buildSectionHeader(context),
              const SizedBox(height: 80),
              _buildTestimonialCarousel(context),
              const SizedBox(height: 40),
              _buildControls(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _headerAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - _headerAnimation.value)),
            child: Column(
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withOpacity(0.1),
                        AppColors.success.withOpacity(0.1),
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
                        Icons.format_quote_rounded,
                        size: 16,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'CLIENT TESTIMONIALS',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Main Title
                Text(
                  'Apa Kata Klien Kami',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Subtitle
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Kepuasan klien adalah prioritas utama kami. Dengarkan pengalaman mereka '
                    'bekerja sama dengan Jostar Programming dalam mewujudkan visi digital.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestimonialCarousel(BuildContext context) {
    return SizedBox(
      height: ScreenSize.isMobile(context) ? 600 : 500,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: _testimonials.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.isMobile(context) ? 0 : 40,
            ),
            child: _buildTestimonialCard(context, _testimonials[index]),
          );
        },
      ),
    );
  }

  Widget _buildTestimonialCard(BuildContext context, TestimonialItem testimonial) {
    return MouseRegion(
      onEnter: (_) => _pauseAutoScroll(),
      onExit: (_) => _resumeAutoScroll(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: testimonial.avatarColor.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ResponsiveBuilder(
          mobile: _buildMobileTestimonialCard(context, testimonial),
          desktop: _buildDesktopTestimonialCard(context, testimonial),
        ),
      ),
    );
  }

  Widget _buildDesktopTestimonialCard(BuildContext context, TestimonialItem testimonial) {
    return Row(
      children: [
        // Image Section
        Expanded(
          flex: 4,
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              image: DecorationImage(
                image: NetworkImage(testimonial.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    testimonial.avatarColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    // Project Info
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.textLight.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project Details',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: testimonial.avatarColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildProjectDetail('Value', testimonial.projectValue),
                          _buildProjectDetail('Timeline', testimonial.completionTime),
                          const SizedBox(height: 12),
                          Text(
                            'Results:',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...testimonial.results.map((result) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: AppColors.success,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    result,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
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
        
        // Content Section
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: _buildTestimonialContent(context, testimonial),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTestimonialCard(BuildContext context, TestimonialItem testimonial) {
    return Column(
      children: [
        // Image Header
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            image: DecorationImage(
              image: NetworkImage(testimonial.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  testimonial.avatarColor.withOpacity(0.6),
                ],
              ),
            ),
          ),
        ),
        
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _buildTestimonialContent(context, testimonial),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialContent(BuildContext context, TestimonialItem testimonial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Quote Icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                testimonial.avatarColor,
                testimonial.avatarColor.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.format_quote_rounded,
            size: 28,
            color: AppColors.textLight,
          ),
        ),

        const SizedBox(height: 24),

        // Company Type Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: testimonial.avatarColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            testimonial.companyType,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: testimonial.avatarColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Testimonial Message
        Expanded(
          child: Text(
            '"${testimonial.message}"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.6,
              fontSize: ScreenSize.isMobile(context) ? 16 : 18,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Rating Stars
        Row(
          children: List.generate(5, (index) {
            return Icon(
              Icons.star_rounded,
              size: 20,
              color: index < testimonial.rating 
                  ? AppColors.accent 
                  : AppColors.neutral.withOpacity(0.3),
            );
          }),
        ),

        const SizedBox(height: 24),

        // Client Info
        Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundColor: testimonial.avatarColor,
              child: Text(
                testimonial.avatar,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Client Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    testimonial.position,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    testimonial.company,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: testimonial.avatarColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Column(
      children: [
        // Progress Indicator
        Container(
          height: 4,
          width: 200,
          decoration: BoxDecoration(
            color: AppColors.neutral.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
          child: AnimatedBuilder(
            animation: _autoScrollController,
            builder: (context, child) {
              return Row(
                children: [
                  // Completed sections
                  if (_currentIndex > 0)
                    Expanded(
                      flex: _currentIndex,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  // Current section (animated)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: _isAutoScrolling ? _autoScrollController.value : 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Remaining sections
                  if (_currentIndex < _testimonials.length - 1)
                    Expanded(
                      flex: _testimonials.length - 1 - _currentIndex,
                      child: Container(),
                    ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Navigation Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Button
            IconButton(
              onPressed: _previousTestimonial,
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.neutral.withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Dots Indicator
            Row(
              children: _testimonials.asMap().entries.map((entry) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == entry.key ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == entry.key 
                        ? AppColors.primary 
                        : AppColors.neutral.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(width: 20),

            // Next Button
            IconButton(
              onPressed: _nextTestimonial,
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.neutral.withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Auto-scroll Toggle
            IconButton(
              onPressed: () {
                if (_isAutoScrolling) {
                  _pauseAutoScroll();
                } else {
                  _resumeAutoScroll();
                }
              },
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _isAutoScrolling 
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isAutoScrolling 
                        ? AppColors.primary.withOpacity(0.3)
                        : AppColors.neutral.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  _isAutoScrolling ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 16,
                  color: _isAutoScrolling ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Data Model
class TestimonialItem {
  final String name;
  final String position;
  final String company;
  final String companyType;
  final String message;
  final int rating;
  final String avatar;
  final Color avatarColor;
  final String projectValue;
  final String completionTime;
  final List<String> results;
  final String image;

  TestimonialItem({
    required this.name,
    required this.position,
    required this.company,
    required this.companyType,
    required this.message,
    required this.rating,
    required this.avatar,
    required this.avatarColor,
    required this.projectValue,
    required this.completionTime,
    required this.results,
    required this.image,
  });
}