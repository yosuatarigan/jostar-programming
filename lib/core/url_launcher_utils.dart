import 'package:jostar_programming/core/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  // WhatsApp launcher
  static Future<void> openWhatsApp({String? customMessage}) async {
    final message = customMessage ?? AppConstants.getWhatsAppMessage();
    final url = AppConstants.getWhatsAppUrl(message);
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      print('Error launching WhatsApp: $e');
      // Fallback: copy to clipboard or show error message
    }
  }
  
  // WhatsApp with form data
  static Future<void> openWhatsAppWithFormData({
    required String name,
    required String email,
    required String phone,
    String? company,
    required String projectType,
    required String budget,
    required String timeline,
    required String message,
  }) async {
    final whatsappMessage = AppConstants.getWhatsAppMessage(
      name: name,
      email: email,
      phone: phone,
      company: company,
      projectType: projectType,
      budget: budget,
      timeline: timeline,
      message: message,
    );
    
    await openWhatsApp(customMessage: whatsappMessage);
  }
  
  // Email launcher
  static Future<void> openEmail({String? subject, String? body}) async {
    final url = AppConstants.getEmailUrl(subject: subject, body: body);
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch email';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }
  
  // Phone dialer
  static Future<void> openPhone() async {
    final url = 'tel:${AppConstants.phone}';
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      print('Error launching phone: $e');
    }
  }
  
  // Social media launchers
  static Future<void> openGitHub() async {
    await _launchExternalUrl(AppConstants.githubUrl);
  }
  
  static Future<void> openLinkedIn() async {
    await _launchExternalUrl(AppConstants.linkedinUrl);
  }
  
  static Future<void> openInstagram() async {
    await _launchExternalUrl(AppConstants.instagramUrl);
  }
  
  static Future<void> openYouTube() async {
    await _launchExternalUrl(AppConstants.youtubeUrl);
  }
  
  // Demo URL launcher
  static Future<void> openDemo(String demoPath) async {
    final url = '${AppConstants.demoBaseUrl}/$demoPath';
    await _launchExternalUrl(url);
  }
  
  // Generic external URL launcher
  static Future<void> _launchExternalUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
  
  // Map launcher (Google Maps)
  static Future<void> openGoogleMaps({String? location}) async {
    final query = location ?? AppConstants.location;
    final url = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}';
    await _launchExternalUrl(url);
  }
  
  // Download file (for source codes, etc)
  static Future<void> downloadFile(String fileUrl, String fileName) async {
    try {
      if (await canLaunchUrl(Uri.parse(fileUrl))) {
        await launchUrl(
          Uri.parse(fileUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not download file';
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }
  
  // Share content (for social sharing)
  static Future<void> shareContent({
    required String title,
    required String text,
    String? url,
  }) async {
    final shareUrl = url ?? AppConstants.websiteUrl;
    final shareText = '$text\n\n$shareUrl';
    
    // For web, we'll open a new window or use Web Share API if available
    // For mobile, url_launcher will handle it appropriately
    try {
      final shareLink = 'https://wa.me/?text=${Uri.encodeComponent(shareText)}';
      await _launchExternalUrl(shareLink);
    } catch (e) {
      print('Error sharing content: $e');
    }
  }
}

// Extension methods for easier usage
extension StringUrlLauncher on String {
  Future<void> launch() async {
    await UrlLauncherUtils._launchExternalUrl(this);
  }
}

// Analytics helper (for future implementation)
class AnalyticsHelper {
  static void trackEvent(String eventName, {Map<String, dynamic>? parameters}) {
    // Implement analytics tracking here
    // For example: Firebase Analytics, Google Analytics, etc.
    print('Analytics Event: $eventName with parameters: $parameters');
  }
  
  static void trackContactFormSubmit({
    required String projectType,
    required String budget,
    required String timeline,
  }) {
    trackEvent(AppConstants.eventContactForm, parameters: {
      'project_type': projectType,
      'budget_range': budget,
      'timeline': timeline,
    });
  }
  
  static void trackWhatsAppClick({String? source}) {
    trackEvent(AppConstants.eventWhatsAppClick, parameters: {
      'source': source ?? 'unknown',
    });
  }
  
  static void trackEmailClick({String? source}) {
    trackEvent(AppConstants.eventEmailClick, parameters: {
      'source': source ?? 'unknown',
    });
  }
  
  static void trackPortfolioView(String projectId) {
    trackEvent(AppConstants.eventPortfolioView, parameters: {
      'project_id': projectId,
    });
  }
  
  static void trackServiceView(String serviceName) {
    trackEvent(AppConstants.eventServiceView, parameters: {
      'service_name': serviceName,
    });
  }
  
  static void trackStoreProductView(String productId) {
    trackEvent(AppConstants.eventStoreProductView, parameters: {
      'product_id': productId,
    });
  }
}