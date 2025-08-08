import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../common/responsive_builder.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: ResponsiveBuilder(
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _buildContent(context),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 4,
          child: _buildAdvantagesGrid(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContent(context),
        const SizedBox(height: 40),
        _buildAdvantagesGrid(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'MENGAPA PILIH KAMI',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Partner Terpercaya untuk Transformasi Digital Anda',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: ScreenSize.isMobile(context) ? 28 : 36,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Kami memahami kebutuhan bisnis Indonesia dan berkomitmen memberikan solusi digital terbaik dengan teknologi terdepan.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        _buildMainAdvantages(context),
      ],
    );
  }

  Widget _buildMainAdvantages(BuildContext context) {
    final advantages = [
      MainAdvantage(
        icon: Icons.speed,
        title: 'Development Cepat',
        description: 'Proses pengembangan yang efisien dengan metodologi Agile',
      ),
      MainAdvantage(
        icon: Icons.support_agent,
        title: 'Support 24/7',
        description: 'Tim support yang siap membantu kapan saja Anda butuhkan',
      ),
      MainAdvantage(
        icon: Icons.trending_up,
        title: 'Scalable Solution',
        description: 'Solusi yang dapat berkembang mengikuti pertumbuhan bisnis',
      ),
    ];

    return Column(
      children: advantages.map((advantage) => Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                advantage.icon,
                size: 24,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    advantage.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    advantage.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildAdvantagesGrid(BuildContext context) {
    final stats = [
      StatItem(
        number: '100%',
        label: 'Client Satisfaction',
        icon: Icons.sentiment_very_satisfied,
        color: AppColors.success,
      ),
      StatItem(
        number: '50+',
        label: 'Projects Completed',
        icon: Icons.assignment_turned_in,
        color: AppColors.primary,
      ),
      StatItem(
        number: '3+',
        label: 'Years Experience',
        icon: Icons.access_time,
        color: AppColors.secondary,
      ),
      StatItem(
        number: '24/7',
        label: 'Support Available',
        icon: Icons.support_agent,
        color: AppColors.accent,
      ),
    ];

    return ResponsiveBuilder(
      mobile: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) => _buildStatCard(context, stats[index]),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.3,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) => _buildStatCard(context, stats[index]),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, StatItem stat) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: stat.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              stat.icon,
              size: 26,
              color: stat.color,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            stat.number,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: stat.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MainAdvantage {
  final IconData icon;
  final String title;
  final String description;

  MainAdvantage({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class StatItem {
  final String number;
  final String label;
  final IconData icon;
  final Color color;

  StatItem({
    required this.number,
    required this.label,
    required this.icon,
    required this.color,
  });
}