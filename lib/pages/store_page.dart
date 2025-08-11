import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> with TickerProviderStateMixin {
  String _selectedFilter = 'All';
  String _selectedType = 'All';
  String _sortBy = 'Popular';
  bool _isGridView = true;

  late AnimationController _heroAnimationController;
  late AnimationController _filterAnimationController;
  late Animation<double> _heroFadeAnimation;
  late Animation<Offset> _heroSlideAnimation;

  final List<String> _categories = [
    'All',
    'Business',
    'E-commerce',
    'Healthcare',
    'Education',
    'Food & Beverage',
  ];
  final List<String> _types = ['All', 'Ready App', 'Source Code'];
  final List<String> _sortOptions = [
    'Popular',
    'Price Low',
    'Price High',
    'Rating',
    'Newest',
  ];

  @override
  void initState() {
    super.initState();
    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _filterAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut),
    );
    _heroSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut),
    );

    _heroAnimationController.forward();
    _filterAnimationController.forward();
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  final List<StoreProduct> _products = [
    StoreProduct(
      id: '1',
      name: 'POS System Pro',
      category: 'Business',
      type: ProductType.readyApp,
      description:
          'Complete Point of Sale system with inventory management, payment gateway, and real-time analytics for modern retail businesses.',
      price: 3500000,
      originalPrice: 5000000,
      rating: 4.9,
      reviews: 127,
      image: 'assets/store/pos_system.png',
      features: [
        'Multi-platform support (iOS & Android)',
        'Real-time inventory tracking & alerts',
        'Multiple payment gateway integration',
        'Advanced sales analytics & reporting',
        'Receipt printer & barcode support',
        'Multi-store management system',
        '12 months premium support included',
        'Cloud backup & synchronization',
      ],
      technologies: ['Flutter', 'Firebase', 'Midtrans API', 'Cloud Functions'],
      demoUrl: 'https://demo.jostar.dev/pos',
      screenshots: ['pos_1.png', 'pos_2.png', 'pos_3.png'],
      isPopular: true,
      isFeatured: true,
      discount: 30,
      downloads: 1200,
      badge: 'BESTSELLER',
    ),
    StoreProduct(
      id: '2',
      name: 'E-Commerce Starter Kit',
      category: 'E-commerce',
      type: ProductType.sourceCode,
      description:
          'Complete e-commerce solution with advanced features, payment integration, and modern UI/UX design.',
      price: 2800000,
      originalPrice: 4000000,
      rating: 4.8,
      reviews: 89,
      image: 'assets/store/ecommerce_kit.png',
      features: [
        'Full Flutter source code access',
        'Admin panel with analytics',
        'Payment gateway integration',
        'Push notifications system',
        'Advanced order tracking',
        'Customer reviews & ratings',
        'SEO optimized structure',
        'Complete documentation',
      ],
      technologies: ['Flutter', 'Firebase', 'Stripe', 'FCM', 'Algolia'],
      demoUrl: 'https://demo.jostar.dev/ecommerce',
      screenshots: ['ecommerce_1.png', 'ecommerce_2.png'],
      isPopular: true,
      isFeatured: false,
      discount: 30,
      downloads: 950,
      badge: 'HOT',
    ),
    StoreProduct(
      id: '3',
      name: 'Smart Restaurant App',
      category: 'Food & Beverage',
      type: ProductType.readyApp,
      description:
          'Revolutionary restaurant management app with QR menu, table booking, and contactless ordering system.',
      price: 4200000,
      originalPrice: 6000000,
      rating: 4.7,
      reviews: 156,
      image: 'assets/store/restaurant_app.png',
      features: [
        'QR code digital menu system',
        'Table reservation & management',
        'Contactless ordering & payment',
        'Kitchen display system',
        'Customer loyalty program',
        'Real-time order tracking',
        'Multi-language support',
        'Analytics dashboard',
      ],
      technologies: ['Flutter', 'Firebase', 'QR Code', 'Maps API'],
      demoUrl: 'https://demo.jostar.dev/restaurant',
      screenshots: ['restaurant_1.png', 'restaurant_2.png'],
      isPopular: false,
      isFeatured: true,
      discount: 30,
      downloads: 734,
      badge: 'NEW',
    ),
    StoreProduct(
      id: '4',
      name: 'HealthCare Management',
      category: 'Healthcare',
      type: ProductType.sourceCode,
      description:
          'Comprehensive healthcare management system with telemedicine, appointment booking, and digital records.',
      price: 8500000,
      originalPrice: 12000000,
      rating: 4.9,
      reviews: 43,
      image: 'assets/store/healthcare_system.png',
      features: [
        'Patient management system',
        'Telemedicine integration',
        'Digital medical records',
        'Appointment scheduling',
        'Prescription management',
        'Laboratory integration',
        'Insurance billing system',
        'HIPAA compliant security',
      ],
      technologies: ['Flutter', 'Node.js', 'PostgreSQL', 'WebRTC', 'HL7'],
      demoUrl: 'https://demo.jostar.dev/healthcare',
      screenshots: ['healthcare_1.png', 'healthcare_2.png'],
      isPopular: false,
      isFeatured: true,
      discount: 29,
      downloads: 267,
      badge: 'PREMIUM',
    ),
    StoreProduct(
      id: '5',
      name: 'Learning Management System',
      category: 'Education',
      type: ProductType.readyApp,
      description:
          'Advanced LMS with video streaming, interactive content, assessments, and progress analytics.',
      price: 6800000,
      originalPrice: 9500000,
      rating: 4.6,
      reviews: 78,
      image: 'assets/store/learning_platform.png',
      features: [
        'HD video streaming platform',
        'Interactive course builder',
        'Advanced quiz system',
        'Assignment management',
        'Progress analytics',
        'Discussion forums',
        'Certificate generation',
        'Mobile learning support',
      ],
      technologies: ['Flutter', 'Firebase', 'Vimeo API', 'ML Kit'],
      demoUrl: 'https://demo.jostar.dev/learning',
      screenshots: ['learning_1.png', 'learning_2.png'],
      isPopular: false,
      isFeatured: false,
      discount: 28,
      downloads: 445,
      badge: '',
    ),
    StoreProduct(
      id: '6',
      name: 'Inventory Pro Suite',
      category: 'Business',
      type: ProductType.sourceCode,
      description:
          'Enterprise-grade inventory management with AI forecasting, automated ordering, and advanced analytics.',
      price: 7200000,
      originalPrice: 10000000,
      rating: 4.8,
      reviews: 92,
      image: 'assets/store/inventory_pro.png',
      features: [
        'AI-powered demand forecasting',
        'Automated stock reordering',
        'Multi-warehouse management',
        'Supplier relationship tools',
        'Advanced analytics dashboard',
        'Barcode & RFID support',
        'API integrations',
        'Custom reporting tools',
      ],
      technologies: ['Flutter', 'Node.js', 'MongoDB', 'TensorFlow', 'APIs'],
      demoUrl: 'https://demo.jostar.dev/inventory',
      screenshots: ['inventory_1.png', 'inventory_2.png'],
      isPopular: true,
      isFeatured: false,
      discount: 28,
      downloads: 623,
      badge: 'AI-POWERED',
    ),
  ];

  List<StoreProduct> get _filteredProducts {
    var filtered =
        _products.where((product) {
          final categoryMatch =
              _selectedFilter == 'All' || product.category == _selectedFilter;
          final typeMatch =
              _selectedType == 'All' ||
              (_selectedType == 'Ready App' &&
                  product.type == ProductType.readyApp) ||
              (_selectedType == 'Source Code' &&
                  product.type == ProductType.sourceCode);
          return categoryMatch && typeMatch;
        }).toList();

    // Sort products
    switch (_sortBy) {
      case 'Price Low':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price High':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        filtered.sort((a, b) => b.downloads.compareTo(a.downloads));
        break;
      default: // Popular
        filtered.sort((a, b) => b.downloads.compareTo(a.downloads));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildModernAppBar(),
          SliverToBoxAdapter(child: _buildEnhancedHero()),
          SliverToBoxAdapter(child: _buildSmartFilters()),
          SliverToBoxAdapter(child: _buildFeaturedProducts()),
          SliverToBoxAdapter(child: _buildProductsSection()),
          SliverToBoxAdapter(child: _buildAdvancedFeatures()),
          SliverToBoxAdapter(child: _buildTestimonialsCarousel()),
          SliverToBoxAdapter(child: _buildPremiumCTA()),
        ],
      ),
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.surface,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.surface, AppColors.background],
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _isGridView = true),
                icon: Icon(
                  Icons.grid_view,
                  color:
                      _isGridView ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _isGridView = false),
                icon: Icon(
                  Icons.view_list,
                  color:
                      !_isGridView
                          ? AppColors.primary
                          : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedHero() {
    return AnimatedBuilder(
      animation: _heroAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _heroFadeAnimation,
          child: SlideTransition(
            position: _heroSlideAnimation,
            child: Container(
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
                    AppColors.accent.withOpacity(0.05),
                    AppColors.surface,
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: ScreenSize.getMaxContentWidth(context),
                  ),
                  child: ResponsiveBuilder(
                    mobile: _buildMobileHero(),
                    desktop: _buildDesktopHero(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      children: [
        Expanded(flex: 6, child: _buildHeroContent()),
        const SizedBox(width: 80),
        Expanded(flex: 4, child: _buildHeroVisual()),
      ],
    );
  }

  Widget _buildMobileHero() {
    return Column(
      children: [
        _buildHeroContent(),
        const SizedBox(height: 60),
        _buildHeroVisual(),
      ],
    );
  }

  Widget _buildHeroContent() {
    return Column(
      crossAxisAlignment:
          ScreenSize.isMobile(context)
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
            border: Border.all(color: AppColors.accent.withOpacity(0.2)),
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
                'Ready-to-Deploy Solutions',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Main Heading
        RichText(
          textAlign:
              ScreenSize.isMobile(context) ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: ScreenSize.isMobile(context) ? 36 : 56,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
            children: [
              const TextSpan(
                text: 'Premium Apps\n',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              TextSpan(
                text: 'Ready to Launch',
                style: TextStyle(
                  foreground:
                      Paint()
                        ..shader = const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Description
        Text(
          'Skip months of development. Get professional, battle-tested applications '
          'that you can customize and deploy immediately.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
          textAlign:
              ScreenSize.isMobile(context) ? TextAlign.center : TextAlign.left,
        ),

        const SizedBox(height: 40),

        // Action Buttons
        ResponsiveBuilder(
          mobile: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPrimaryButton(),
              const SizedBox(height: 16),
              _buildSecondaryButton(),
            ],
          ),
          desktop: Row(
            mainAxisAlignment:
                ScreenSize.isMobile(context)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
            children: [
              _buildPrimaryButton(),
              const SizedBox(width: 20),
              _buildSecondaryButton(),
            ],
          ),
        ),

        const SizedBox(height: 50),

        // Stats
        _buildHeroStats(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.explore, color: AppColors.textLight),
            const SizedBox(width: 12),
            Text(
              'Browse Products',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return OutlinedButton(
      onPressed: () => context.go('/contact'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        side: const BorderSide(color: AppColors.primary, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.chat_bubble_outline),
          const SizedBox(width: 12),
          Text(
            'Custom Development',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStats() {
    final stats = [
      {'number': '20+', 'label': 'Ready Apps', 'icon': Icons.apps},
      {'number': '50+', 'label': 'Source Codes', 'icon': Icons.code},
      {'number': '5000+', 'label': 'Downloads', 'icon': Icons.download},
      {'number': '24/7', 'label': 'Support', 'icon': Icons.support_agent},
    ];

    return ResponsiveBuilder(
      mobile: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) => _buildStatCard(stats[index]),
      ),
      desktop: Row(
        mainAxisAlignment:
            ScreenSize.isMobile(context)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        children:
            stats
                .map(
                  (stat) => Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: _buildStatCard(stat),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(stat['icon'], color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat['number'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                stat['label'],
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroVisual() {
    return Container(
      height: ScreenSize.isMobile(context) ? 300 : 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.accent.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Floating Elements
          _buildFloatingElement(
            top: 40,
            left: 40,
            icon: Icons.shopping_cart,
            color: AppColors.accent,
            delay: 0.2,
            bottom: 0,
            right: 0,
          ),
          _buildFloatingElement(
            top: 80,
            right: 50,
            icon: Icons.restaurant,
            color: AppColors.secondary,
            delay: 0.4,
            bottom: 0,
            left: 0,
          ),
          _buildFloatingElement(
            bottom: 100,
            left: 60,
            icon: Icons.local_hospital,
            color: AppColors.success,
            delay: 0.6,
                  top: 0,
            right: 0,
          ),
          _buildFloatingElement(
            bottom: 50,
            right: 40,
            icon: Icons.school,
            color: AppColors.primary,
            delay: 0.8,
                  top: 0,
            left: 0,
          ),

          // Center Device
          Center(
            child: Container(
              width: 140,
              height: 240,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neutral.withOpacity(0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Screen
                  Positioned(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.storefront,
                        size: 40,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElement({
    required double? top,
    required double? bottom,
    required double? left,
    required double? right,
    required IconData icon,
    required Color color,
    required double delay,
  }) {
    return AnimatedBuilder(
      animation: _heroAnimationController,
      builder: (context, child) {
        final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _heroAnimationController,
            curve: Interval(delay, 1.0, curve: Curves.elasticOut),
          ),
        );

        return Positioned(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: ScaleTransition(
            scale: animation,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 28),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmartFilters() {
    return AnimatedBuilder(
      animation: _filterAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _filterAnimationController,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getResponsivePadding(context),
              vertical: 40,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.neutral.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: ScreenSize.getMaxContentWidth(context),
                ),
                child: ResponsiveBuilder(
                  mobile: _buildMobileFilters(),
                  desktop: _buildDesktopFilters(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopFilters() {
    return Row(
      children: [
        // Categories
        Expanded(
          flex: 3,
          child: _buildFilterGroup('Category', _categories, _selectedFilter, (
            value,
          ) {
            setState(() => _selectedFilter = value);
          }),
        ),
        const SizedBox(width: 32),

        // Type
        Expanded(
          flex: 2,
          child: _buildFilterGroup('Type', _types, _selectedType, (value) {
            setState(() => _selectedType = value);
          }),
        ),
        const SizedBox(width: 32),

        // Sort
        Expanded(flex: 2, child: _buildSortDropdown()),
      ],
    );
  }

  Widget _buildMobileFilters() {
    return Column(
      children: [
        _buildFilterGroup('Category', _categories, _selectedFilter, (value) {
          setState(() => _selectedFilter = value);
        }),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildFilterGroup('Type', _types, _selectedType, (value) {
                setState(() => _selectedType = value);
              }),
            ),
            const SizedBox(width: 16),
            Expanded(child: _buildSortDropdown()),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterGroup(
    String label,
    List<String> items,
    String selected,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildModernFilterChip(
                          item,
                          selected == item,
                          () => onChanged(item),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildModernFilterChip(
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected
                    ? AppColors.primary
                    : AppColors.neutral.withOpacity(0.3),
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isSelected ? AppColors.textLight : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _sortBy,
              isExpanded: true,
              items:
                  _sortOptions
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ),
                      )
                      .toList(),
              onChanged: (value) => setState(() => _sortBy = value!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    final featuredProducts = _products.where((p) => p.isFeatured).toList();

    if (featuredProducts.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 60,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.accent, AppColors.primary],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Featured Products',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredProducts.length,
                  itemBuilder:
                      (context, index) => Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 20),
                        child: _buildFeaturedProductCard(
                          featuredProducts[index],
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProductCard(StoreProduct product) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            product.type == ProductType.readyApp
                ? AppColors.accent.withOpacity(0.1)
                : AppColors.primary.withOpacity(0.1),
            AppColors.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (product.type == ProductType.readyApp
                  ? AppColors.accent
                  : AppColors.primary)
              .withOpacity(0.2),
        ),
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
          // Header with badge
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  product.type == ProductType.readyApp
                      ? AppColors.accent
                      : AppColors.primary,
                  product.type == ProductType.readyApp
                      ? AppColors.primary
                      : AppColors.secondary,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    product.type == ProductType.readyApp
                        ? Icons.smartphone
                        : Icons.code,
                    size: 40,
                    color: AppColors.textLight,
                  ),
                ),
                if (product.badge.isNotEmpty)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.badge,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'Rp ${_formatPrice(product.price)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${product.rating}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection() {
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Products (${_filteredProducts.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _isGridView ? _buildProductsGrid() : _buildProductsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    return ResponsiveBuilder(
      mobile: Column(
        children:
            _filteredProducts
                .map(
                  (product) => Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: _buildEnhancedProductCard(product),
                  ),
                )
                .toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.75,
        ),
        itemCount: _filteredProducts.length,
        itemBuilder:
            (context, index) =>
                _buildEnhancedProductCard(_filteredProducts[index]),
      ),
    );
  }

  Widget _buildProductsList() {
    return Column(
      children:
          _filteredProducts
              .map(
                (product) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: _buildProductListItem(product),
                ),
              )
              .toList(),
    );
  }

  Widget _buildEnhancedProductCard(StoreProduct product) {
    return MouseRegion(
      onEnter: (_) {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral.withOpacity(0.08),
              blurRadius: 25,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            _buildProductImage(product),

            // Product Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category and Type
                    Row(
                      children: [
                        _buildCategoryBadge(product),
                        const Spacer(),
                        if (product.badge.isNotEmpty)
                          _buildProductBadge(product.badge),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Product Name
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Description
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 16),

                    // Rating and Downloads
                    Row(
                      children: [
                        _buildRating(product.rating),
                        const Spacer(),
                        Text(
                          '${product.downloads}+ downloads',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Price
                    _buildPriceSection(product),

                    const SizedBox(height: 16),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _showDemo(product),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Demo'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showProductDetails(product),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Buy Now'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(StoreProduct product) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            product.type == ProductType.readyApp
                ? AppColors.accent.withOpacity(0.8)
                : AppColors.primary.withOpacity(0.8),
            product.type == ProductType.readyApp
                ? AppColors.primary.withOpacity(0.6)
                : AppColors.secondary.withOpacity(0.6),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // Icon
          Center(
            child: Icon(
              product.type == ProductType.readyApp
                  ? Icons.smartphone
                  : Icons.code,
              size: 50,
              color: AppColors.textLight,
            ),
          ),

          // Discount Badge
          if (product.discount > 0)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '-${product.discount}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge(StoreProduct product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            product.type == ProductType.readyApp
                ? AppColors.accent.withOpacity(0.1)
                : AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        product.category,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color:
              product.type == ProductType.readyApp
                  ? AppColors.accent
                  : AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProductBadge(String badge) {
    Color getBadgeColor(String badge) {
      switch (badge.toLowerCase()) {
        case 'bestseller':
          return AppColors.accent;
        case 'hot':
          return AppColors.error;
        case 'new':
          return AppColors.success;
        case 'premium':
          return AppColors.primary;
        default:
          return AppColors.secondary;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: getBadgeColor(badge),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        badge,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          5,
          (index) => Icon(
            Icons.star,
            size: 14,
            color:
                index < rating.floor()
                    ? AppColors.accent
                    : AppColors.neutral.withOpacity(0.3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildPriceSection(StoreProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.originalPrice > product.price)
          Text(
            'Rp ${_formatPrice(product.originalPrice)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: AppColors.textSecondary,
            ),
          ),
        Text(
          'Rp ${_formatPrice(product.price)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProductListItem(StoreProduct product) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  product.type == ProductType.readyApp
                      ? AppColors.accent
                      : AppColors.primary,
                  product.type == ProductType.readyApp
                      ? AppColors.primary
                      : AppColors.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              product.type == ProductType.readyApp
                  ? Icons.smartphone
                  : Icons.code,
              color: AppColors.textLight,
              size: 32,
            ),
          ),

          const SizedBox(width: 16),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (product.badge.isNotEmpty)
                      _buildProductBadge(product.badge),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildRating(product.rating),
                    const SizedBox(width: 16),
                    Text(
                      '${product.downloads}+ downloads',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Price and Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildPriceSection(product),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () => _showDemo(product),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text('Demo'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _showProductDetails(product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text('Buy'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedFeatures() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, AppColors.surface],
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
                'Why Choose Our Products?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Built with industry best practices and modern technologies',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildFeaturesGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      AdvancedFeature(
        icon: Icons.rocket_launch,
        title: 'Production Ready',
        description:
            'Thoroughly tested and optimized for production deployment',
        color: AppColors.success,
      ),
      AdvancedFeature(
        icon: Icons.security,
        title: 'Secure by Design',
        description: 'Built with security best practices and encryption',
        color: AppColors.primary,
      ),
      AdvancedFeature(
        icon: Icons.speed,
        title: 'High Performance',
        description: 'Optimized for speed and smooth user experience',
        color: AppColors.accent,
      ),
      AdvancedFeature(
        icon: Icons.update,
        title: 'Lifetime Updates',
        description:
            'Free updates and bug fixes for the lifetime of the product',
        color: AppColors.secondary,
      ),
      AdvancedFeature(
        icon: Icons.support_agent,
        title: 'Premium Support',
        description: '24/7 support and consultation for 12 months',
        color: AppColors.success,
      ),
      AdvancedFeature(
        icon: Icons.code,
        title: 'Clean Code',
        description: 'Well-documented, maintainable, and scalable codebase',
        color: AppColors.primary,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children:
            features
                .map(
                  (feature) => Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: _buildFeatureCard(feature),
                  ),
                )
                .toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.1,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) => _buildFeatureCard(features[index]),
      ),
    );
  }

  Widget _buildFeatureCard(AdvancedFeature feature) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: feature.color.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [feature.color, feature.color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(feature.icon, color: AppColors.textLight, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            feature.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsCarousel() {
    final testimonials = [
      StoreTestimonial(
        name: 'Budi Santoso',
        position: 'CEO, TechStartup',
        message:
            'POS System yang kami beli menghemat waktu development 6 bulan dan budget 80%. Kualitasnya luar biasa!',
        rating: 5,
        productUsed: 'POS System Pro',
      ),
      StoreTestimonial(
        name: 'Sarah Wijaya',
        position: 'Founder, OnlineShop',
        message:
            'E-commerce kit yang sangat lengkap. Source code-nya bersih dan mudah dikustomisasi sesuai kebutuhan.',
        rating: 5,
        productUsed: 'E-Commerce Starter Kit',
      ),
      StoreTestimonial(
        name: 'Dr. Ahmad',
        position: 'Medical Director',
        message:
            'Healthcare management system membantu digitalisasi klinik kami dengan sempurna. Highly recommended!',
        rating: 5,
        productUsed: 'HealthCare Management',
      ),
    ];

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
                'What Our Customers Say',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: testimonials.length,
                  itemBuilder:
                      (context, index) => Container(
                        width: 350,
                        margin: const EdgeInsets.only(right: 20),
                        child: _buildTestimonialCard(testimonials[index]),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(StoreTestimonial testimonial) {
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
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                size: 16,
                color:
                    index < testimonial.rating
                        ? AppColors.accent
                        : AppColors.neutral.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              '"${testimonial.message}"',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary,
                child: Text(
                  testimonial.name.split(' ').map((e) => e[0]).join(''),
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
                      testimonial.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      testimonial.position,
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

  Widget _buildPremiumCTA() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.getResponsivePadding(context),
        vertical: 40,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.accent],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Icon(Icons.diamond, size: 60, color: AppColors.textLight),
            const SizedBox(height: 24),
            Text(
              'Need Something Custom?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textLight,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Can\'t find exactly what you need? Let us build a custom solution tailored specifically for your business requirements.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textLight.withOpacity(0.9),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ResponsiveBuilder(
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCTAButton('Get Custom Quote', true),
                  const SizedBox(height: 16),
                  _buildCTAButton('View Services', false),
                ],
              ),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCTAButton('Get Custom Quote', true),
                  const SizedBox(width: 20),
                  _buildCTAButton('View Services', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTAButton(String text, bool isPrimary) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.textLight : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border:
            isPrimary ? null : Border.all(color: AppColors.textLight, width: 2),
      ),
      child: ElevatedButton(
        onPressed: () => context.go('/contact'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isPrimary ? AppColors.primary : AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void _showDemo(StoreProduct product) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Demo: ${product.name}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Experience the power of ${product.name}'),
                const SizedBox(height: 16),
                Text('Demo URL: ${product.demoUrl}'),
                const SizedBox(height: 16),
                Text('Login credentials will be provided after purchase.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Open demo URL in real implementation
                },
                child: const Text('Open Demo'),
              ),
            ],
          ),
    );
  }

  void _showProductDetails(StoreProduct product) {
    showDialog(
      context: context,
      builder: (context) => ProductDetailsDialog(product: product),
    );
  }
}

// Enhanced Data Models
enum ProductType { readyApp, sourceCode }

class StoreProduct {
  final String id;
  final String name;
  final String category;
  final ProductType type;
  final String description;
  final int price;
  final int originalPrice;
  final double rating;
  final int reviews;
  final String image;
  final List<String> features;
  final List<String> technologies;
  final String demoUrl;
  final List<String> screenshots;
  final bool isPopular;
  final bool isFeatured;
  final int discount;
  final int downloads;
  final String badge;

  StoreProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.features,
    required this.technologies,
    required this.demoUrl,
    required this.screenshots,
    required this.isPopular,
    required this.isFeatured,
    required this.discount,
    required this.downloads,
    required this.badge,
  });
}

class AdvancedFeature {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  AdvancedFeature({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class StoreTestimonial {
  final String name;
  final String position;
  final String message;
  final int rating;
  final String productUsed;

  StoreTestimonial({
    required this.name,
    required this.position,
    required this.message,
    required this.rating,
    required this.productUsed,
  });
}

// Product Details Dialog
class ProductDetailsDialog extends StatelessWidget {
  final StoreProduct product;

  const ProductDetailsDialog({Key? key, required this.product})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width:
            ScreenSize.isMobile(context)
                ? MediaQuery.of(context).size.width * 0.95
                : MediaQuery.of(context).size.width * 0.7,
        height:
            ScreenSize.isMobile(context)
                ? MediaQuery.of(context).size.height * 0.9
                : MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    product.type == ProductType.readyApp
                        ? AppColors.accent
                        : AppColors.primary,
                    product.type == ProductType.readyApp
                        ? AppColors.primary
                        : AppColors.secondary,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    product.type == ProductType.readyApp
                        ? Icons.smartphone
                        : Icons.code,
                    color: AppColors.textLight,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product.category} • ${product.downloads}+ downloads',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
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
                    // Price and Rating
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.originalPrice > product.price)
                              Text(
                                'Rp ${_formatPrice(product.originalPrice)}',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            Text(
                              'Rp ${_formatPrice(product.price)}',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            ...List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                size: 20,
                                color:
                                    index < product.rating.floor()
                                        ? AppColors.accent
                                        : AppColors.neutral.withOpacity(0.3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${product.rating} (${product.reviews} reviews)',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Description
                    Text(
                      'Product Description',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),

                    const SizedBox(height: 24),

                    // Features
                    Text(
                      'What\'s Included',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...product.features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.success,
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
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Technologies
                    Text(
                      'Technologies Used',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          product.technologies
                              .map(
                                (tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    tech,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Footer Actions
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('View Demo'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/contact');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Buy Now'),
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

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
