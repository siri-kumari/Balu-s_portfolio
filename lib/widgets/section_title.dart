import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String titlePrefix;
  final String? titleGold;
  final String? titleSuffix;
  final String? subtitle;
  final bool isCenter;

  const SectionTitle({
    super.key,
    required this.eyebrow,
    required this.titlePrefix,
    this.titleGold,
    this.titleSuffix,
    this.subtitle,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final double titleFontSize = width < 400
        ? 26.0
        : (width < 600 ? 30.0 : (width < 900 ? 34.0 : 38.0));
    final double eyebrowFontSize = width < 400 ? 10.5 : 12.0;
    final double eyebrowLetterSpacing = width < 400 ? 2.5 : 3.5;
    final double subtitleFontSize = width < 400 ? 13.5 : 15.0;

    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Eyebrow
        Text(
          eyebrow.toUpperCase(),
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontFamily: AppTheme.fontInter,
            color: AppColors.primary,
            fontSize: eyebrowFontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: eyebrowLetterSpacing,
          ),
        ),
        const SizedBox(height: 12),

        // Rich Heading with Radiant Accent
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: isCenter ? Alignment.center : Alignment.centerLeft,
          child: RichText(
            textAlign: isCenter ? TextAlign.center : TextAlign.start,
            text: TextSpan(
              style: TextStyle(
                fontFamily: AppTheme.fontPlayfair,
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
              ),
              children: [
                TextSpan(text: titlePrefix),
                if (titleGold != null) ...[
                  const TextSpan(text: " "),
                  TextSpan(
                    text: titleGold,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ],
                if (titleSuffix != null) ...[
                  const TextSpan(text: " "),
                  TextSpan(text: titleSuffix),
                ],
              ],
            ),
          ),
        ),

        // Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                fontFamily: AppTheme.fontInter,
                color: AppColors.textSecondary,
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w300,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
