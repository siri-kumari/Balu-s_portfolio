import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_helper.dart';
import 'custom_button.dart';

class MobileDrawer extends StatelessWidget {
  final Function(int) onNavItemSelected;
  final int activeIndex;

  const MobileDrawer({
    super.key,
    required this.onNavItemSelected,
    required this.activeIndex,
  });

  static const List<Map<String, dynamic>> navOptions = [
    {"title": "Home", "icon": Icons.home_outlined},
    {"title": "About", "icon": Icons.person_outline_rounded},
    {"title": "Music", "icon": Icons.music_note_outlined},
    {"title": "Videos", "icon": Icons.videocam_outlined},
    {"title": "Reviews", "icon": Icons.star_outline_rounded},
    {"title": "Instagram", "icon": Icons.camera_alt_outlined},
    {"title": "Contact", "icon": Icons.phone_in_talk_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: AppColors.background.withOpacity(0.96),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: AppTheme.fontPlayfair,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(text: "Balu "),
                                TextSpan(
                                  text: "Saxophonist",
                                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: AppColors.primary),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Navigation links
                  Expanded(
                    child: ListView.builder(
                      itemCount: navOptions.length,
                      itemBuilder: (context, index) {
                        final item = navOptions[index];
                        final isSelected = activeIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              onNavItemSelected(index);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary.withOpacity(0.12) : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary.withOpacity(0.4) : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item["icon"] as IconData,
                                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    (item["title"] as String).toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontInter,
                                      color: isSelected ? AppColors.primary : Colors.white,
                                      fontSize: 13,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Direct Call button 9949008126
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Call: 9949008126",
                      icon: Icons.phone_in_talk_rounded,
                      variant: ButtonVariant.gold,
                      onPressed: () {
                        Navigator.of(context).pop();
                        UrlHelper.launchPhone(context, BaluSaxData.phoneDigits);
                      },
                    ),
                  ),
                  const SizedBox(height: 14),

                  // WhatsApp quick link
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        UrlHelper.launchWhatsApp(
                          context,
                          BaluSaxData.phoneDigits,
                          "Hello Balu Saxophonist! Inquiring about performance availability.",
                        );
                      },
                      icon: const Icon(Icons.chat_rounded, color: Color(0xFF25D366), size: 18),
                      label: const Text(
                        "WhatsApp: +91 99490 08126",
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
