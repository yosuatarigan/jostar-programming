// premium_product_grid.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jostar_programming/pages/store/product_card_store.dart';
import 'package:jostar_programming/pages/store_page.dart';
import '../../core/app_theme.dart';

class PremiumProductGrid extends StatefulWidget {
  final List<StoreProduct> products;
  final bool isGridView;
  final Function(StoreProduct)? onProductTap;
  final Function(StoreProduct)? onDemo;
  final Function(StoreProduct)? onBuy;

  const PremiumProductGrid({
    Key? key,
    required this.products,
    this.isGridView = true,
    this.onProductTap,
    this.onDemo,
    this.onBuy,
  }) : super(key: key);

  @override
  State<PremiumProductGrid> createState() => _PremiumProductGridState();
}

class _PremiumProductGridState extends State<PremiumProductGrid>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;
  final List<AnimationController> _cardControllers = [];
  final List<Animation<double>> _cardAnimations = [];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: Duration(milliseconds: 100 * widget.products.length),
      vsync: this,
    );
    
    _initializeCardAnimations();
    _staggerController.forward();
  }

  void _initializeCardAnimations() {
    for (int i = 0; i < widget.products.length; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
      
      final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            i * 0.1 / widget.products.length,
            (i + 1) * 0.1 / widget.products.length + 0.6,
            curve: Curves.easeOutBack,
          ),
        ),
      );
      
      _cardControllers.add(controller);
      _cardAnimations.add(animation);
    }
  }

  @override
  void dispose() {
    _staggerController.dispose();
    for (final controller in _cardControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGridView) {
      return _buildStaggeredGrid();
    } else {
      return _buildListView();
    }
  }

  Widget _buildStaggeredGrid() {
    return MasonryGridView.count(
      crossAxisCount: _getCrossAxisCount(context),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _cardAnimations[index],
          builder: (context, child) {
            return Transform.scale(
              scale: _cardAnimations[index].value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - _cardAnimations[index].value)),
                child: Opacity(
                  opacity: _cardAnimations[index].value,
                  child: _buildPremiumCard(widget.products[index], index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListView() {
    return Column(
      children: widget.products.asMap().entries.map((entry) {
        final index = entry.key;
        final product = entry.value;
        
        return AnimatedBuilder(
          animation: _cardAnimations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(100 * (1 - _cardAnimations[index].value), 0),
              child: Opacity(
                opacity: _cardAnimations[index].value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: _buildPremiumListItem(product),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildPremiumCard(StoreProduct product, int index) {
    // Vary card heights for masonry effect
    final cardHeight = _getCardHeight(index);
    
    return InkWell(
      onTap: () => widget.onProductTap?.call(product),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface,
              AppColors.background.withOpacity(0.5),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral.withOpacity(0.08),
              blurRadius: 30,
              offset: const Offset(0, 15),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Animated Background Pattern
              _buildAnimatedBackground(product),
              
              // Glass Morphism Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.surface.withOpacity(0.9),
                      AppColors.surface.withOpacity(0.95),
                    ],
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCardHeader(product),
                    const SizedBox(height: 16),
                    _buildProductIcon(product),
                    const Spacer(),
                    _buildProductInfo(product),
                    const SizedBox(height: 16),
                    _buildCardActions(product),
                  ],
                ),
              ),
              
              // Hover Overlay
              _buildHoverOverlay(product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground(StoreProduct product) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 10),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return CustomPaint(
          painter: AnimatedBackgroundPainter(
            animation: value,
            color: product.type == ProductType.readyApp 
                ? AppColors.accent 
                : AppColors.primary,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildCardHeader(StoreProduct product) {
    return Row(
      children: [
        PremiumBadge(
          text: product.category,
          color: product.type == ProductType.readyApp 
              ? AppColors.accent 
              : AppColors.primary,
        ),
        const Spacer(),
        if (product.badge.isNotEmpty)
          MicroAnimatedBadge(
            text: product.badge,
            color: _getBadgeColor(product.badge),
          ),
      ],
    );
  }

  Widget _buildProductIcon(StoreProduct product) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  product.type == ProductType.readyApp 
                      ? AppColors.accent 
                      : AppColors.primary,
                  product.type == ProductType.readyApp 
                      ? AppColors.primary 
                      : AppColors.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: (product.type == ProductType.readyApp 
                      ? AppColors.accent 
                      : AppColors.primary).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              product.type == ProductType.readyApp 
                  ? Icons.smartphone 
                  : Icons.code,
              size: 35,
              color: AppColors.textLight,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductInfo(StoreProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            EnhancedRatingWidget(rating: product.rating),
            const Spacer(),
            Text(
              '${_formatDownloads(product.downloads)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AnimatedPriceWidget(product: product),
      ],
    );
  }

  Widget _buildCardActions(StoreProduct product) {
    return Row(
      children: [
        Expanded(
          child: GlassMorphismButton(
            text: 'Demo',
            icon: Icons.play_circle_outline,
            onPressed: () => widget.onDemo?.call(product),
            isOutlined: true,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GlassMorphismButton(
            text: 'Buy',
            icon: Icons.shopping_cart,
            onPressed: () => widget.onBuy?.call(product),
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
        ),
      ],
    );
  }

  Widget _buildHoverOverlay(StoreProduct product) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onProductTap?.call(product),
          borderRadius: BorderRadius.circular(24),
          splashColor: (product.type == ProductType.readyApp 
              ? AppColors.accent 
              : AppColors.primary).withOpacity(0.1),
          highlightColor: (product.type == ProductType.readyApp 
              ? AppColors.accent 
              : AppColors.primary).withOpacity(0.05),
        ),
      ),
    );
  }

  Widget _buildPremiumListItem(StoreProduct product) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
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
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: (product.type == ProductType.readyApp 
                      ? AppColors.accent 
                      : AppColors.primary).withOpacity(0.25),
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
          
          const SizedBox(width: 20),
          
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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (product.badge.isNotEmpty)
                      MicroAnimatedBadge(
                        text: product.badge,
                        color: _getBadgeColor(product.badge),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.category} • ${_formatDownloads(product.downloads)} downloads',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                EnhancedRatingWidget(rating: product.rating),
              ],
            ),
          ),
          
          // Price and Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedPriceWidget(product: product),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlassMorphismButton(
                    text: 'Demo',
                    icon: Icons.play_circle_outline,
                    onPressed: () => widget.onDemo?.call(product),
                    isOutlined: true,
                    isCompact: true,
                  ),
                  const SizedBox(width: 8),
                  GlassMorphismButton(
                    text: 'Buy',
                    icon: Icons.shopping_cart,
                    onPressed: () => widget.onBuy?.call(product),
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
                    isCompact: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 3;
    if (width > 768) return 2;
    return 1;
  }

  double _getCardHeight(int index) {
    // Create varied heights for masonry effect
    final heights = [280.0, 320.0, 300.0, 340.0, 290.0];
    return heights[index % heights.length];
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

  String _formatDownloads(int downloads) {
    if (downloads >= 1000) {
      return '${(downloads / 1000).toStringAsFixed(1)}k+';
    }
    return '$downloads+';
  }
}

// micro_animated_badge.dart
class MicroAnimatedBadge extends StatefulWidget {
  final String text;
  final Color color;

  const MicroAnimatedBadge({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  State<MicroAnimatedBadge> createState() => _MicroAnimatedBadgeState();
}

class _MicroAnimatedBadgeState extends State<MicroAnimatedBadge>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _shimmerController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Text(
                  widget.text,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
                // Shimmer effect
                Positioned.fill(
                  child: ClipRect(
                    child: Transform.translate(
                      offset: Offset(_shimmerAnimation.value * 50, 0),
                      child: Container(
                        width: 20,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.textLight.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
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
}

// enhanced_rating_widget.dart
class EnhancedRatingWidget extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;

  const EnhancedRatingWidget({
    Key? key,
    required this.rating,
    this.maxRating = 5,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(maxRating, (index) {
          double starValue = (rating - index).clamp(0.0, 1.0);
          
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 200 + (index * 100)),
            tween: Tween(begin: 0, end: starValue),
            builder: (context, value, child) {
              return ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  stops: [0, value, value, 1],
                  colors: [
                    AppColors.accent,
                    AppColors.accent,
                    AppColors.neutral.withOpacity(0.3),
                    AppColors.neutral.withOpacity(0.3),
                  ],
                ).createShader(bounds),
                child: Icon(
                  Icons.star,
                  size: size,
                  color: Colors.white,
                ),
              );
            },
          );
        }),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            rating.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

// animated_price_widget.dart
class AnimatedPriceWidget extends StatefulWidget {
  final StoreProduct product;

  const AnimatedPriceWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<AnimatedPriceWidget> createState() => _AnimatedPriceWidgetState();
}

class _AnimatedPriceWidgetState extends State<AnimatedPriceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _priceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _priceAnimation = Tween<double>(
      begin: widget.product.originalPrice.toDouble(),
      end: widget.product.price.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.product.originalPrice > widget.product.price) ...[
          Row(
            children: [
              Text(
                'Rp ${_formatPrice(widget.product.originalPrice)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'SAVE ${((widget.product.originalPrice - widget.product.price) / widget.product.originalPrice * 100).round()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
        AnimatedBuilder(
          animation: _priceAnimation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.accent, AppColors.primary],
              ).createShader(bounds),
              child: Text(
                'Rp ${_formatPrice(_priceAnimation.value.round())}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          },
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
}

// glass_morphism_button.dart
class GlassMorphismButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isCompact;
  final Gradient? gradient;

  const GlassMorphismButton({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
    this.isOutlined = false,
    this.isCompact = false,
    this.gradient,
  }) : super(key: key);

  @override
  State<GlassMorphismButton> createState() => _GlassMorphismButtonState();
}

class _GlassMorphismButtonState extends State<GlassMorphismButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.isCompact ? 12 : 16,
                vertical: widget.isCompact ? 8 : 12,
              ),
              decoration: BoxDecoration(
                gradient: widget.isOutlined ? null : (
                  widget.gradient ?? const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  )
                ),
                borderRadius: BorderRadius.circular(12),
                border: widget.isOutlined ? Border.all(
                  color: AppColors.primary.withOpacity(0.6),
                  width: 1.5,
                ) : null,
                boxShadow: [
                  if (!widget.isOutlined)
                    BoxShadow(
                      color: (widget.gradient?.colors.first ?? AppColors.primary)
                          .withOpacity(0.3 + (0.2 * _glowAnimation.value)),
                      blurRadius: 15 + (10 * _glowAnimation.value),
                      offset: const Offset(0, 8),
                    ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: widget.isCompact ? 16 : 18,
                      color: widget.isOutlined 
                          ? AppColors.primary 
                          : AppColors.textLight,
                    ),
                    SizedBox(width: widget.isCompact ? 4 : 6),
                  ],
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.isOutlined 
                          ? AppColors.primary 
                          : AppColors.textLight,
                      fontWeight: FontWeight.w700,
                      fontSize: widget.isCompact ? 11 : 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// animated_background_painter.dart
class AnimatedBackgroundPainter extends CustomPainter {
  final double animation;
  final Color color;

  AnimatedBackgroundPainter({
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Create flowing geometric patterns
    for (int i = 0; i < 8; i++) {
      final offset = animation * 2 * 3.14159;
      final x = (size.width / 8) * i + (50 * sin(offset + i));
      final y = (size.height / 6) * (i % 6) + (30 * cos(offset + i));
      
      // Draw flowing circles
      canvas.drawCircle(
        Offset(x, y),
        15 + (5 * sin(offset + i)),
        paint,
      );
      
      // Draw connecting lines
      if (i > 0) {
        final prevX = (size.width / 8) * (i - 1) + (50 * sin(offset + i - 1));
        final prevY = (size.height / 6) * ((i - 1) % 6) + (30 * cos(offset + i - 1));
        
        canvas.drawLine(
          Offset(prevX, prevY),
          Offset(x, y),
          Paint()
            ..color = color.withOpacity(0.02)
            ..strokeWidth = 1.0,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}