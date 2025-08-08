# Jostar Programming Website

Website portfolio dan bisnis untuk Jostar Programming - Mobile App & Website Solutions

## 🚀 Features

- **Responsive Design** - Optimal di semua device (mobile, tablet, desktop)
- **Modern UI/UX** - Clean design dengan animasi smooth
- **Complete Business Website** - Portfolio, Services, Store, About, Contact
- **Ready-to-Use Products Store** - Showcase aplikasi dan source code
- **Contact Form Integration** - Direct WhatsApp integration
- **SEO Optimized** - Structure yang baik untuk search engines

## 📱 Pages

1. **Homepage** - Hero section, services overview, portfolio preview
2. **Services** - Detail layanan, pricing, process, technologies
3. **Portfolio** - Showcase projects dengan filter dan detail
4. **Store** - Aplikasi siap pakai dan source code
5. **About** - Profile Yosua, skills, experience, company values
6. **Contact** - Form konsultasi, info kontak, FAQ

## 🛠️ Tech Stack

- **Framework**: Flutter Web
- **Routing**: go_router
- **Typography**: Google Fonts (Inter)
- **State Management**: Provider (siap untuk implementasi)
- **Styling**: Custom theme dengan Material 3

## 📂 Project Structure

```
lib/
├── main.dart                 # Entry point aplikasi
├── core/
│   ├── app_theme.dart       # Theme dan color system
│   └── app_router.dart      # Routing configuration
├── pages/
│   ├── home_page.dart       # Homepage lengkap
│   ├── services_page.dart   # Services dan pricing
│   ├── portfolio_page.dart  # Portfolio showcase
│   ├── store_page.dart      # Ready apps & source code
│   ├── about_page.dart      # About Yosua & company
│   └── contact_page.dart    # Contact form & info
├── widgets/
│   ├── common/
│   │   ├── custom_button.dart    # Button components
│   │   └── responsive_builder.dart # Responsive helper
│   ├── layout/
│   │   └── main_layout.dart      # Header & footer
│   └── home/
│       ├── hero_section.dart     # Homepage sections
│       ├── services_overview.dart
│       ├── portfolio_preview.dart
│       ├── why_choose_us.dart
│       ├── testimonials.dart
│       └── cta_section.dart
└── assets/
    ├── images/          # General images
    ├── portfolio/       # Portfolio screenshots
    ├── store/          # Product images
    └── icons/          # Custom icons
```

## 🔧 Setup & Installation

### Prerequisites
- Flutter SDK (3.0.0+)
- Dart SDK
- Web browser untuk testing

### Installation Steps

1. **Clone atau buat project baru**
```bash
flutter create jostar_programming
cd jostar_programming
```

2. **Replace pubspec.yaml dengan dependencies yang disediakan**

3. **Copy semua file dart ke folder yang sesuai**

4. **Install dependencies**
```bash
flutter pub get
```

5. **Run di web browser**
```bash
flutter run -d chrome
```

## 🎨 Customization

### Colors
Edit `lib/core/app_theme.dart` untuk mengubah color scheme:
```dart
class AppColors {
  static const Color primary = Color(0xFF1E3A8A);    // Deep Blue
  static const Color secondary = Color(0xFF3B82F6);   // Electric Blue  
  static const Color accent = Color(0xFFF59E0B);      // Orange
  // ... dst
}
```

### Content
- **Portfolio**: Edit data di `portfolio_page.dart` 
- **Services**: Update pricing dan features di `services_page.dart`
- **Store Products**: Modify product list di `store_page.dart`
- **About**: Update personal info di `about_page.dart`
- **Contact**: Configure WhatsApp number di `contact_page.dart`

### Assets
Tambahkan images ke folder `assets/` dan update di `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/portfolio/
    - assets/store/
```

## 📱 WhatsApp Integration

Update nomor WhatsApp di `contact_page.dart`:
```dart
void _openWhatsApp() {
  final message = Uri.encodeComponent('Halo Jostar Programming!...');
  launchUrl(Uri.parse('https://wa.me/62xxxxxxxxxx?text=$message'));
}
```

## 🌐 Deployment

### Flutter Web Build
```bash
flutter build web --release
```

### Deploy ke Hosting
1. **Firebase Hosting**:
```bash
firebase init hosting
firebase deploy
```

2. **Netlify**: Drag & drop folder `build/web`

3. **GitHub Pages**: Push ke repository dan enable Pages

## 📧 Email Configuration

Untuk contact form yang lebih advanced, integrate dengan:
- **EmailJS** untuk client-side email
- **Firebase Functions** untuk server-side processing
- **Formspree** untuk simple form handling

## 🔮 Future Enhancements

- [ ] Admin panel untuk manage content
- [ ] Blog/News section
- [ ] Multi-language support (EN/ID)
- [ ] Analytics integration
- [ ] Payment gateway untuk store
- [ ] Real-time chat support
- [ ] Progressive Web App features

## 📞 Support

Jika ada pertanyaan atau butuh bantuan customization:
- **Email**: yosua@jostar.dev
- **WhatsApp**: +62 xxx-xxxx-xxxx

## 📄 License

Copyright © 2024 Jostar Programming. All rights reserved.

---

**Built with ❤️ using Flutter by Jostar Programming**