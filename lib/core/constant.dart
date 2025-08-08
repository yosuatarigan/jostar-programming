class AppConstants {
  // Company Information
  static const String companyName = 'Jostar Programming';
  static const String companyTagline = 'Mobile App & Website Solutions';
  static const String companyDescription = 
      'Professional Flutter development services for businesses in Indonesia. '
      'Custom mobile apps, websites, and digital solutions.';
  
  // Contact Information
  static const String founderName = 'Yosua Tarigan';
  static const String email = 'yosua@jostar.dev';
  static const String phone = '+62 xxx-xxxx-xxxx'; // Update with real number
  static const String whatsappNumber = '62xxxxxxxxxx'; // Update with real number
  static const String location = 'Medan, Indonesia';
  
  // Social Media Links
  static const String githubUrl = 'https://github.com/yosua-tarigan';
  static const String linkedinUrl = 'https://linkedin.com/in/yosua-tarigan';
  static const String instagramUrl = 'https://instagram.com/jostar.programming';
  static const String youtubeUrl = 'https://youtube.com/@jostarprogramming';
  
  // Website URLs
  static const String websiteUrl = 'https://jostar.dev';
  static const String demoBaseUrl = 'https://demo.jostar.dev';
  
  // Business Hours
  static const String businessHours = 'Senin - Sabtu, 09:00 - 18:00 WIB';
  static const String responseTime = '2-4 jam pada jam kerja';
  
  // Service Areas
  static const List<String> serviceAreas = [
    'Medan',
    'Jakarta', 
    'Surabaya',
    'Bandung',
    'Yogyakarta',
    'Semarang',
    'Makassar',
    'Denpasar',
    'Seluruh Indonesia'
  ];
  
  // Technologies
  static const List<String> mobileTechnologies = [
    'Flutter',
    'Dart',
    'iOS SDK',
    'Android SDK',
    'React Native'
  ];
  
  static const List<String> webTechnologies = [
    'Flutter Web',
    'HTML5',
    'CSS3',
    'JavaScript',
    'React'
  ];
  
  static const List<String> backendTechnologies = [
    'Firebase',
    'Node.js',
    'Express.js',
    'PostgreSQL',
    'MongoDB'
  ];
  
  static const List<String> toolsTechnologies = [
    'Git/GitHub',
    'VS Code',
    'Figma',
    'Adobe XD',
    'Postman'
  ];
  
  // Project Types
  static const List<String> projectTypes = [
    'Mobile App Development',
    'Website Development', 
    'E-commerce Solutions',
    'Custom Development',
    'API Development',
    'UI/UX Design',
    'Consultation Services'
  ];
  
  // App Features
  static const List<String> mobileAppFeatures = [
    'Cross-platform compatibility',
    'Native performance',
    'Push notifications',
    'Offline functionality',
    'Real-time updates',
    'Secure authentication',
    'Payment integration',
    'Social media login'
  ];
  
  static const List<String> websiteFeatures = [
    'Responsive design',
    'SEO optimization',
    'Fast loading speed',
    'Content management',
    'E-commerce functionality',
    'Analytics integration',
    'Security features',
    'Multi-language support'
  ];
  
  // Company Values
  static const List<Map<String, String>> companyValues = [
    {
      'title': 'Kualitas Terbaik',
      'description': 'Mengutamakan kualitas dalam setiap line code dan fitur aplikasi'
    },
    {
      'title': 'Transparansi',
      'description': 'Komunikasi yang jujur dan transparan dalam setiap tahap project'
    },
    {
      'title': 'Efisiensi',
      'description': 'Menyelesaikan project tepat waktu dengan metodologi yang efisien'
    },
    {
      'title': 'Inovasi',
      'description': 'Selalu menggunakan teknologi terdepan dan solusi inovatif'
    }
  ];
  
  // Testimonials
  static const List<Map<String, String>> testimonials = [
    {
      'name': 'Budi Santoso',
      'position': 'CEO TokoBagus',
      'company': 'E-commerce',
      'message': 'Jostar Programming berhasil mengembangkan aplikasi mobile yang sempurna untuk toko online kami. Hasilnya melebihi ekspektasi!',
      'rating': '5'
    },
    {
      'name': 'Sari Dewi', 
      'position': 'Owner RestoKita',
      'company': 'F&B Industry',
      'message': 'Website restaurant yang dibuat sangat profesional dan membantu meningkatkan penjualan online kami hingga 200%.',
      'rating': '5'
    },
    {
      'name': 'Ahmad Rahman',
      'position': 'Director HealthPlus',
      'company': 'Healthcare',
      'message': 'Sistem manajemen rumah sakit yang dibangun sangat user-friendly dan membantu operasional harian kami.',
      'rating': '5'
    }
  ];
  
  // FAQ
  static const List<Map<String, String>> faqs = [
    {
      'question': 'Berapa lama waktu pengembangan aplikasi?',
      'answer': 'Waktu pengembangan bervariasi tergantung kompleksitas. Mobile app sederhana: 1-3 bulan, Website: 2-6 minggu, Aplikasi enterprise: 3-6 bulan.'
    },
    {
      'question': 'Apakah ada garansi setelah project selesai?',
      'answer': 'Ya, kami memberikan garansi bug fixing selama 3-6 bulan setelah project selesai, plus support teknis untuk maintenance.'
    },
    {
      'question': 'Bagaimana sistem pembayaran project?',
      'answer': 'Pembayaran bertahap: 30% di awal, 40% saat development selesai, 30% saat delivery. Untuk project besar bisa dinegosiasi.'
    },
    {
      'question': 'Apakah bisa request fitur tambahan di tengah project?',
      'answer': 'Bisa, namun akan ada additional cost dan adjustment timeline. Kami menggunakan metodologi Agile yang fleksibel untuk perubahan.'
    },
    {
      'question': 'Teknologi apa yang digunakan?',
      'answer': 'Kami menggunakan Flutter untuk mobile, Firebase untuk backend, dan teknologi modern lainnya sesuai kebutuhan project.'
    }
  ];
  
  // Pricing Ranges
  static const List<String> budgetRanges = [
    '< Rp 10 Juta',
    'Rp 10-25 Juta', 
    'Rp 25-50 Juta',
    'Rp 50-100 Juta',
    '> Rp 100 Juta'
  ];
  
  static const List<String> projectTimelines = [
    '< 1 Bulan',
    '1-3 Bulan',
    '3-6 Bulan', 
    '6-12 Bulan',
    '> 1 Tahun'
  ];
  
  // WhatsApp Message Templates
  static String getWhatsAppMessage({
    String? name,
    String? email,
    String? phone,
    String? company,
    String? projectType,
    String? budget,
    String? timeline,
    String? message,
  }) {
    if (name != null && email != null) {
      // Detailed form message
      return 'Halo Jostar Programming!\n\n'
          'Berikut detail konsultasi project saya:\n\n'
          'Nama: $name\n'
          'Email: $email\n'
          'Phone: $phone\n'
          'Company: ${company?.isEmpty == true ? '-' : company}\n'
          'Project Type: $projectType\n'
          'Budget: $budget\n'
          'Timeline: $timeline\n\n'
          'Deskripsi Project:\n$message\n\n'
          'Mohon hubungi saya untuk diskusi lebih lanjut. Terima kasih!';
    } else {
      // Simple message
      return 'Halo Jostar Programming! Saya tertarik untuk konsultasi project digital. '
          'Bisakah kita diskusikan lebih lanjut?';
    }
  }
  
  static String getWhatsAppUrl(String message) {
    final encodedMessage = Uri.encodeComponent(message);
    return 'https://wa.me/$whatsappNumber?text=$encodedMessage';
  }
  
  // Email Templates
  static String getEmailUrl({String? subject, String? body}) {
    String url = 'mailto:$email';
    if (subject != null || body != null) {
      url += '?';
      if (subject != null) {
        url += 'subject=${Uri.encodeComponent(subject)}';
      }
      if (body != null) {
        if (subject != null) url += '&';
        url += 'body=${Uri.encodeComponent(body)}';
      }
    }
    return url;
  }
  
  // Analytics Events (for future implementation)
  static const String eventContactForm = 'contact_form_submit';
  static const String eventWhatsAppClick = 'whatsapp_click';
  static const String eventEmailClick = 'email_click';
  static const String eventPortfolioView = 'portfolio_view';
  static const String eventServiceView = 'service_view';
  static const String eventStoreProductView = 'store_product_view';
}

// Utility class for formatting
class FormatUtils {
  static String formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
  
  static String formatPhoneNumber(String phone) {
    // Remove all non-digits
    phone = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // Add country code if not present
    if (phone.startsWith('08')) {
      phone = '62' + phone.substring(1);
    } else if (phone.startsWith('8')) {
      phone = '62' + phone;
    }
    
    return phone;
  }
  
  static String getInitials(String name) {
    return name.split(' ').map((word) => word.isNotEmpty ? word[0] : '').join('').toUpperCase();
  }
  
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}