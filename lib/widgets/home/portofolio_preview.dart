import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_theme.dart';
import '../common/custom_button.dart';
import '../common/responsive_builder.dart';

class PortfolioPreview extends StatelessWidget {
  const PortfolioPreview({Key? key}) : super(key: key);

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
              _buildPortfolioGrid(context),
              const SizedBox(height: 60),
              CustomButton.primary(
                text: 'Lihat Portfolio Lengkap',
                onPressed: () => context.go('/portfolio'),
              ),
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
            color: AppColors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'PORTFOLIO',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Karya Terbaik Kami',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Beberapa project terbaik yang telah kami kerjakan untuk berbagai klien di Indonesia',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPortfolioGrid(BuildContext context) {
    final projects = [
      PortfolioProject(
        title: 'EcommercePlus Mobile App',
        category: 'Mobile App',
        description: 'Aplikasi e-commerce lengkap dengan payment gateway dan sistem inventory',
        image: 'assets/portfolio/ecommerce_app.png',
        technologies: ['Flutter', 'Firebase', 'Stripe'],
        type: ProjectType.mobile,
      ),
      PortfolioProject(
        title: 'RestaurantPro Website',
        category: 'Website',
        description: 'Website restaurant dengan online ordering dan reservation system',
        image: 'assets/portfolio/restaurant_web.png',
        technologies: ['Flutter Web', 'Firebase', 'Maps API'],
        type: ProjectType.web,
      ),
      PortfolioProject(
        title: 'HealthCare Management',
        category: 'Mobile App',
        description: 'Sistem manajemen rumah sakit dengan fitur appointment dan medical records',
        image: 'assets/portfolio/healthcare_app.png',
        technologies: ['Flutter', 'Node.js', 'PostgreSQL'],
        type: ProjectType.mobile,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: projects.map((project) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildProjectCard(context, project),
        )).toList(),
      ),
      desktop: Row(
        children: projects.map((project) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildProjectCard(context, project),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, PortfolioProject project) {
    return Container(
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
          // Project Image Placeholder
          Container(
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
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                project.type == ProjectType.mobile 
                    ? Icons.phone_android 
                    : Icons.web,
                size: 60,
                color: AppColors.textLight,
              ),
            ),
          ),
          
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Project Description
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 16),
                
                // Technologies
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies.map((tech) => Container(
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
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )).toList(),
                ),
                
                const SizedBox(height: 20),
                
                // View Project Button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton.secondary(
                    text: 'Lihat Detail',
                    onPressed: () => context.go('/portfolio'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum ProjectType { mobile, web }

class PortfolioProject {
  final String title;
  final String category;
  final String description;
  final String image;
  final List<String> technologies;
  final ProjectType type;

  PortfolioProject({
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.technologies,
    required this.type,
  });
}