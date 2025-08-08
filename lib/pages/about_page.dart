import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildFounderSection(context),
          _buildVisionMissionSection(context),
          _buildSkillsSection(context),
          _buildExperienceSection(context),
          _buildValuesSection(context),
          _buildJourneySection(context),
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
            AppColors.primary.withOpacity(0.05),
            AppColors.secondary.withOpacity(0.1),
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
          flex: 5,
          child: _buildHeroContent(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildHeroImage(context),
        ),
      ],
    );
  }

  Widget _buildMobileHero(BuildContext context) {
    return Column(
      children: [
        _buildHeroImage(context),
        const SizedBox(height: 40),
        _buildHeroContent(context),
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
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '👋 TENTANG KAMI',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Hi, Saya Yosua Tarigan',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: ScreenSize.isMobile(context) ? 32 : 48,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Text(
          'Founder & Lead Developer',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        const SizedBox(height: 24),
        Text(
          'Seorang Flutter Developer yang berpengalaman 3+ tahun mengembangkan aplikasi mobile dan website. '
          'Berkomitmen membantu bisnis Indonesia bertransformasi digital dengan solusi teknologi yang inovatif dan terjangkau.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
          textAlign: ScreenSize.isMobile(context) 
              ? TextAlign.center 
              : TextAlign.left,
        ),
        const SizedBox(height: 32),
        _buildQuickStats(context),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Container(
      height: ScreenSize.isMobile(context) ? 250 : 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Profile placeholder
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surface,
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
                Icons.person,
                size: 60,
                color: AppColors.primary,
              ),
            ),
          ),
          
          // Decorative elements
          Positioned(
            top: 30,
            right: 30,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.code,
                color: AppColors.textLight,
                size: 20,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 30,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.flutter_dash,
                color: AppColors.textLight,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final stats = [
      {'number': '3+', 'label': 'Years Experience'},
      {'number': '50+', 'label': 'Projects Done'},
      {'number': '20+', 'label': 'Happy Clients'},
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
              color: AppColors.primary,
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

  Widget _buildFounderSection(BuildContext context) {
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
              Text(
                'Tentang Jostar Programming',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              ResponsiveBuilder(
                mobile: _buildMobileFounderContent(context),
                desktop: _buildDesktopFounderContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopFounderContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildFounderStory(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildFounderHighlights(context),
        ),
      ],
    );
  }

  Widget _buildMobileFounderContent(BuildContext context) {
    return Column(
      children: [
        _buildFounderStory(context),
        const SizedBox(height: 40),
        _buildFounderHighlights(context),
      ],
    );
  }

  Widget _buildFounderStory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Perjalanan Saya di Dunia Programming',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Saya memulai perjalanan programming sejak kuliah dan langsung jatuh cinta dengan dunia pengembangan aplikasi. '
          'Dimulai dari mempelajari bahasa pemrograman dasar, kemudian fokus pada pengembangan mobile dengan Flutter.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Setelah bekerja di beberapa perusahaan teknologi dan mengerjakan berbagai project freelance, '
          'saya memutuskan untuk mendirikan Jostar Programming dengan misi membantu bisnis Indonesia '
          'bertransformasi digital dengan solusi yang terjangkau dan berkualitas tinggi.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Nama "Jostar" sendiri berasal dari kombinasi nama saya "Josua Tarigan" - '
          'sebuah brand personal yang mencerminkan dedikasi saya dalam mengembangkan solusi digital terbaik.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFounderHighlights(BuildContext context) {
    final highlights = [
      FounderHighlight(
        icon: Icons.school,
        title: 'Education',
        description: 'Computer Science Background\nFokus pada Mobile Development',
        color: AppColors.primary,
      ),
      FounderHighlight(
        icon: Icons.work,
        title: 'Experience',
        description: '3+ Years Professional\n50+ Projects Completed',
        color: AppColors.secondary,
      ),
      FounderHighlight(
        icon: Icons.favorite,
        title: 'Passion',
        description: 'Flutter & Firebase Enthusiast\nInnovative Problem Solver',
        color: AppColors.accent,
      ),
      FounderHighlight(
        icon: Icons.location_on,
        title: 'Location',
        description: 'Based in Indonesia\nServing Local & International',
        color: AppColors.success,
      ),
    ];

    return Column(
      children: highlights.map((highlight) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: highlight.color.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: highlight.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  highlight.icon,
                  color: highlight.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      highlight.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: highlight.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      highlight.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildVisionMissionSection(BuildContext context) {
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
            mobile: _buildMobileVisionMission(context),
            desktop: _buildDesktopVisionMission(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopVisionMission(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildVisionCard(context)),
        const SizedBox(width: 40),
        Expanded(child: _buildMissionCard(context)),
      ],
    );
  }

  Widget _buildMobileVisionMission(BuildContext context) {
    return Column(
      children: [
        _buildVisionCard(context),
        const SizedBox(height: 32),
        _buildMissionCard(context),
      ],
    );
  }

  Widget _buildVisionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
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
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.visibility,
              size: 40,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Visi Kami',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Menjadi partner teknologi terpercaya untuk transformasi digital bisnis Indonesia, '
            'memberikan solusi inovatif yang memungkinkan setiap bisnis berkembang di era digital.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMissionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
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
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accent, AppColors.primary],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.rocket_launch,
              size: 40,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Misi Kami',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Mengembangkan aplikasi mobile dan website berkualitas tinggi dengan teknologi terdepan, '
            'memberikan layanan konsultasi yang komprehensif, dan mendukung pertumbuhan bisnis klien '
            'melalui solusi digital yang efektif dan terjangkau.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
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
              Text(
                'Keahlian & Teknologi',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Teknologi dan tools yang saya kuasai untuk mengembangkan solusi digital terbaik',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildSkillsGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context) {
    final skillCategories = [
      SkillCategory(
        title: 'Mobile Development',
        skills: [
          Skill('Flutter', 95, AppColors.primary),
          Skill('Dart', 95, AppColors.primary),
          Skill('iOS Development', 80, AppColors.secondary),
          Skill('Android Development', 85, AppColors.secondary),
        ],
        icon: Icons.phone_android,
      ),
      SkillCategory(
        title: 'Web Development',
        skills: [
          Skill('Flutter Web', 90, AppColors.accent),
          Skill('HTML/CSS', 85, AppColors.accent),
          Skill('JavaScript', 80, AppColors.warning),
          Skill('Responsive Design', 90, AppColors.warning),
        ],
        icon: Icons.web,
      ),
      SkillCategory(
        title: 'Backend & Database',
        skills: [
          Skill('Firebase', 95, AppColors.success),
          Skill('Node.js', 75, AppColors.success),
          Skill('PostgreSQL', 70, AppColors.primary),
          Skill('MongoDB', 75, AppColors.primary),
        ],
        icon: Icons.storage,
      ),
      SkillCategory(
        title: 'Tools & Others',
        skills: [
          Skill('Git/GitHub', 90, AppColors.neutral),
          Skill('Figma/Adobe XD', 80, AppColors.error),
          Skill('API Integration', 85, AppColors.secondary),
          Skill('Project Management', 80, AppColors.accent),
        ],
        icon: Icons.build,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: skillCategories.map((category) => Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: _buildSkillCategoryCard(context, category),
        )).toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 32,
          mainAxisSpacing: 32,
          childAspectRatio: 1.2,
        ),
        itemCount: skillCategories.length,
        itemBuilder: (context, index) => _buildSkillCategoryCard(context, skillCategories[index]),
      ),
    );
  }

  Widget _buildSkillCategoryCard(BuildContext context, SkillCategory category) {
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
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  category.icon,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...category.skills.map((skill) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      skill.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${skill.level}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: skill.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: skill.level / 100,
                  backgroundColor: AppColors.background,
                  valueColor: AlwaysStoppedAnimation<Color>(skill.color),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
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
                'Pengalaman & Pencapaian',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildExperienceTimeline(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    final experiences = [
      Experience(
        year: '2024',
        title: 'Founding Jostar Programming',
        description: 'Mendirikan bisnis pengembangan aplikasi dengan fokus pada solusi digital untuk bisnis Indonesia',
        type: ExperienceType.milestone,
      ),
      Experience(
        year: '2023',
        title: 'Senior Flutter Developer',
        description: 'Memimpin tim development dalam mengerjakan project-project enterprise level',
        type: ExperienceType.work,
      ),
      Experience(
        year: '2022',
        title: 'Freelance Mobile Developer',
        description: 'Mengerjakan berbagai project freelance dan membangun portofolio yang solid',
        type: ExperienceType.work,
      ),
      Experience(
        year: '2021',
        title: 'First Professional Flutter Project',
        description: 'Menyelesaikan project Flutter pertama secara profesional dan mendapat excellent review',
        type: ExperienceType.achievement,
      ),
    ];

    return Column(
      children: experiences.map((exp) => _buildTimelineItem(context, exp)).toList(),
    );
  }

  Widget _buildTimelineItem(BuildContext context, Experience experience) {
    Color getColor() {
      switch (experience.type) {
        case ExperienceType.milestone:
          return AppColors.accent;
        case ExperienceType.work:
          return AppColors.primary;
        case ExperienceType.achievement:
          return AppColors.success;
      }
    }

    IconData getIcon() {
      switch (experience.type) {
        case ExperienceType.milestone:
          return Icons.emoji_events;
        case ExperienceType.work:
          return Icons.work;
        case ExperienceType.achievement:
          return Icons.star;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: ResponsiveBuilder(
        mobile: _buildMobileTimelineItem(context, experience, getColor(), getIcon()),
        desktop: _buildDesktopTimelineItem(context, experience, getColor(), getIcon()),
      ),
    );
  }

  Widget _buildDesktopTimelineItem(BuildContext context, Experience experience, Color color, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year
        SizedBox(
          width: 80,
          child: Text(
            experience.year,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Timeline
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.textLight,
                size: 20,
              ),
            ),
            Container(
              width: 2,
              height: 60,
              color: color.withOpacity(0.3),
            ),
          ],
        ),
        
        const SizedBox(width: 24),
        
        // Content
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  experience.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTimelineItem(BuildContext context, Experience experience, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.textLight,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.year,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  experience.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  experience.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection(BuildContext context) {
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
              Text(
                'Nilai-Nilai yang Kami Pegang',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildValuesGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValuesGrid(BuildContext context) {
    final values = [
      CompanyValue(
        icon: Icons.high_quality,
        title: 'Kualitas Terbaik',
        description: 'Mengutamakan kualitas dalam setiap line code dan fitur aplikasi',
        color: AppColors.primary,
      ),
      CompanyValue(
        icon: Icons.handshake,
        title: 'Transparansi',
        description: 'Komunikasi yang jujur dan transparan dalam setiap tahap project',
        color: AppColors.secondary,
      ),
      CompanyValue(
        icon: Icons.speed,
        title: 'Efisiensi',
        description: 'Menyelesaikan project tepat waktu dengan metodologi yang efisien',
        color: AppColors.accent,
      ),
      CompanyValue(
        icon: Icons.lightbulb,
        title: 'Inovasi',
        description: 'Selalu menggunakan teknologi terdepan dan solusi inovatif',
        color: AppColors.success,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: values.map((value) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildValueCard(context, value),
        )).toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.3,
        ),
        itemCount: values.length,
        itemBuilder: (context, index) => _buildValueCard(context, values[index]),
      ),
    );
  }

  Widget _buildValueCard(BuildContext context, CompanyValue value) {
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: value.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              value.icon,
              size: 30,
              color: value.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            value.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneySection(BuildContext context) {
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
                'Mengapa Saya Memilih Flutter?',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(32),
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
                  children: [
                    Icon(
                      Icons.flutter_dash,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '"Flutter memungkinkan saya mengembangkan aplikasi berkualitas tinggi untuk iOS dan Android '
                      'dengan satu codebase. Hot reload yang cepat, performance yang excellent, dan ecosystem yang kuat '
                      'membuat development menjadi lebih efisien dan menyenangkan."',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '- Yosua Tarigan, Flutter Developer',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
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
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Mari Berkolaborasi!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Saya siap membantu mewujudkan visi digital Anda. Mari diskusikan project impian Anda!',
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
                    text: 'Mulai Konsultasi',
                    backgroundColor: AppColors.textLight,
                    onPressed: () => context.go('/contact'),
                  ),
                  const SizedBox(height: 16),
                  CustomButton.secondary(
                    text: 'Lihat Portfolio',
                    onPressed: () => context.go('/portfolio'),
                  ),
                ],
              ),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton.large(
                    text: 'Mulai Konsultasi',
                    backgroundColor: AppColors.textLight,
                    onPressed: () => context.go('/contact'),
                  ),
                  const SizedBox(width: 16),
                  CustomButton.secondary(
                    text: 'Lihat Portfolio',
                    onPressed: () => context.go('/portfolio'),
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
class FounderHighlight {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  FounderHighlight({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class SkillCategory {
  final String title;
  final List<Skill> skills;
  final IconData icon;

  SkillCategory({
    required this.title,
    required this.skills,
    required this.icon,
  });
}

class Skill {
  final String name;
  final int level;
  final Color color;

  Skill(this.name, this.level, this.color);
}

enum ExperienceType { milestone, work, achievement }

class Experience {
  final String year;
  final String title;
  final String description;
  final ExperienceType type;

  Experience({
    required this.year,
    required this.title,
    required this.description,
    required this.type,
  });
}

class CompanyValue {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  CompanyValue({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}