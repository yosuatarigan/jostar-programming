import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/responsive_builder.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _projectTypeController = TextEditingController();
  final _budgetController = TextEditingController();
  final _messageController = TextEditingController();
  
  bool _isLoading = false;
  String _selectedProjectType = 'Mobile App';
  String _selectedBudget = '< Rp 10 Juta';
  String _selectedTimeline = '< 1 Bulan';

  final List<String> _projectTypes = [
    'Mobile App',
    'Website',
    'E-commerce',
    'Custom Development',
    'Ready-to-Use App',
    'Consultation',
  ];

  final List<String> _budgetRanges = [
    '< Rp 10 Juta',
    'Rp 10-25 Juta',
    'Rp 25-50 Juta',
    'Rp 50-100 Juta',
    '> Rp 100 Juta',
  ];

  final List<String> _timelines = [
    '< 1 Bulan',
    '1-3 Bulan',
    '3-6 Bulan',
    '6-12 Bulan',
    '> 1 Tahun',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _projectTypeController.dispose();
    _budgetController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildContactSection(context),
          _buildLocationSection(context),
          _buildFAQSection(context),
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '📞 HUBUNGI KAMI',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Mari Wujudkan Project Digital Anda',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: ScreenSize.isMobile(context) ? 32 : 48,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Konsultasi gratis untuk mendiskusikan kebutuhan digital bisnis Anda',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildQuickContactButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickContactButtons(BuildContext context) {
    return ResponsiveBuilder(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton.large(
            text: 'WhatsApp Langsung',
            icon: const Icon(Icons.chat, color: AppColors.textLight),
            backgroundColor: AppColors.success,
            onPressed: () => _openWhatsApp(),
          ),
          const SizedBox(height: 16),
          CustomButton.secondary(
            text: 'Isi Form Konsultasi',
            onPressed: () => _scrollToForm(),
          ),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton.large(
            text: 'WhatsApp Langsung',
            icon: const Icon(Icons.chat, color: AppColors.textLight),
            backgroundColor: AppColors.success,
            onPressed: () => _openWhatsApp(),
          ),
          const SizedBox(width: 24),
          CustomButton.secondary(
            text: 'Isi Form Konsultasi',
            onPressed: () => _scrollToForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
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
          child: ResponsiveBuilder(
            mobile: _buildMobileContact(context),
            desktop: _buildDesktopContact(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContact(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildContactForm(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildContactInfo(context),
        ),
      ],
    );
  }

  Widget _buildMobileContact(BuildContext context) {
    return Column(
      children: [
        _buildContactInfo(context),
        const SizedBox(height: 40),
        _buildContactForm(context),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Form Konsultasi Project',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Isi form di bawah untuk mendapatkan konsultasi gratis',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            
            // Name Field
            _buildTextFormField(
              controller: _nameController,
              label: 'Nama Lengkap *',
              hint: 'Masukkan nama lengkap Anda',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Email Field
            _buildTextFormField(
              controller: _emailController,
              label: 'Email *',
              hint: 'contoh@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Format email tidak valid';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Phone Field
            _buildTextFormField(
              controller: _phoneController,
              label: 'Nomor WhatsApp *',
              hint: '08123456789',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor WhatsApp tidak boleh kosong';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Company Field
            _buildTextFormField(
              controller: _companyController,
              label: 'Nama Perusahaan',
              hint: 'PT. Contoh Indonesia (opsional)',
              icon: Icons.business_outlined,
            ),
            
            const SizedBox(height: 20),
            
            // Project Type Dropdown
            _buildDropdownField(
              label: 'Tipe Project *',
              value: _selectedProjectType,
              items: _projectTypes,
              onChanged: (value) {
                setState(() {
                  _selectedProjectType = value!;
                });
              },
              icon: Icons.work_outline,
            ),
            
            const SizedBox(height: 20),
            
            // Budget Dropdown
            _buildDropdownField(
              label: 'Budget Range *',
              value: _selectedBudget,
              items: _budgetRanges,
              onChanged: (value) {
                setState(() {
                  _selectedBudget = value!;
                });
              },
              icon: Icons.attach_money,
            ),
            
            const SizedBox(height: 20),
            
            // Timeline Dropdown
            _buildDropdownField(
              label: 'Timeline Project *',
              value: _selectedTimeline,
              items: _timelines,
              onChanged: (value) {
                setState(() {
                  _selectedTimeline = value!;
                });
              },
              icon: Icons.schedule,
            ),
            
            const SizedBox(height: 20),
            
            // Message Field
            _buildTextFormField(
              controller: _messageController,
              label: 'Deskripsi Project *',
              hint: 'Jelaskan detail project yang ingin Anda buat...',
              icon: Icons.message_outlined,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi project tidak boleh kosong';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 32),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: CustomButton.large(
                text: _isLoading ? 'Mengirim...' : 'Kirim Konsultasi',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _submitForm,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              'Dengan mengirim form ini, Anda setuju untuk dihubungi oleh tim Jostar Programming',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.neutral.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          )).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.neutral.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Kontak',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hubungi kami melalui berbagai channel yang tersedia',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        
        // Contact Items
        _buildContactItem(
          context,
          icon: Icons.phone,
          title: 'WhatsApp',
          description: '+62 xxx-xxxx-xxxx',
          subtitle: 'Respons cepat 24/7',
          color: AppColors.success,
          onTap: () => _openWhatsApp(),
        ),
        
        const SizedBox(height: 20),
        
        _buildContactItem(
          context,
          icon: Icons.email,
          title: 'Email',
          description: 'yosua@jostar.dev',
          subtitle: 'Respons dalam 2-4 jam',
          color: AppColors.primary,
          onTap: () => _openEmail(),
        ),
        
        const SizedBox(height: 20),
        
        _buildContactItem(
          context,
          icon: Icons.schedule,
          title: 'Jam Operasional',
          description: 'Senin - Sabtu',
          subtitle: '09:00 - 18:00 WIB',
          color: AppColors.secondary,
        ),
        
        const SizedBox(height: 20),
        
        _buildContactItem(
          context,
          icon: Icons.location_on,
          title: 'Lokasi',
          description: 'Medan, Indonesia',
          subtitle: 'Melayani seluruh Indonesia',
          color: AppColors.accent,
        ),
        
        const SizedBox(height: 32),
        
        // Social Media
        Text(
          'Ikuti Kami',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            _buildSocialButton(
              context,
              icon: Icons.code,
              label: 'GitHub',
              color: AppColors.neutral,
              onTap: () => {},
            ),
            const SizedBox(width: 12),
            _buildSocialButton(
              context,
              icon: Icons.work,
              label: 'LinkedIn',
              color: AppColors.primary,
              onTap: () => {},
            ),
            const SizedBox(width: 12),
            _buildSocialButton(
              context,
              icon: Icons.photo_camera,
              label: 'Instagram',
              color: AppColors.error,
              onTap: () => {},
            ),
          ],
        ),
        
        const SizedBox(height: 32),
        
        // Response Time Promise
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.success.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Jaminan Respons Cepat',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Kami berkomitmen merespons dalam 2 jam untuk WhatsApp dan 4 jam untuk email pada jam kerja.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.neutral.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textSecondary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
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
                'Melayani Seluruh Indonesia',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Dengan teknologi modern, kami dapat melayani klien di seluruh Indonesia',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildServiceAreas(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceAreas(BuildContext context) {
    final areas = [
      ServiceArea(
        city: 'Medan',
        description: 'Base Location - Meeting Offline Available',
        icon: Icons.home,
        color: AppColors.primary,
      ),
      ServiceArea(
        city: 'Jakarta',
        description: 'Regular Clients - Video Call Support',
        icon: Icons.business,
        color: AppColors.secondary,
      ),
      ServiceArea(
        city: 'Surabaya',
        description: 'Active Projects - Remote Collaboration',
        icon: Icons.location_city,
        color: AppColors.accent,
      ),
      ServiceArea(
        city: 'Bandung',
        description: 'Tech Community - Developer Network',
        icon: Icons.apartment,
        color: AppColors.success,
      ),
    ];

    return ResponsiveBuilder(
      mobile: Column(
        children: areas.map((area) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildServiceAreaCard(context, area),
        )).toList(),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 2.5,
        ),
        itemCount: areas.length,
        itemBuilder: (context, index) => _buildServiceAreaCard(context, areas[index]),
      ),
    );
  }

  Widget _buildServiceAreaCard(BuildContext context, ServiceArea area) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: area.color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: area.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              area.icon,
              color: area.color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  area.city,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  area.description,
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

  Widget _buildFAQSection(BuildContext context) {
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
                'Frequently Asked Questions',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              _buildFAQList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQList(BuildContext context) {
    final faqs = [
      FAQ(
        question: 'Berapa lama waktu pengembangan aplikasi?',
        answer: 'Waktu pengembangan bervariasi tergantung kompleksitas. Mobile app sederhana: 1-3 bulan, Website: 2-6 minggu, Aplikasi enterprise: 3-6 bulan.',
      ),
      FAQ(
        question: 'Apakah ada garansi setelah project selesai?',
        answer: 'Ya, kami memberikan garansi bug fixing selama 3-6 bulan setelah project selesai, plus support teknis untuk maintenance.',
      ),
      FAQ(
        question: 'Bagaimana sistem pembayaran project?',
        answer: 'Pembayaran bertahap: 30% di awal, 40% saat development selesai, 30% saat delivery. Untuk project besar bisa dinegosiasi.',
      ),
      FAQ(
        question: 'Apakah bisa request fitur tambahan di tengah project?',
        answer: 'Bisa, namun akan ada additional cost dan adjustment timeline. Kami menggunakan metodologi Agile yang fleksibel untuk perubahan.',
      ),
      FAQ(
        question: 'Teknologi apa yang digunakan?',
        answer: 'Kami menggunakan Flutter untuk mobile, Firebase untuk backend, dan teknologi modern lainnya sesuai kebutuhan project.',
      ),
    ];

    return Column(
      children: faqs.map((faq) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: _buildFAQItem(context, faq),
      )).toList(),
    );
  }

  Widget _buildFAQItem(BuildContext context, FAQ faq) {
    return ExpansionTile(
      title: Text(
        faq.question,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            faq.answer,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
      backgroundColor: AppColors.surface,
      collapsedBackgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.neutral.withOpacity(0.2)),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.neutral.withOpacity(0.2)),
      ),
    );
  }

  void _scrollToForm() {
    // Implement scroll to form functionality
  }

  void _openWhatsApp() {
    final message = Uri.encodeComponent(
      'Halo Jostar Programming! Saya tertarik untuk konsultasi project digital. '
      'Bisakah kita diskusikan lebih lanjut?'
    );
    // In real implementation, use url_launcher to open WhatsApp
    // launchUrl(Uri.parse('https://wa.me/62xxxxxxxxxx?text=$message'));
  }

  void _openEmail() {
    // In real implementation, use url_launcher to open email
    // launchUrl(Uri.parse('mailto:yosua@jostar.dev'));
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate form submission
      await Future.delayed(const Duration(seconds: 2));
      
      // Create WhatsApp message with form data
      final message = Uri.encodeComponent(
        'Halo Jostar Programming!\n\n'
        'Berikut detail konsultasi project saya:\n\n'
        'Nama: ${_nameController.text}\n'
        'Email: ${_emailController.text}\n'
        'Phone: ${_phoneController.text}\n'
        'Company: ${_companyController.text.isEmpty ? '-' : _companyController.text}\n'
        'Project Type: $_selectedProjectType\n'
        'Budget: $_selectedBudget\n'
        'Timeline: $_selectedTimeline\n\n'
        'Deskripsi Project:\n${_messageController.text}\n\n'
        'Mohon hubungi saya untuk diskusi lebih lanjut. Terima kasih!'
      );
      
      setState(() {
        _isLoading = false;
      });
      
      // Show success dialog
      _showSuccessDialog();
      
      // In real implementation, send to WhatsApp
      // launchUrl(Uri.parse('https://wa.me/62xxxxxxxxxx?text=$message'));
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.success,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Form Terkirim!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Terima kasih! Kami akan segera menghubungi Anda melalui WhatsApp dalam 2 jam.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          CustomButton.primary(
            text: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
              _clearForm();
            },
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _companyController.clear();
    _messageController.clear();
    setState(() {
      _selectedProjectType = 'Mobile App';
      _selectedBudget = '< Rp 10 Juta';
      _selectedTimeline = '< 1 Bulan';
    });
  }
}

// Data Models
class ServiceArea {
  final String city;
  final String description;
  final IconData icon;
  final Color color;

  ServiceArea({
    required this.city,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });
}