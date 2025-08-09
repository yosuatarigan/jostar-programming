import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

class PortfolioPreview extends StatefulWidget {
  const PortfolioPreview({Key? key}) : super(key: key);

  @override
  State<PortfolioPreview> createState() => _PortfolioPreviewState();
}

class _PortfolioPreviewState extends State<PortfolioPreview>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _cardAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.2 + (index * 0.15),
            0.7 + (index * 0.15),
            curve: Curves.easeOut,
          ),
        ),
      );
    });

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
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.02),
            AppColors.secondary.withOpacity(0.05),
            AppColors.accent.withOpacity(0.02),
          ],
        ),
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
              _buildPortfolioGrid(context),
              const SizedBox(height: 80),
              _buildViewMoreSection(context),
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
                        AppColors.secondary.withOpacity(0.1),
                        AppColors.accent.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.secondary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.folder_open_rounded,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PORTFOLIO SHOWCASE',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondary,
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
                  'Karya Terbaik Kami',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 32 : 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Description
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Lihat beberapa project digital terbaik yang telah kami kerjakan untuk berbagai klien di Indonesia. '
                    'Setiap project dirancang dengan detail dan teknologi terdepan.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: Colors.white
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

  Widget _buildPortfolioGrid(BuildContext context) {
    final projects = [
      PortfolioProject(
        title: 'TokoBagus Mobile App',
        category: 'Mobile App',
        client: 'E-commerce Platform',
        description: 'Aplikasi e-commerce lengkap dengan payment gateway, inventory management, dan sistem notifikasi real-time',
        imageUrl: 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
        technologies: ['Flutter', 'Firebase', 'Stripe', 'Push Notifications'],
        type: ProjectType.mobile,
        color: AppColors.primary,
        stats: [
          ProjectStat('300+', 'Downloads'),
          ProjectStat('4.8', 'Rating'),
          ProjectStat('25%', 'Sales Increase'),
        ],
      ),
      PortfolioProject(
        title: 'RestoKita Website',
        category: 'Website',
        client: 'Restaurant Chain',
        description: 'Website restaurant modern dengan online ordering, table reservation, dan customer loyalty program',
        imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
        technologies: ['Flutter Web', 'Firebase', 'Payment Gateway', 'Maps API'],
        type: ProjectType.web,
        color: AppColors.secondary,
        stats: [
          ProjectStat('200%', 'Online Orders'),
          ProjectStat('4.9', 'Customer Rating'),
          ProjectStat('50%', 'Cost Reduction'),
        ],
      ),
      PortfolioProject(
        title: 'HealthPlus System',
        category: 'Mobile App',
        client: 'Healthcare Provider',
        description: 'Sistem manajemen rumah sakit comprehensive dengan appointment booking, medical records, dan telemedicine',
        imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
        technologies: ['Flutter', 'Node.js', 'PostgreSQL', 'WebRTC'],
        type: ProjectType.mobile,
        color: AppColors.success,
        stats: [
          ProjectStat('60%', 'Time Saved'),
          ProjectStat('100%', 'Digital Records'),
          ProjectStat('40%', 'Patient Satisfaction'),
        ],
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: projects.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _buildProjectCard(context, entry.value, entry.key),
          );
        }).toList(),
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: projects.asMap().entries.map((entry) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildProjectCard(context, entry.value, entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, PortfolioProject project, int index) {
    return AnimatedBuilder(
      animation: _cardAnimations[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _cardAnimations[index].value)),
          child: Opacity(
            opacity: _cardAnimations[index].value,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: project.color.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: AppColors.neutral.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Image
                  _buildProjectImage(project),
                  
                  // Project Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: project.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                project.type == ProjectType.mobile 
                                    ? Icons.phone_android_rounded
                                    : Icons.web_rounded,
                                size: 12,
                                color: project.color,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                project.category,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: project.color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Project Title
                        Text(
                          project.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Client
                        Text(
                          project.client,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: project.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Technologies
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: project.technologies.take(3).map((tech) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.neutral.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )).toList(),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Project Stats
                        _buildProjectStats(context, project),
                        
                        const SizedBox(height: 24),
                        
                        // View Details Button
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton.icon(
                            onPressed: () => context.go('/portfolio'),
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: AppColors.textLight,
                            ),
                            label: Text(
                              'Lihat Detail',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: project.color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
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
  }

  Widget _buildProjectImage(PortfolioProject project) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        image: DecorationImage(
          image: NetworkImage(project.imageUrl),
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
              project.color.withOpacity(0.2),
              project.color.withOpacity(0.6),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Live Badge
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.textLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'LIVE',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Project Type Icon
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.textLight.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  project.type == ProjectType.mobile 
                      ? Icons.smartphone_rounded
                      : Icons.laptop_mac_rounded,
                  size: 24,
                  color: project.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectStats(BuildContext context, PortfolioProject project) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: project.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: project.stats.asMap().entries.map((entry) {
          final stat = entry.value;
          final isLast = entry.key == project.stats.length - 1;
          
          return Expanded(
            child: Column(
              children: [
                Text(
                  stat.value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: project.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stat.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildViewMoreSection(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.secondary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.secondary.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_special_rounded,
                      color: AppColors.secondary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '50+ Project Lainnya',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Lihat portfolio lengkap kami dengan berbagai project menarik dari berbagai industri',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ResponsiveBuilder(
                  mobile: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () => context.go('/portfolio'),
                          icon: const Icon(
                            Icons.visibility_rounded,
                            color: AppColors.textLight,
                            size: 18,
                          ),
                          label: Text(
                            'Lihat Portfolio Lengkap',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () => context.go('/contact'),
                          icon: const Icon(
                            Icons.chat_rounded,
                            color: AppColors.secondary,
                            size: 18,
                          ),
                          label: Text(
                            'Diskusi Project Anda',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.secondary, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  desktop: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () => context.go('/portfolio'),
                          icon: const Icon(
                            Icons.visibility_rounded,
                            color: AppColors.textLight,
                            size: 18,
                          ),
                          label: Text(
                            'Lihat Portfolio Lengkap',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () => context.go('/contact'),
                          icon: const Icon(
                            Icons.chat_rounded,
                            color: AppColors.secondary,
                            size: 18,
                          ),
                          label: Text(
                            'Diskusi Project Anda',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.secondary, width: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
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

// Data Models
enum ProjectType { mobile, web }

class PortfolioProject {
  final String title;
  final String category;
  final String client;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final ProjectType type;
  final Color color;
  final List<ProjectStat> stats;

  PortfolioProject({
    required this.title,
    required this.category,
    required this.client,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.type,
    required this.color,
    required this.stats,
  });
}

class ProjectStat {
  final String value;
  final String label;

  ProjectStat(this.value, this.label);
}