import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> launch(BuildContext context, String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      bool launched = false;
      try {
        launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (_) {
        launched = false;
      }
      if (!launched) {
        launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open link: $urlString'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  static Future<void> launchWhatsApp(BuildContext context, String phoneDigits, String text) async {
    final cleanDigits = phoneDigits.replaceAll(RegExp(r'\D'), '');
    final encoded = Uri.encodeComponent(text);
    final nativeUri = Uri.parse("whatsapp://send?phone=$cleanDigits&text=$encoded");
    final webUri = Uri.parse("https://wa.me/$cleanDigits?text=$encoded");

    bool launched = false;
    // On native mobile platforms, try launching WhatsApp app directly
    if (!kIsWeb) {
      try {
        launched = await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
      } catch (_) {
        launched = false;
      }
    }

    // Universal WhatsApp web / mobile redirection link
    if (!launched) {
      try {
        launched = await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } catch (_) {
        launched = false;
      }
    }

    if (!launched) {
      try {
        launched = await launchUrl(webUri, mode: LaunchMode.platformDefault);
      } catch (_) {
        launched = false;
      }
    }

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('WhatsApp: +$cleanDigits'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  static Future<void> launchYouTube(BuildContext context, String videoId) async {
    final url = "https://www.youtube.com/watch?v=$videoId";
    await launch(context, url);
  }

  static Future<void> launchEmail(BuildContext context, String email, {String? subject, String? body}) async {
    final Map<String, String> queryParams = {};
    if (subject != null) queryParams['subject'] = subject;
    if (body != null) queryParams['body'] = body;

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
    try {
      final launched = await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
      if (!launched) {
        await launchUrl(emailLaunchUri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contact email: $email'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  static Future<void> launchPhone(BuildContext context, String phoneNumber) async {
    // Sanitize phone number so spaces, dashes and non-numeric characters don't break dialpad
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    if (!cleanNumber.startsWith('+')) {
      if (cleanNumber.startsWith('91') && cleanNumber.length == 12) {
        cleanNumber = '+$cleanNumber';
      } else if (cleanNumber.length == 10) {
        cleanNumber = '+91$cleanNumber';
      }
    }

    final Uri phoneUri = Uri.parse("tel:$cleanNumber");
    try {
      bool launched = false;
      try {
        launched = await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } catch (_) {
        launched = false;
      }
      if (!launched) {
        launched = await launchUrl(phoneUri, mode: LaunchMode.platformDefault);
      }
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Call: $cleanNumber'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Call: $cleanNumber'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
