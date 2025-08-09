import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jostar_programming/widgets/home/cta_section.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';
import '../widgets/common/animations.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with TickerProviderStateMixin {
  String _selectedFilter = 'All';
  late AnimationController _animationController;

  final List<String> _filters = ['All', 'Mobile App', 'Website', 'E-commerce'];

  final List<PortfolioProject> _projects = [
    PortfolioProject(
      id: '1',
      title: 'TokoBagus Mobile App',
      category: 'Mobile App',
      type: ProjectType.mobile,
      description:
          'Aplikasi e-commerce lengkap untuk menjual produk fashion dengan fitur payment gateway, inventory management, dan push notifications.',
      image:
          'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&q=80',
      technologies: ['Flutter', 'Firebase', 'Midtrans', 'Google Maps'],
      client: 'TokoBagus Indonesia',
      duration: '3 months',
      year: '2024',
      features: [
        'Product catalog dengan search dan filter',
        'Shopping cart dan checkout system',
        'Multiple payment methods (OVO, DANA, Bank Transfer)',
        'Real-time order tracking',
        'Push notifications untuk promo dan status order',
        'Rating dan review system',
        'Admin panel untuk manage products',
      ],
      results: [
        '300+ downloads dalam bulan pertama',
        '25% peningkatan penjualan online',
        '4.8 rating di Play Store & App Store',
      ],
      testimonial:
          'Aplikasi yang dibuat Jostar Programming sangat membantu bisnis kami. Interface yang user-friendly dan performa yang cepat membuat pelanggan senang berbelanja melalui aplikasi.',
      clientName: 'Budi Santoso',
      clientPosition: 'CEO TokoBagus',
      color: AppColors.primary,
    ),
    PortfolioProject(
      id: '2',
      title: 'RestoKita Website',
      category: 'Website',
      type: ProjectType.web,
      description:
          'Website restaurant dengan sistem online ordering, table reservation, dan integration dengan payment gateway untuk bisnis F&B.',
      image:
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&q=80',
      technologies: [
        'Flutter Web',
        'Firebase',
        'Stripe',
        'Google Calendar API',
      ],
      client: 'RestoKita Chain',
      duration: '2 months',
      year: '2024',
      features: [
        'Menu digital dengan foto dan deskripsi lengkap',
        'Online ordering untuk delivery dan pickup',
        'Table reservation system',
        'Payment integration (Credit Card, QRIS)',
        'Real-time order status tracking',
        'Customer loyalty program',
        'Restaurant admin dashboard',
      ],
      results: [
        '200% peningkatan online orders',
        '50% reduction dalam phone orders',
        '4.9 rating dari customer satisfaction',
      ],
      testimonial:
          'Website yang profesional dan mudah digunakan. Sistem reservasi meja dan online ordering bekerja dengan sempurna. Customer kami sangat puas!',
      clientName: 'Sari Dewi',
      clientPosition: 'Owner RestoKita',
      color: AppColors.accent,
    ),
    PortfolioProject(
      id: '3',
      title: 'HealthPlus Management System',
      category: 'Mobile App',
      type: ProjectType.mobile,
      description:
          'Sistem manajemen rumah sakit komprehensif dengan fitur appointment booking, medical records, dan consultation untuk healthcare industry.',
      image:
          'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=800&q=80',
      technologies: ['Flutter', 'Node.js', 'PostgreSQL', 'WebRTC'],
      client: 'HealthPlus Hospital',
      duration: '4 months',
      year: '2023',
      features: [
        'Patient registration dan profile management',
        'Doctor appointment booking system',
        'Digital medical records dan prescription',
        'Video consultation dengan WebRTC',
        'Laboratory results integration',
        'Payment dan insurance integration',
        'Hospital staff management dashboard',
      ],
      results: [
        '60% reduction dalam waiting time',
        '40% peningkatan patient satisfaction',
        '100% digitalization dari medical records',
      ],
      testimonial:
          'Sistem yang sangat membantu operasional rumah sakit kami. Proses booking appointment jadi lebih efisien dan medical records tersimpan dengan aman.',
      clientName: 'Dr. Ahmad Rahman',
      clientPosition: 'Director HealthPlus',
      color: AppColors.success,
    ),
    PortfolioProject(
      id: '4',
      title: 'EduSmart Learning Platform',
      category: 'Website',
      type: ProjectType.web,
      description:
          'Platform e-learning komprehensif untuk institusi pendidikan dengan fitur live streaming, quiz, assignment, dan progress tracking.',
      image:
          'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&q=80',
      technologies: ['Flutter Web', 'Firebase', 'Agora.io', 'Cloud Storage'],
      client: 'EduSmart Institute',
      duration: '3 months',
      year: '2023',
      features: [
        'Course management dan content delivery',
        'Live streaming classes dengan recording',
        'Interactive quiz dan assessment',
        'Assignment submission dan grading',
        'Student progress tracking',
        'Discussion forum dan chat',
        'Certificate generation system',
      ],
      results: [
        '500+ students enrolled',
        '95% course completion rate',
        '4.7 average course rating',
      ],
      testimonial:
          'Platform yang sangat mudah digunakan baik untuk guru maupun siswa. Fitur live streaming sangat stabil dan kualitas video jernih.',
      clientName: 'Prof. Linda Sari',
      clientPosition: 'Director EduSmart',
      color: AppColors.secondary,
    ),
    PortfolioProject(
      id: '5',
      title: 'FitTracker Mobile App',
      category: 'Mobile App',
      type: ProjectType.mobile,
      description:
          'Aplikasi fitness tracking dengan fitur workout plans, nutrition tracking, progress monitoring, dan social community features.',
      image:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&q=80',
      technologies: ['Flutter', 'Firebase', 'HealthKit', 'Google Fit'],
      client: 'FitLife Gym',
      duration: '2.5 months',
      year: '2024',
      features: [
        'Personalized workout plans',
        'Exercise video tutorials',
        'Nutrition dan calorie tracking',
        'Progress photos dan measurements',
        'Social community dan challenges',
        'Wearable device integration',
        'Personal trainer booking',
      ],
      results: [
        '1000+ active users',
        '80% user retention rate',
        '4.6 App Store rating',
      ],
      testimonial:
          'Aplikasi fitness terbaik yang pernah kami gunakan untuk members gym. Fitur tracking sangat akurat dan motivating untuk workout.',
      clientName: 'Rio Pratama',
      clientPosition: 'Owner FitLife Gym',
      color: AppColors.warning,
    ),
    PortfolioProject(
      id: '6',
      title: 'SmartInventory System',
      category: 'E-commerce',
      type: ProjectType.web,
      description:
          'Sistem manajemen inventory cerdas untuk retail business dengan fitur real-time stock monitoring, automated reordering, dan sales analytics.',
      image:
          'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&q=80',
      technologies: ['Flutter Web', 'Node.js', 'MongoDB', 'Chart.js'],
      client: 'RetailMax Indonesia',
      duration: '2 months',
      year: '2024',
      features: [
        'Real-time inventory tracking',
        'Automated low stock alerts',
        'Supplier management system',
        'Purchase order automation',
        'Sales analytics dan reporting',
        'Barcode scanning integration',
        'Multi-location inventory support',
      ],
      results: [
        '30% reduction in stock-out incidents',
        '25% improvement in inventory turnover',
        'Rp 100M+ inventory value tracked',
      ],
      testimonial:
          'Sistem inventory yang sangat powerful dan user-friendly. Automated alerts membantu kami tidak pernah kehabisan stock lagi.',
      clientName: 'Maria Gonzales',
      clientPosition: 'Operations Manager RetailMax',
      color: AppColors.error,
    ),
  ];

  List<PortfolioProject> get _filteredProjects {
    if (_selectedFilter == 'All') return _projects;
    return _projects
        .where((project) => project.category == _selectedFilter)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildFilterSection(context),
          _buildProjectsGrid(context),
          _buildTestimonialsSection(context),
       CTASection()
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
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
            AppColors.primary.withOpacity(0.03),
            AppColors.secondary.withOpacity(0.08),
            AppColors.accent.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: FadeSlideAnimation(
            child: Column(
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.secondary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.secondary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PORTFOLIO TERBAIK KAMI',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Main Heading
                ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                          AppColors.accent,
                        ],
                      ).createShader(bounds),
                  child: Text(
                    'Karya Digital Terbaik',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: ScreenSize.isMobile(context) ? 36 : 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Yang Mengubah Bisnis',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: ScreenSize.isMobile(context) ? 24 : 32,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Description
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Koleksi project digital terbaik yang telah mengubah cara bisnis beroperasi. '
                    'Dari aplikasi mobile hingga website enterprise, setiap karya dirancang dengan detail dan passion.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.6,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),

                // Stats
                _buildEnhancedStats(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedStats(BuildContext context) {
    final stats = [
      {
        'number': '50+',
        'label': 'Projects Completed',
        'icon': Icons.assignment_turned_in,
        'color': AppColors.primary,
      },
      {
        'number': '20+',
        'label': 'Happy Clients',
        'icon': Icons.sentiment_very_satisfied,
        'color': AppColors.secondary,
      },
      {
        'number': '100%',
        'label': 'Success Rate',
        'icon': Icons.star,
        'color': AppColors.accent,
      },
      {
        'number': '24/7',
        'label': 'Support Available',
        'icon': Icons.support_agent,
        'color': AppColors.success,
      },
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children:
            stats.map((stat) => _buildEnhancedStatCard(context, stat)).toList(),
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            stats
                .map(
                  (stat) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildEnhancedStatCard(context, stat),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildEnhancedStatCard(
    BuildContext context,
    Map<String, Object> stat,
  ) {
    final stats = [
      {
        'number': '50+',
        'label': 'Projects Completed',
        'icon': Icons.assignment_turned_in,
        'color': AppColors.primary,
      },
      {
        'number': '20+',
        'label': 'Happy Clients',
        'icon': Icons.sentiment_very_satisfied,
        'color': AppColors.secondary,
      },
      {
        'number': '100%',
        'label': 'Success Rate',
        'icon': Icons.star,
        'color': AppColors.accent,
      },
      {
        'number': '24/7',
        'label': 'Support Available',
        'icon': Icons.support_agent,
        'color': AppColors.success,
      },
    ];

    return ScaleAnimation(
      delay: Duration(milliseconds: stats.indexOf(stat) * 200),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (stat['color'] as Color).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: (stat['color'] as Color).withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (stat['color'] as Color).withOpacity(0.8),
                    (stat['color'] as Color).withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (stat['color'] as Color).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                stat['icon'] as IconData,
                size: 28,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedCounter(
              targetNumber:
                  int.tryParse(
                    stat['number'].toString().replaceAll(RegExp(r'[^0-9]'), ''),
                  ) ??
                  0,
              suffix: stat['number'].toString().replaceAll(
                RegExp(r'[0-9]'),
                '',
              ),
              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: stat['color'] as Color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stat['label'].toString(),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 40,
      ),
      color: AppColors.background.withOpacity(0.5),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: FadeSlideAnimation(
            delay: const Duration(milliseconds: 300),
            child: Column(
              children: [
                Text(
                  'Jelajahi Berdasarkan Kategori',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                ResponsiveBuilder(
                  mobile: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children:
                        _filters
                            .map((filter) => _buildEnhancedFilterChip(filter))
                            .toList(),
                  ),
                  desktop: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        _filters
                            .map(
                              (filter) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: _buildEnhancedFilterChip(filter),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedFilterChip(String filter) {
    final isSelected = _selectedFilter == filter;
    return HoverAnimation(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = filter;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient:
                isSelected
                    ? LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    )
                    : null,
            color: isSelected ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color:
                    isSelected
                        ? AppColors.primary.withOpacity(0.3)
                        : AppColors.neutral.withOpacity(0.1),
                blurRadius: isSelected ? 12 : 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color:
                  isSelected
                      ? Colors.transparent
                      : AppColors.neutral.withOpacity(0.2),
            ),
          ),
          child: Text(
            filter,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? AppColors.textLight : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
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
          child: StaggeredListAnimation(
            children: [
              Text(
                'Featured Projects',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Setiap project memiliki cerita unik dan solusi inovatif',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              ResponsiveBuilder(
                mobile: Column(
                  children:
                      _filteredProjects
                          .map(
                            (project) => Padding(
                              padding: const EdgeInsets.only(bottom: 32),
                              child: _buildEnhancedProjectCard(
                                context,
                                project,
                              ),
                            ),
                          )
                          .toList(),
                ),
                desktop: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _filteredProjects.length,
                  itemBuilder:
                      (context, index) => _buildEnhancedProjectCard(
                        context,
                        _filteredProjects[index],
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedProjectCard(
    BuildContext context,
    PortfolioProject project,
  ) {
    return HoverAnimation(
      scale: 1.02,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: project.color.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Project Image
            _buildEnhancedProjectImage(context, project),

            // Project Content
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Year
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              project.color.withOpacity(0.1),
                              project.color.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: project.color.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          project.category,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: project.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          project.year,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Project Title
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Client
                  Text(
                    project.client,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: project.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

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
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        project.technologies
                            .take(3)
                            .map(
                              (tech) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.neutral.withOpacity(0.2),
                                  ),
                                ),
                                child: Text(
                                  tech,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),

                  const SizedBox(height: 24),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            project.color,
                            project.color.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: project.color.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _showProjectDetails(context, project),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.textLight,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View Details',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 18),
                          ],
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
  }

  Widget _buildEnhancedProjectImage(
    BuildContext context,
    PortfolioProject project,
  ) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: project.color.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Stack(
          children: [
            // Real Project Image
            Image.network(
              project.image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        project.color.withOpacity(0.8),
                        project.color.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      project.type == ProjectType.mobile
                          ? Icons.phone_android
                          : Icons.laptop_mac,
                      size: 60,
                      color: AppColors.textLight,
                    ),
                  ),
                );
              },
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                    project.color.withOpacity(0.3),
                  ],
                ),
              ),
            ),

            // Project Type Badge
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textLight.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      project.type == ProjectType.mobile
                          ? Icons.phone_android
                          : Icons.laptop_mac,
                      size: 14,
                      color: project.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      project.type == ProjectType.mobile ? 'Mobile' : 'Web',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: project.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Duration Badge
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  project.duration,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProjectDetails(BuildContext context, PortfolioProject project) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailsDialog(project: project),
    );
  }

  Widget _buildTestimonialsSection(BuildContext context) {
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
            AppColors.background.withOpacity(0.8),
            AppColors.primary.withOpacity(0.02),
            AppColors.secondary.withOpacity(0.02),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: FadeSlideAnimation(
            child: Column(
              children: [
                Text(
                  'Apa Kata Klien Kami',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Testimoni dari klien yang telah merasakan transformasi digital',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                ResponsiveBuilder(
                  mobile: Column(
                    children:
                        _projects
                            .take(3)
                            .map(
                              (project) => Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: _buildEnhancedTestimonialCard(
                                  context,
                                  project,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  desktop: Row(
                    children:
                        _projects
                            .take(3)
                            .map(
                              (project) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: _buildEnhancedTestimonialCard(
                                    context,
                                    project,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedTestimonialCard(
    BuildContext context,
    PortfolioProject project,
  ) {
    return HoverAnimation(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: project.color.withOpacity(0.08),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
          border: Border.all(color: project.color.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            // Quote Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [project.color, project.color.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: project.color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.format_quote,
                size: 28,
                color: AppColors.textLight,
              ),
            ),

            const SizedBox(height: 24),

            // Testimonial Text
            Text(
              '"${project.testimonial}"',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontStyle: FontStyle.italic,
                height: 1.6,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Rating Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Icon(Icons.star, size: 20, color: AppColors.accent),
              ),
            ),

            const SizedBox(height: 20),

            // Client Info
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: project.color,
                  child: Text(
                    project.clientName.split(' ').map((e) => e[0]).join(''),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.clientName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        project.clientPosition,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        project.client,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: project.color,
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
      ),
    );
  }
}

// Enhanced Project Details Dialog
class ProjectDetailsDialog extends StatelessWidget {
  final PortfolioProject project;

  const ProjectDetailsDialog({Key? key, required this.project})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width:
            ScreenSize.isMobile(context)
                ? MediaQuery.of(context).size.width * 0.95
                : MediaQuery.of(context).size.width * 0.7,
        height:
            ScreenSize.isMobile(context)
                ? MediaQuery.of(context).size.height * 0.85
                : MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: project.color.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          children: [
            // Enhanced Header with Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: Stack(
                  children: [
                    // Project Image
                    Image.network(
                      project.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                project.color,
                                project.color.withOpacity(0.8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),

                    // Header Content
                    Positioned(
                      bottom: 24,
                      left: 32,
                      right: 32,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    color: AppColors.textLight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${project.client} • ${project.duration} • ${project.year}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textLight.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.textLight.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close,
                                color: AppColors.textLight,
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

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    _buildSection(
                      context,
                      'Project Overview',
                      project.description,
                      Icons.description,
                      project.color,
                    ),

                    const SizedBox(height: 32),

                    // Features
                    _buildListSection(
                      context,
                      'Key Features',
                      project.features,
                      Icons.star,
                      project.color,
                    ),

                    const SizedBox(height: 32),

                    // Technologies
                    _buildTechSection(context, project),

                    const SizedBox(height: 32),

                    // Results
                    _buildListSection(
                      context,
                      'Project Results',
                      project.results,
                      Icons.trending_up,
                      AppColors.success,
                    ),
                  ],
                ),
              ),
            ),

            // Footer Actions
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.background.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/services');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: project.color,
                        side: BorderSide(color: project.color, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Lihat Layanan'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            project.color,
                            project.color.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.go('/contact');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.textLight,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Mulai Project'),
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
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildListSection(
    BuildContext context,
    String title,
    List<String> items,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTechSection(BuildContext context, PortfolioProject project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: project.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.code, size: 20, color: project.color),
            ),
            const SizedBox(width: 12),
            Text(
              'Technologies Used',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              project.technologies
                  .map(
                    (tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            project.color.withOpacity(0.1),
                            project.color.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: project.color.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        tech,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: project.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

// Data Models (unchanged)
enum ProjectType { mobile, web }

class PortfolioProject {
  final String id;
  final String title;
  final String category;
  final ProjectType type;
  final String description;
  final String image;
  final List<String> technologies;
  final String client;
  final String duration;
  final String year;
  final List<String> features;
  final List<String> results;
  final String testimonial;
  final String clientName;
  final String clientPosition;
  final Color color;

  PortfolioProject({
    required this.id,
    required this.title,
    required this.category,
    required this.type,
    required this.description,
    required this.image,
    required this.technologies,
    required this.client,
    required this.duration,
    required this.year,
    required this.features,
    required this.results,
    required this.testimonial,
    required this.clientName,
    required this.clientPosition,
    required this.color,
  });
}
