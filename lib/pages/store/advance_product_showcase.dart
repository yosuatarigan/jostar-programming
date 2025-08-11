// advanced_product_showcase.dart
import 'package:flutter/material.dart';
import 'package:jostar_programming/pages/store/product_card_store.dart';
import 'package:jostar_programming/pages/store_page.dart';
import '../../core/app_theme.dart';

class AdvancedProductShowcase extends StatefulWidget {
  final List<StoreProduct> products;

  const AdvancedProductShowcase({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<AdvancedProductShowcase> createState() => _AdvancedProductShowcaseState();
}

class _AdvancedProductShowcaseState extends State<AdvancedProductShowcase>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  int _currentIndex = 0;
  bool _autoPlay = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutQuart),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideController.forward();
    _fadeController.forward();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _autoPlay) {
        _nextProduct();
        _startAutoPlay();
      }
    });
  }

  void _nextProduct() {
    if (_currentIndex < widget.products.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.05),
                  AppColors.accent.withOpacity(0.03),
                ],
              ),
            ),
          ),
          
          // Main Showcase
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _slideAnimation.value)),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                        _autoPlay = false;
                      });
                    },
                    itemCount: widget.products.length,
                    itemBuilder: (context, index) {
                      return _buildShowcaseCard(widget.products[index], index);
                    },
                  ),
                ),
              );
            },
          ),
          
          // Indicators
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildIndicators(),
          ),
          
          // Navigation Arrows (Desktop)
          if (MediaQuery.of(context).size.width > 768) ...[
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: _buildNavigationButton(Icons.chevron_left, () {
                if (_currentIndex > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }),
            ),
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: _buildNavigationButton(Icons.chevron_right, () {
                if (_currentIndex < widget.products.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildShowcaseCard(StoreProduct product, int index) {
    final isCenter = index == _currentIndex;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: isCenter ? 0 : 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(isCenter ? 0.2 : 0.1),
            blurRadius: isCenter ? 25 : 15,
            offset: Offset(0, isCenter ? 15 : 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Image/Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
            ),
            
            // Glass Morphism Overlay
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.95),
                backgroundBlendMode: BlendMode.overlay,
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with badges
                  // Row(
                  //   children: [
                  //     PremiumBadge(
                  //       text: product.category,
                  //       color: product.type == ProductType.readyApp 
                  //           ? AppColors.accent 
                  //           : AppColors.primary,
                  //     ),
                  //     const Spacer(),
                  //     if (product.badge.isNotEmpty)
                  //       GlassMorphismBadge(
                  //         text: product.badge,
                  //         color: _getBadgeColor(product.badge),
                  //       ),
                  //   ],
                  // ),
                  
                  // const SizedBox(height: 20),
                  
                  // Product Icon
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
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (product.type == ProductType.readyApp 
                              ? AppColors.accent 
                              : AppColors.primary).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      product.type == ProductType.readyApp 
                          ? Icons.smartphone 
                          : Icons.code,
                      size: 40,
                      color: AppColors.textLight,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Product Info
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Rating and Price
                  Row(
                    children: [
                      RatingWidget(rating: product.rating),
                      const Spacer(),
                      Text(
                        'Rp ${_formatPrice(product.price)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: ModernButton.filled(
                      text: 'View Details',
                      onPressed: () {},
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

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.products.asMap().entries.map((entry) {
        final index = entry.key;
        final isActive = index == _currentIndex;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.neutral.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return Center(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: AppColors.primary),
        ),
      ),
    );
  }

  Color _getBadgeColor(String badge) {
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

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

// interactive_filter_bar.dart
class InteractiveFilterBar extends StatefulWidget {
  final List<String> categories;
  final List<String> types;
  final String selectedCategory;
  final String selectedType;
  final String sortBy;
  final Function(String) onCategoryChanged;
  final Function(String) onTypeChanged;
  final Function(String) onSortChanged;

  const InteractiveFilterBar({
    Key? key,
    required this.categories,
    required this.types,
    required this.selectedCategory,
    required this.selectedType,
    required this.sortBy,
    required this.onCategoryChanged,
    required this.onTypeChanged,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  State<InteractiveFilterBar> createState() => _InteractiveFilterBarState();
}

class _InteractiveFilterBarState extends State<InteractiveFilterBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
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
                // Categories
                _buildFilterSection(
                  'Categories',
                  widget.categories,
                  widget.selectedCategory,
                  widget.onCategoryChanged,
                  Icons.category,
                ),
                
                const SizedBox(height: 24),
                
                // Types and Sort
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterSection(
                        'Type',
                        widget.types,
                        widget.selectedType,
                        widget.onTypeChanged,
                        Icons.type_specimen,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildSortSection(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> items,
    String selected,
    Function(String) onChanged,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) => SmartFilterChip(
            label: item,
            isSelected: selected == item,
            onTap: () => onChanged(item),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildSortSection() {
    final sortOptions = ['Popular', 'Price Low', 'Price High', 'Rating', 'Newest'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.sort, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Sort by',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.sortBy,
              isExpanded: true,
              icon: const Icon(Icons.expand_more, color: AppColors.primary),
              items: sortOptions.map((option) => DropdownMenuItem(
                value: option,
                child: Text(
                  option,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )).toList(),
              onChanged: (value) => widget.onSortChanged(value!),
            ),
          ),
        ),
      ],
    );
  }
}

// product_comparison_modal.dart
class ProductComparisonModal extends StatefulWidget {
  final List<StoreProduct> products;

  const ProductComparisonModal({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<ProductComparisonModal> createState() => _ProductComparisonModalState();
}

class _ProductComparisonModalState extends State<ProductComparisonModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutral.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(child: _buildComparisonTable()),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.compare_arrows, color: AppColors.textLight, size: 28),
          const SizedBox(width: 12),
          Text(
            'Product Comparison',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Table(
        columnWidths: {
          0: const FlexColumnWidth(2),
          for (int i = 1; i <= widget.products.length; i++)
            i: const FlexColumnWidth(3),
        },
        children: [
          // Headers
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(''),
              ),
              ...widget.products.map((product) => Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
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
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
            ],
          ),
          
          // Comparison Rows
          ..._buildComparisonRows(),
        ],
      ),
    );
  }

  List<TableRow> _buildComparisonRows() {
    final rows = [
      ('Price', (product) => 'Rp ${_formatPrice(product.price)}'),
      ('Rating', (product) => '${product.rating}/5.0'),
      ('Downloads', (product) => '${product.downloads}+'),
      ('Category', (product) => product.category),
      ('Type', (product) => product.type == ProductType.readyApp ? 'Ready App' : 'Source Code'),
      ('Features', (product) => '${product.features.length} features'),
      ('Technologies', (product) => product.technologies.join(', ')),
      ('Support', (product) => '12 months'),
    ];

    return rows.map((row) => TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.neutral.withOpacity(0.2)),
          ),
          child: Text(
            row.$1,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...widget.products.map((product) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral.withOpacity(0.2)),
          ),
          child: Text(
            row.$2(product),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        )),
      ],
    )).toList();
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: widget.products.map((product) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ModernButton.filled(
              text: 'Buy Now',
              onPressed: () {
                Navigator.of(context).pop();
                // Handle purchase
              },
            ),
          ),
        )).toList(),
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

// live_chat_widget.dart
class LiveChatWidget extends StatefulWidget {
  const LiveChatWidget({Key? key}) : super(key: key);

  @override
  State<LiveChatWidget> createState() => _LiveChatWidgetState();
}

class _LiveChatWidgetState extends State<LiveChatWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isExpanded ? 300 : 60,
        height: _isExpanded ? 400 : 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.success, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(_isExpanded ? 16 : 30),
          boxShadow: [
            BoxShadow(
              color: AppColors.success.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: _isExpanded ? _buildChatInterface() : _buildChatButton(),
      ),
    );
  }

  Widget _buildChatButton() {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = true),
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.success, AppColors.primary],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat,
                color: AppColors.textLight,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatInterface() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.textLight,
                child: Icon(Icons.support_agent, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Support',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Online now',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textLight.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _isExpanded = false),
                icon: const Icon(Icons.close, color: AppColors.textLight, size: 18),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Chat Area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.textLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildChatBubble(
                    'Hi! How can I help you today?',
                    isFromSupport: true,
                  ),
                  const SizedBox(height: 8),
                  _buildQuickReplies(),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Input
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.textLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Type a message...',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textLight.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.textLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, size: 16, color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, {bool isFromSupport = false}) {
    return Align(
      alignment: isFromSupport ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isFromSupport 
              ? AppColors.textLight.withOpacity(0.2)
              : AppColors.textLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isFromSupport 
                ? AppColors.textLight 
                : AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickReplies() {
    final replies = ['Product Info', 'Pricing', 'Demo Request'];
    
    return Column(
      children: replies.map((reply) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 4),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: AppColors.textLight.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          child: Text(
            reply,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ),
      )).toList(),
    );
  }
}

// enhanced_search_bar.dart
class EnhancedSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final List<String> suggestions;

  const EnhancedSearchBar({
    Key? key,
    required this.onSearch,
    this.suggestions = const [],
  }) : super(key: key);

  @override
  State<EnhancedSearchBar> createState() => _EnhancedSearchBarState();
}

class _EnhancedSearchBarState extends State<EnhancedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late TextEditingController _textController;
  bool _isExpanded = false;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _widthAnimation = Tween<double>(begin: 200, end: 400).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Container(
          width: MediaQuery.of(context).size.width > 768 
              ? _widthAnimation.value 
              : double.infinity,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutral.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _textController,
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                      _showSuggestions = true;
                    });
                    _controller.forward();
                  },
                  onChanged: (value) {
                    widget.onSearch(value);
                    setState(() {
                      _showSuggestions = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                    suffixIcon: _isExpanded ? IconButton(
                      onPressed: () {
                        _textController.clear();
                        setState(() {
                          _isExpanded = false;
                          _showSuggestions = false;
                        });
                        _controller.reverse();
                      },
                      icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    ) : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              
              // Suggestions
              if (_showSuggestions && widget.suggestions.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neutral.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: widget.suggestions.take(5).map((suggestion) => 
                      ListTile(
                        leading: const Icon(Icons.search, size: 16, color: AppColors.textSecondary),
                        title: Text(suggestion),
                        onTap: () {
                          _textController.text = suggestion;
                          widget.onSearch(suggestion);
                          setState(() => _showSuggestions = false);
                        },
                      ),
                    ).toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}