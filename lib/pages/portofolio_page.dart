import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String _selectedFilter = 'All';
  
  final List<String> _filters = ['All', 'Mobile App', 'Website', 'E-commerce'];
  
  final List<PortfolioProject> _projects = [
    PortfolioProject(
      id: '1',
      title: 'TokoBagus Mobile App',
      category: 'Mobile App',
      type: ProjectType.mobile,
      description: 'Aplikasi e-commerce lengkap untuk menjual produk fashion dengan fitur payment gateway, inventory management, dan push notifications.',
      image: 'assets/portfolio/tokobagus.png',
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
      testimonial: 'Aplikasi yang dibuat Jostar Programming sangat membantu bisnis kami. Interface yang user-friendly dan performa yang cepat membuat pelanggan senang berbelanja melalui aplikasi.',
      clientName: 'Budi Santoso',
      clientPosition: 'CEO TokoBagus',
    ),
    PortfolioProject(
      id: '2',
      title: 'RestoKita Website',
      category: 'Website',
      type: ProjectType.web,
      description: 'Website restaurant dengan sistem online ordering, table reservation, dan integration dengan payment gateway untuk bisnis F&B.',
      image: 'assets/portfolio/restokita.png',
      technologies: ['Flutter Web', 'Firebase', 'Stripe', 'Google Calendar API'],
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
      testimonial: 'Website yang profesional dan mudah digunakan. Sistem reservasi meja dan online ordering bekerja dengan sempurna. Customer kami sangat puas!',
      clientName: 'Sari Dewi',
      clientPosition: 'Owner RestoKita',
    ),
    PortfolioProject(
      id: '3',
      title: 'HealthPlus Management System',
      category: 'Mobile App',
      type: ProjectType.mobile,
      description: 'Sistem manajemen rumah sakit komprehensif dengan fitur appointment booking, medical records, dan consultation untuk healthcare industry.',
      image: 'assets/portfolio/healthplus.png',
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
      testimonial: 'Sistem yang sangat membantu operasional rumah sakit kami. Proses booking appointment jadi lebih efisien dan medical records tersimpan dengan aman.',
      clientName: 'Dr. Ahmad Rahman',
      clientPosition: 'Director HealthPlus',
    ),
    PortfolioProject(
      id: '4',
      title: 'EduSmart Learning Platform',
      category: 'Website',
      type: ProjectType.web,
      description: 'Platform e-learning komprehensif untuk institusi pendidikan dengan fitur live streaming, quiz, assignment, dan progress tracking.',
      image: 'assets/portfolio/edusmart.png',
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
      testimonial: 'Platform yang sangat mudah digunakan baik untuk guru maupun siswa. Fitur live streaming sangat stabil dan kualitas video jernih.',
      clientName: 'Prof. Linda Sari',
      clientPosition: 'Director EduSmart',
    ),
    PortfolioProject(
      id: '5',
      title: 'FitTracker Mobile App',
      category: 'Mobile App',
      type: ProjectType.mobile,
      description: 'Aplikasi fitness tracking dengan fitur workout plans, nutrition tracking, progress monitoring, dan social community features.',
      image: 'assets/portfolio/fittracker.png',
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
      testimonial: 'Aplikasi fitness terbaik yang pernah kami gunakan untuk members gym. Fitur tracking sangat akurat dan motivating untuk workout.',
      clientName: 'Rio Pratama',
      clientPosition: 'Owner FitLife Gym',
    ),
    PortfolioProject(
      id: '6',
      title: 'SmartInventory System',
      category: 'Website',
      type: ProjectType.web,
      description: 'Sistem manajemen inventory cerdas untuk retail business dengan fitur real-time stock monitoring, automated reordering, dan sales analytics.',
      image: 'assets/portfolio/smartinventory.png',
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
      testimonial: 'Sistem inventory yang sangat powerful dan user-friendly. Automated alerts membantu kami tidak pernah kehabisan stock lagi.',
      clientName: 'Maria Gonzales',
      clientPosition: 'Operations Manager RetailMax',
    ),
  ];

  List<PortfolioProject> get _filteredProjects {
    if (_selectedFilter == 'All') return _projects;
    return _projects.where((project) => project.category == _selectedFilter).toList();
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
          _buildCTASection(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withOpacity(0.05),
            AppColors.primary.withOpacity(0.1),
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
              Text(
                'Portfolio Kami',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: ScreenSize.isMobile(context) ? 32 : 48,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Koleksi project digital terbaik yang telah kami kerjakan untuk berbagai klien di Indonesia',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildPortfolioStats(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioStats(BuildContext context) {
    final stats = [
      {'number': '50+', 'label': 'Projects Completed'},
      {'number': '20+', 'label': 'Happy Clients'},
      {'number': '100%', 'label': 'Success Rate'},
      {'number': '24/7', 'label': 'Support Available'},
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: stats.map((stat) => _buildStatItem(context, stat)).toList(),
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.map((stat) => _buildStatItem(context, stat)).toList(),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, Map<String, String> stat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            stat['number']!,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            stat['label']!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
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
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: ResponsiveBuilder(
            mobile: Column(
              children: [
                Text(
                  'Filter by Category',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _filters.map((filter) => _buildFilterChip(filter)).toList(),
                ),
              ],
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Filter by Category: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 20),
                ..._filters.map((filter) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildFilterChip(filter),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final isSelected = _selectedFilter == filter;
    return FilterChip(
      label: Text(filter),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = filter;
        });
      },
      backgroundColor: AppColors.background,
      selectedColor: AppColors.primary.withOpacity(0.1),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.neutral.withOpacity(0.3),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 40,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: ResponsiveBuilder(
            mobile: Column(
              children: _filteredProjects.map((project) => Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: _buildProjectCard(context, project),
              )).toList(),
            ),
            desktop: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 32,
                childAspectRatio: 0.8,
              ),
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) => _buildProjectCard(context, _filteredProjects[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, PortfolioProject project) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image/Preview
          _buildProjectImage(context, project),
          
          // Project Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: project.type == ProjectType.mobile 
                        ? AppColors.primary.withOpacity(0.1)
                        : AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    project.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: project.type == ProjectType.mobile 
                          ? AppColors.primary 
                          : AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Project Title
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Client & Year
                Text(
                  '${project.client} • ${project.year}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Description
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 16),
                
                // Technologies
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: project.technologies.take(4).map((tech) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        fontSize: 11,
                      ),
                    ),
                  )).toList(),
                ),
                
                const SizedBox(height: 20),
                
                // View Details Button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton.secondary(
                    text: 'View Details',
                    onPressed: () => _showProjectDetails(context, project),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectImage(BuildContext context, PortfolioProject project) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            project.type == ProjectType.mobile 
                ? AppColors.primary.withOpacity(0.8)
                : AppColors.secondary.withOpacity(0.8),
            project.type == ProjectType.mobile 
                ? AppColors.secondary.withOpacity(0.6)
                : AppColors.accent.withOpacity(0.6),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // Device Mockup
          Center(
            child: Container(
              width: project.type == ProjectType.mobile ? 80 : 120,
              height: project.type == ProjectType.mobile ? 160 : 80,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(
                  project.type == ProjectType.mobile ? 16 : 8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                project.type == ProjectType.mobile 
                    ? Icons.phone_android 
                    : Icons.laptop_mac,
                size: 40,
                color: AppColors.primary,
              ),
            ),
          ),
          
          // Project Year Badge
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.textLight.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                project.year,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
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
        vertical: 80,
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
                'Apa Kata Klien Kami',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              ResponsiveBuilder(
                mobile: Column(
                  children: _projects.take(3).map((project) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _buildTestimonialCard(context, project),
                  )).toList(),
                ),
                desktop: Row(
                  children: _projects.take(3).map((project) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildTestimonialCard(context, project),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(BuildContext context, PortfolioProject project) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quote
          Icon(
            Icons.format_quote,
            size: 32,
            color: AppColors.primary.withOpacity(0.3),
          ),
          const SizedBox(height: 12),
          Text(
            project.testimonial,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          
          // Client Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary,
                child: Text(
                  project.clientName.split(' ').map((e) => e[0]).join(''),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.clientName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      project.clientPosition,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
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

  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 40,
      ),
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondary, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Tertarik dengan Karya Kami?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Mari diskusikan project digital impian Anda bersama kami',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textLight.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ResponsiveBuilder(
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton.large(
                    text: 'Mulai Project Anda',
                    backgroundColor: AppColors.textLight,
                    onPressed: () => context.go('/contact'),
                  ),
                  const SizedBox(height: 16),
                  CustomButton.secondary(
                    text: 'Lihat Layanan',
                    onPressed: () => context.go('/services'),
                  ),
                ],
              ),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton.large(
                    text: 'Mulai Project Anda',
                    backgroundColor: AppColors.textLight,
                    onPressed: () => context.go('/contact'),
                  ),
                  const SizedBox(width: 16),
                  CustomButton.secondary(
                    text: 'Lihat Layanan',
                    onPressed: () => context.go('/services'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Project Details Dialog
class ProjectDetailsDialog extends StatelessWidget {
  final PortfolioProject project;

  const ProjectDetailsDialog({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: ScreenSize.isMobile(context) 
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width * 0.6,
        height: ScreenSize.isMobile(context)
            ? MediaQuery.of(context).size.height * 0.8
            : MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    project.type == ProjectType.mobile 
                        ? AppColors.primary 
                        : AppColors.secondary,
                    project.type == ProjectType.mobile 
                        ? AppColors.secondary 
                        : AppColors.accent,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${project.client} • ${project.duration} • ${project.year}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textLight.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Text(
                      'Project Overview',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Features
                    Text(
                      'Key Features',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...project.features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
                    
                    const SizedBox(height: 24),
                    
                    // Technologies
                    Text(
                      'Technologies Used',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies.map((tech) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          tech,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Results
                    Text(
                      'Project Results',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...project.results.map((result) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.trending_up,
                            size: 16,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              result,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
            
            // Footer
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton.secondary(
                      text: 'Lihat Layanan',
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/services');
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton.primary(
                      text: 'Mulai Project',
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/contact');
                      },
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
}

// Data Models
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
  });
}