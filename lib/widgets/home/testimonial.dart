import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../common/responsive_builder.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({Key? key}) : super(key: key);

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<TestimonialItem> _testimonials = [
    TestimonialItem(
      name: 'Budi Santoso',
      position: 'CEO, TokoBagusku',
      company: 'E-commerce',
      message: 'Jostar Programming berhasil mengembangkan aplikasi mobile yang sempurna untuk toko online kami. Hasilnya melebihi ekspektasi!',
      rating: 5,
      avatar: 'BS',
    ),
    TestimonialItem(
      name: 'Sari Dewi',
      position: 'Founder, RestoKita',
      company: 'F&B Industry',
      message: 'Website restaurant yang dibuat sangat profesional dan membantu meningkatkan penjualan online kami hingga 200%.',
      rating: 5,
      avatar: 'SD',
    ),
    TestimonialItem(
      name: 'Ahmad Rahman',
      position: 'Director, HealthPlus',
      company: 'Healthcare',
      message: 'Sistem manajemen rumah sakit yang dibangun sangat user-friendly dan membantu operasional harian kami.',
      rating: 5,
      avatar: 'AR',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _nextTestimonial();
        _startAutoScroll();
      }
    });
  }

  void _nextTestimonial() {
    if (_currentIndex < _testimonials.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(context),
              const SizedBox(height: 60),
              _buildTestimonialCarousel(context),
              const SizedBox(height: 32),
              _buildDots(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'TESTIMONI',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Apa Kata Klien Kami',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Kepuasan klien adalah prioritas utama kami. Simak pengalaman mereka bekerja sama dengan Jostar Programming.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTestimonialCarousel(BuildContext context) {
    return SizedBox(
      height: ScreenSize.isMobile(context) ? 280 : 320,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // Quote Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.format_quote,
              size: 28,
              color: AppColors.primary,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Testimonial Message
          Expanded(
            child: Text(
              '"${testimonial.message}"',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Rating Stars
          _buildRatingStars(testimonial.rating),
          
          const SizedBox(height: 16),
          
          // Client Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primary,
                child: Text(
                  testimonial.avatar,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      testimonial.position,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      testimonial.company,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 20,
          color: index < rating ? AppColors.accent : AppColors.neutral.withOpacity(0.3),
        );
      }),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_testimonials.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentIndex == index 
                ? AppColors.primary 
                : AppColors.neutral.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class TestimonialItem {
  final String name;
  final String position;
  final String company;
  final String message;
  final int rating;
  final String avatar;

  TestimonialItem({
    required this.name,
    required this.position,
    required this.company,
    required this.message,
    required this.rating,
    required this.avatar,
  });
}