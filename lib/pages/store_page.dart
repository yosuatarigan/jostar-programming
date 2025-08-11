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

class _StorePageState extends State<StorePage> {
  String _selectedCategory = 'All';
  String _selectedType = 'All';
  
  final List<String> _categories = ['All', 'Business', 'E-commerce', 'Healthcare', 'Education', 'Food & Beverage'];
  final List<String> _types = ['All', 'Ready App', 'Source Code'];
  
  final List<StoreProduct> _products = [
    StoreProduct(
      id: '1',
      name: 'POS System Pro',
      category: 'Business',
      type: ProductType.readyApp,
      description: 'Sistem Point of Sale lengkap untuk retail dan restoran dengan fitur inventory management, payment gateway, dan reporting.',
      price: 3500000,
      originalPrice: 5000000,
      rating: 4.8,
      reviews: 45,
      imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800&h=600&fit=crop&auto=format',
      features: [
        'Multi-platform (iOS & Android)',
        'Real-time inventory tracking',
        'Multiple payment methods',
        'Sales analytics dashboard',
        'Receipt printer support',
        'Multi-store management',
        '6 months free support',
      ],
      technologies: ['Flutter', 'Firebase', 'Midtrans API'],
      demoUrl: 'https://demo.jostar.dev/pos',
      screenshots: [
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&h=600&fit=crop',
      ],
      isPopular: true,
      discount: 30,
    ),
    StoreProduct(
      id: '2',
      name: 'E-Commerce Starter Kit',
      category: 'E-commerce',
      type: ProductType.sourceCode,
      description: 'Template aplikasi e-commerce lengkap dengan source code untuk memulai bisnis online Anda dengan cepat.',
      price: 2500000,
      originalPrice: 3500000,
      rating: 4.9,
      reviews: 62,
      imageUrl: 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=800&h=600&fit=crop&auto=format',
      features: [
        'Complete Flutter source code',
        'Admin panel included',
        'Payment gateway integration',
        'Push notifications',
        'Order tracking system',
        'Customer reviews & ratings',
        'Documentation included',
      ],
      technologies: ['Flutter', 'Firebase', 'Stripe', 'FCM'],
      demoUrl: 'https://demo.jostar.dev/ecommerce',
      screenshots: [
        'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1556742111-f327e8bb7cd4?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=600&fit=crop',
      ],
      isPopular: true,
      discount: 28,
    ),
    StoreProduct(
      id: '3',
      name: 'Restaurant Ordering App',
      category: 'Food & Beverage',
      type: ProductType.readyApp,
      description: 'Aplikasi pemesanan makanan untuk restoran dengan fitur menu digital, table booking, dan payment integration.',
      price: 4000000,
      originalPrice: 5500000,
      rating: 4.7,
      reviews: 28,
      imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&h=600&fit=crop&auto=format',
      features: [
        'Digital menu with photos',
        'Table reservation system',
        'Real-time order tracking',
        'Multiple payment options',
        'Customer loyalty program',
        'Kitchen display system',
        '3 months free support',
      ],
      technologies: ['Flutter', 'Firebase', 'Google Maps'],
      demoUrl: 'https://demo.jostar.dev/restaurant',
      screenshots: [
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=600&fit=crop',
      ],
      isPopular: false,
      discount: 27,
    ),
    StoreProduct(
      id: '4',
      name: 'Healthcare Management System',
      category: 'Healthcare',
      type: ProductType.sourceCode,
      description: 'Source code sistem manajemen klinik dan rumah sakit dengan fitur appointment, medical records, dan telemedicine.',
      price: 8000000,
      originalPrice: 12000000,
      rating: 4.9,
      reviews: 15,
      imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=800&h=600&fit=crop&auto=format',
      features: [
        'Patient management system',
        'Doctor appointment booking',
        'Digital medical records',
        'Prescription management',
        'Video consultation support',
        'Laboratory integration',
        'Complete documentation',
      ],
      technologies: ['Flutter', 'Node.js', 'PostgreSQL', 'WebRTC'],
      demoUrl: 'https://demo.jostar.dev/healthcare',
      screenshots: [
        'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1584982751601-97dcc096659c?w=400&h=600&fit=crop',
      ],
      isPopular: false,
      discount: 33,
    ),
    StoreProduct(
      id: '5',
      name: 'Online Learning Platform',
      category: 'Education',
      type: ProductType.readyApp,
      description: 'Platform pembelajaran online dengan fitur video streaming, quiz, assignment, dan progress tracking untuk institusi pendidikan.',
      price: 6000000,
      originalPrice: 8000000,
      rating: 4.6,
      reviews: 22,
      imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=600&fit=crop&auto=format',
      features: [
        'Video course streaming',
        'Interactive quizzes',
        'Assignment submission',
        'Progress tracking',
        'Discussion forums',
        'Certificate generation',
        '4 months free support',
      ],
      technologies: ['Flutter', 'Firebase', 'Vimeo API'],
      demoUrl: 'https://demo.jostar.dev/learning',
      screenshots: [
        'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=600&fit=crop',
      ],
      isPopular: false,
      discount: 25,
    ),
    StoreProduct(
      id: '6',
      name: 'Inventory Management Pro',
      category: 'Business',
      type: ProductType.sourceCode,
      description: 'Source code sistem manajemen inventory yang powerful dengan fitur forecasting, automated ordering, dan multi-warehouse support.',
      price: 5500000,
      originalPrice: 7500000,
      rating: 4.8,
      reviews: 33,
      imageUrl: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&h=600&fit=crop&auto=format',
      features: [
        'Multi-warehouse management',
        'Automated stock alerts',
        'Demand forecasting',
        'Supplier management',
        'Barcode scanning',
        'Analytics dashboard',
        'Full source code access',
      ],
      technologies: ['Flutter', 'Node.js', 'MongoDB', 'Chart.js'],
      demoUrl: 'https://demo.jostar.dev/inventory',
      screenshots: [
        'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=400&h=600&fit=crop',
        'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&h=600&fit=crop',
      ],
      isPopular: false,
      discount: 26,
    ),
  ];

  List<StoreProduct> get _filteredProducts {
    return _products.where((product) {
      final categoryMatch = _selectedCategory == 'All' || product.category == _selectedCategory;
      final typeMatch = _selectedType == 'All' || 
          (_selectedType == 'Ready App' && product.type == ProductType.readyApp) ||
          (_selectedType == 'Source Code' && product.type == ProductType.sourceCode);
      return categoryMatch && typeMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildFilterSection(context),
          _buildProductsGrid(context),
          _buildFeaturesSection(context),
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
            AppColors.accent.withOpacity(0.05),
            AppColors.primary.withOpacity(0.1),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: ResponsiveBuilder(
            mobile: _buildMobileHero(context),
            desktop: _buildDesktopHero(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopHero(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildHeroContent(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildHeroVisual(context),
        ),
      ],
    );
  }

  Widget _buildMobileHero(BuildContext context) {
    return Column(
      children: [
        _buildHeroContent(context),
        const SizedBox(height: 40),
        _buildHeroVisual(context),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context) {
    return Column(
      crossAxisAlignment: ScreenSize.isMobile(context) 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '🛍️ READY-TO-USE SOLUTIONS',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Aplikasi Bisnis Siap Pakai',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: ScreenSize.isMobile(context) ? 32 : 48,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Text(
          'Dapatkan aplikasi berkualitas tinggi yang sudah teruji untuk berbagai kebutuhan bisnis Anda. Hemat waktu dan biaya pengembangan!',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        const SizedBox(height: 32),
        _buildHeroStats(context),
      ],
    );
  }

  Widget _buildHeroStats(BuildContext context) {
    final stats = [
      {'number': '20+', 'label': 'Ready Apps'},
      {'number': '50+', 'label': 'Source Codes'},
      {'number': '24/7', 'label': 'Support'},
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: stats.map((stat) => _buildStatItem(context, stat)).toList(),
      ),
      desktop: Row(
        mainAxisAlignment: ScreenSize.isMobile(context) 
            ? MainAxisAlignment.center 
            : MainAxisAlignment.start,
        children: stats.map((stat) => Padding(
          padding: const EdgeInsets.only(right: 40),
          child: _buildStatItem(context, stat),
        )).toList(),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, Map<String, String> stat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: ScreenSize.isMobile(context) 
            ? CrossAxisAlignment.center 
            : CrossAxisAlignment.start,
        children: [
          Text(
            stat['number']!,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.accent,
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

  Widget _buildHeroVisual(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=500&h=300&fit=crop&auto=format'
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.primary.withOpacity(0.7),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Center Icon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.store,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
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
      color: AppColors.background,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getMaxContentWidth(context),
          ),
          child: ResponsiveBuilder(
            mobile: _buildMobileFilters(context),
            desktop: _buildDesktopFilters(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopFilters(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                'Category: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 16),
              ..._categories.map((category) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildFilterChip(category, _selectedCategory, (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }),
              )),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Row(
            children: [
              Text(
                'Type: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 16),
              ..._types.map((type) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildFilterChip(type, _selectedType, (value) {
                  setState(() {
                    _selectedType = value;
                  });
                }),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFilters(BuildContext context) {
    return Column(
      children: [
        // Category Filter
        Text(
          'Filter by Category',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((category) => _buildFilterChip(category, _selectedCategory, (value) {
            setState(() {
              _selectedCategory = value;
            });
          })).toList(),
        ),
        
        const SizedBox(height: 24),
        
        // Type Filter
        Text(
          'Filter by Type',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _types.map((type) => _buildFilterChip(type, _selectedType, (value) {
            setState(() {
              _selectedType = value;
            });
          })).toList(),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String filter, String selectedFilter, Function(String) onSelected) {
    final isSelected = selectedFilter == filter;
    return FilterChip(
      label: Text(filter),
      selected: isSelected,
      onSelected: (selected) => onSelected(filter),
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.accent.withOpacity(0.1),
      checkmarkColor: AppColors.accent,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.accent : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.accent : AppColors.neutral.withOpacity(0.3),
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context) {
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
                    'Available Products (${_filteredProducts.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DropdownButton<String>(
                    value: 'Popular',
                    items: ['Popular', 'Price Low', 'Price High', 'Rating'].map((sort) => 
                      DropdownMenuItem(value: sort, child: Text(sort))
                    ).toList(),
                    onChanged: (value) {
                      // Implement sorting logic
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ResponsiveBuilder(
                mobile: Column(
                  children: _filteredProducts.map((product) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _buildProductCard(context, product),
                  )).toList(),
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
                  itemBuilder: (context, index) => _buildProductCard(context, _filteredProducts[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, StoreProduct product) {
    return Container(
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
          // Product Image
          _buildProductImage(context, product),
          
          // Product Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: product.type == ProductType.readyApp 
                          ? AppColors.accent.withOpacity(0.1)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: product.type == ProductType.readyApp 
                            ? AppColors.accent 
                            : AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) => Icon(
                        Icons.star,
                        size: 14,
                        color: index < product.rating.floor() 
                            ? AppColors.accent 
                            : AppColors.neutral.withOpacity(0.3),
                      )),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating} (${product.reviews})',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (product.originalPrice > product.price)
                        Text(
                          'Rp ${_formatPrice(product.originalPrice)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      if (product.originalPrice > product.price)
                        const SizedBox(width: 8),
                      Text(
                        'Rp ${_formatPrice(product.price)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton.secondary(
                          text: product.type == ProductType.readyApp ? 'Demo' : 'Preview',
                          icon: Icon(
                            product.type == ProductType.readyApp ? Icons.play_circle_outline : Icons.visibility,
                            size: 16,
                          ),
                          onPressed: () => _showDemo(context, product),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomButton.primary(
                          text: product.type == ProductType.readyApp ? 'Buy' : 'Download',
                          icon: Icon(
                            product.type == ProductType.readyApp ? Icons.shopping_cart : Icons.download,
                            size: 16,
                            color: AppColors.textLight,
                          ),
                          onPressed: () => _showProductDetails(context, product),
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

  Widget _buildProductImage(BuildContext context, StoreProduct product) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        product.type == ProductType.readyApp 
                            ? AppColors.accent.withOpacity(0.3)
                            : AppColors.primary.withOpacity(0.3),
                        product.type == ProductType.readyApp 
                            ? AppColors.primary.withOpacity(0.2)
                            : AppColors.secondary.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
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
                  ),
                  child: Center(
                    child: Icon(
                      product.type == ProductType.readyApp 
                          ? Icons.smartphone 
                          : Icons.code,
                      size: 60,
                      color: AppColors.textLight,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Overlay gradient for better text readability
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.4),
              ],
            ),
          ),
        ),
        
        // Type Badge (Top Left)
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: product.type == ProductType.readyApp 
                  ? AppColors.accent 
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              product.type == ProductType.readyApp ? 'READY APP' : 'SOURCE CODE',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textLight,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        
        // Popular Badge (Top Right)
        if (product.isPopular)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'POPULAR',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        
        // Discount Badge (Bottom Right)
        if (product.discount > 0)
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_offer,
                    size: 12,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '-${product.discount}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        
        // Download/Demo Badge (Bottom Left) 
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  product.type == ProductType.readyApp 
                      ? Icons.play_circle_outline 
                      : Icons.download,
                  size: 12,
                  color: AppColors.textLight,
                ),
                const SizedBox(width: 4),
                Text(
                  product.type == ProductType.readyApp ? 'DEMO' : 'DOWNLOAD',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void _showDemo(BuildContext context, StoreProduct product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              product.type == ProductType.readyApp ? Icons.play_circle_outline : Icons.visibility,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(product.type == ProductType.readyApp ? 'Demo ${product.name}' : 'Preview ${product.name}'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.type == ProductType.readyApp) ...[
              Text(
                'Demo URL:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neutral.withOpacity(0.3)),
                ),
                child: Text(
                  product.demoUrl,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Klik "Open Demo" untuk melihat aplikasi yang sedang berjalan'),
            ] else ...[
              Text('Source Code Preview'),
              const SizedBox(height: 8),
              Text('Preview fitur dan dokumentasi source code sebelum membeli.'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Included:',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...product.features.take(3).map((feature) => Text('• $feature')),
                    if (product.features.length > 3)
                      Text('• And ${product.features.length - 3} more features...'),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          CustomButton.primary(
            text: product.type == ProductType.readyApp ? 'Open Demo' : 'View Details',
            icon: Icon(
              product.type == ProductType.readyApp ? Icons.open_in_new : Icons.info_outline,
              size: 16,
              color: AppColors.textLight,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (product.type == ProductType.readyApp) {
                // Open demo URL - in real app, use url_launcher
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening demo: ${product.demoUrl}'),
                    backgroundColor: AppColors.success,
                  ),
                );
              } else {
                _showProductDetails(context, product);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showProductDetails(BuildContext context, StoreProduct product) {
    showDialog(
      context: context,
      builder: (context) => ProductDetailsDialog(product: product),
    );
  }

  // Continue with the rest of the methods...
  Widget _buildFeaturesSection(BuildContext context) {
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
                'Mengapa Pilih Produk Kami?',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildFeaturesList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final features = [
      StoreFeature(
        icon: Icons.rocket_launch,
        title: 'Siap Pakai',
        description: 'Aplikasi sudah siap deploy dan digunakan langsung',
        color: AppColors.accent,
      ),
      StoreFeature(
        icon: Icons.code,
        title: 'Source Code Lengkap',
        description: 'Akses penuh ke source code untuk customization',
        color: AppColors.primary,
      ),
      StoreFeature(
        icon: Icons.support_agent,
        title: 'Support Premium',
        description: 'Dukungan teknis selama 6 bulan setelah pembelian',
        color: AppColors.secondary,
      ),
      StoreFeature(
        icon: Icons.update,
        title: 'Update Gratis',
        description: 'Dapatkan update fitur dan bug fixes secara gratis',
        color: AppColors.success,
      ),
      StoreFeature(
        icon: Icons.security,
        title: 'Secure & Tested',
        description: 'Semua produk sudah melalui testing keamanan',
        color: AppColors.warning,
      ),
      StoreFeature(
        icon: Icons.money_off,
        title: 'Harga Terjangkau',
        description: 'Harga jauh lebih murah dari development dari nol',
        color: AppColors.error,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildFeatureCard(context, feature),
        )).toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.2,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) => _buildFeatureCard(context, features[index]),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, StoreFeature feature) {
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
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: feature.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature.icon,
              size: 24,
              color: feature.color,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            feature.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: Theme.of(context).textTheme.bodyMedium,
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
          colors: [AppColors.accent, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Butuh Aplikasi Custom?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Jika tidak menemukan yang sesuai, kami siap mengembangkan aplikasi khusus untuk bisnis Anda',
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
                    text: 'Konsultasi Custom App',
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
                    text: 'Konsultasi Custom App',
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

// Product Details Dialog
class ProductDetailsDialog extends StatelessWidget {
  final StoreProduct product;

  const ProductDetailsDialog({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: ScreenSize.isMobile(context) 
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width * 0.7,
        height: ScreenSize.isMobile(context)
            ? MediaQuery.of(context).size.height * 0.8
            : MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Header with Product Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
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
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 24,
                      right: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.textLight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product.category} • ${product.type == ProductType.readyApp ? 'Ready App' : 'Source Code'}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textLight.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: AppColors.textLight),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Section
                    Row(
                      children: [
                        if (product.originalPrice > product.price) ...[
                          Text(
                            'Rp ${_formatPrice(product.originalPrice)}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Text(
                          'Rp ${_formatPrice(product.price)}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.discount > 0) ...[
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'SAVE ${product.discount}%',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Features
                    Text(
                      'Features Included',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...product.features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 20,
                            color: AppColors.success,
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
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.technologies.map((tech) => Container(
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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton.secondary(
                      text: product.type == ProductType.readyApp ? 'View Demo' : 'View Preview',
                      icon: Icon(
                        product.type == ProductType.readyApp ? Icons.play_circle_outline : Icons.visibility,
                        size: 16,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // _showDemo(context, product);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton.primary(
                      text: product.type == ProductType.readyApp ? 'Buy Now' : 'Download Now',
                      icon: Icon(
                        product.type == ProductType.readyApp ? Icons.shopping_cart : Icons.download,
                        size: 16,
                        color: AppColors.textLight,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Show purchase/download flow
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              product.type == ProductType.readyApp 
                                  ? 'Redirecting to purchase ${product.name}...'
                                  : 'Starting download for ${product.name}...'
                            ),
                            backgroundColor: AppColors.success,
                          ),
                        );
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

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

// Data Models
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
  final String imageUrl; // Changed from image to imageUrl
  final List<String> features;
  final List<String> technologies;
  final String demoUrl;
  final List<String> screenshots;
  final bool isPopular;
  final int discount;

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
    required this.imageUrl, // Changed from image to imageUrl
    required this.features,
    required this.technologies,
    required this.demoUrl,
    required this.screenshots,
    required this.isPopular,
    required this.discount,
  });
}

class StoreFeature {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  StoreFeature({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}