// enhanced_product_card.dart
import 'package:flutter/material.dart';
import 'package:jostar_programming/pages/store_page.dart';
import '../../core/app_theme.dart';

class EnhancedProductCard extends StatefulWidget {
  final StoreProduct product;
  final VoidCallback? onTap;
  final VoidCallback? onDemo;
  final VoidCallback? onBuy;

  const EnhancedProductCard({
    Key? key,
    required this.product,
    this.onTap,
    this.onDemo,
    this.onBuy,
  }) : super(key: key);

  @override
  State<EnhancedProductCard> createState() => _EnhancedProductCardState();
}

class _EnhancedProductCardState extends State<EnhancedProductCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _elevationAnimation = Tween<double>(begin: 8.0, end: 25.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutral.withOpacity(0.1),
                      blurRadius: _elevationAnimation.value,
                      offset: Offset(0, _elevationAnimation.value * 0.6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(),
                    Expanded(child: _buildProductContent()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.product.type == ProductType.readyApp 
                    ? AppColors.accent.withOpacity(0.8)
                    : AppColors.primary.withOpacity(0.8),
                widget.product.type == ProductType.readyApp 
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
              // Background Pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: GeometricPatternPainter(
                    color: AppColors.textLight.withOpacity(0.1),
                  ),
                ),
              ),
              
              // Main Icon
              Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween(begin: 0.8, end: _isHovered ? 1.1 : 1.0),
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Icon(
                        widget.product.type == ProductType.readyApp 
                            ? Icons.smartphone 
                            : Icons.code,
                        size: 50,
                        color: AppColors.textLight,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Badges
        _buildBadges(),
      ],
    );
  }

  Widget _buildBadges() {
    return Positioned(
      top: 12,
      left: 12,
      right: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.product.discount > 0)
            GlassMorphismBadge(
              text: '-${widget.product.discount}%',
              color: AppColors.error,
            ),
          const Spacer(),
          if (widget.product.badge.isNotEmpty)
            GlassMorphismBadge(
              text: widget.product.badge,
              color: _getBadgeColor(widget.product.badge),
            ),
        ],
      ),
    );
  }

  Widget _buildProductContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category and Type
          Row(
            children: [
              PremiumBadge(
                text: widget.product.category,
                color: widget.product.type == ProductType.readyApp 
                    ? AppColors.accent 
                    : AppColors.primary,
              ),
              const Spacer(),
              if (widget.product.isPopular)
                const Icon(Icons.trending_up, size: 16, color: AppColors.success),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Product Name
          Text(
            widget.product.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 8),
          
          // Description
          Text(
            widget.product.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 16),
          
          // Rating and Downloads
          Row(
            children: [
              RatingWidget(rating: widget.product.rating),
              const Spacer(),
              Text(
                '${_formatNumber(widget.product.downloads)}+ downloads',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Price Section
          PriceSection(product: widget.product),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ModernButton.outlined(
                  text: 'Demo',
                  onPressed: widget.onDemo,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ModernButton.filled(
                  text: 'Buy Now',
                  onPressed: widget.onBuy,
                ),
              ),
            ],
          ),
        ],
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

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}

// glass_morphism_badge.dart
class GlassMorphismBadge extends StatelessWidget {
  final String text;
  final Color color;

  const GlassMorphismBadge({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.2),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}

// premium_badge.dart
class PremiumBadge extends StatelessWidget {
  final String text;
  final Color color;

  const PremiumBadge({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// rating_widget.dart
class RatingWidget extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;

  const RatingWidget({
    Key? key,
    required this.rating,
    this.maxRating = 5,
    this.size = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(maxRating, (index) {
          return Icon(
            index < rating.floor() 
                ? Icons.star
                : index < rating 
                    ? Icons.star_half
                    : Icons.star_border,
            size: size,
            color: AppColors.accent,
          );
        }),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// price_section.dart
class PriceSection extends StatelessWidget {
  final StoreProduct product;

  const PriceSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (product.originalPrice > product.price) ...[
              Text(
                'Rp ${_formatPrice(product.originalPrice)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'SAVE ${((product.originalPrice - product.price) / product.originalPrice * 100).round()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
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

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

// modern_button.dart
class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;

  const ModernButton._({
    Key? key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.padding,
  }) : super(key: key);

  factory ModernButton.filled({
    required String text,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsets? padding,
  }) {
    return ModernButton._(
      text: text,
      onPressed: onPressed,
      isOutlined: false,
      backgroundColor: backgroundColor,
      textColor: textColor,
      padding: padding,
    );
  }

  factory ModernButton.outlined({
    required String text,
    VoidCallback? onPressed,
    Color? textColor,
    EdgeInsets? padding,
  }) {
    return ModernButton._(
      text: text,
      onPressed: onPressed,
      isOutlined: true,
      textColor: textColor,
      padding: padding,
    );
  }

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.isOutlined ? null : LinearGradient(
                  colors: [
                    widget.backgroundColor ?? AppColors.primary,
                    (widget.backgroundColor ?? AppColors.primary).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: widget.isOutlined ? Border.all(
                  color: widget.textColor ?? AppColors.primary,
                ) : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onPressed,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        widget.text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: widget.isOutlined
                              ? (widget.textColor ?? AppColors.primary)
                              : AppColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// geometric_pattern_painter.dart
class GeometricPatternPainter extends CustomPainter {
  final Color color;

  GeometricPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw geometric patterns
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 4; j++) {
        final x = (size.width / 6) * i;
        final y = (size.height / 4) * j;
        
        // Draw circles
        canvas.drawCircle(
          Offset(x + 10, y + 10), 
          5, 
          paint,
        );
        
        // Draw lines
        canvas.drawLine(
          Offset(x, y), 
          Offset(x + 20, y + 20), 
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// smart_filter_chip.dart
class SmartFilterChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const SmartFilterChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  State<SmartFilterChip> createState() => _SmartFilterChipState();
}

class _SmartFilterChipState extends State<SmartFilterChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _colorAnimation = ColorTween(
      begin: AppColors.background,
      end: AppColors.primary,
    ).animate(_controller);

    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(SmartFilterChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isSelected 
                      ? AppColors.primary 
                      : AppColors.neutral.withOpacity(0.3),
                ),
                boxShadow: widget.isSelected ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ] : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 16,
                      color: widget.isSelected 
                          ? AppColors.textLight 
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.isSelected 
                          ? AppColors.textLight 
                          : AppColors.textSecondary,
                      fontWeight: widget.isSelected 
                          ? FontWeight.w600 
                          : FontWeight.normal,
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

// parallax_hero_background.dart
class ParallaxHeroBackground extends StatefulWidget {
  final Widget child;

  const ParallaxHeroBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ParallaxHeroBackground> createState() => _ParallaxHeroBackgroundState();
}

class _ParallaxHeroBackgroundState extends State<ParallaxHeroBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated Background
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: ParallaxPatternPainter(
                animation: _controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // Content
        widget.child,
      ],
    );
  }
}

class ParallaxPatternPainter extends CustomPainter {
  final double animation;

  ParallaxPatternPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Create floating geometric shapes
    for (int i = 0; i < 15; i++) {
      final x = (size.width / 15) * i + (animation * 50) % size.width;
      final y = (size.height / 8) * (i % 8) + (animation * 30) % size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        10 + (i % 3) * 5,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}