import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_helper.dart';
import 'custom_button.dart';

class Navbar extends StatelessWidget {
  final Function(int) onNavItemSelected;
  final VoidCallback onMenuPressed;
  final int activeIndex;

  const Navbar({
    super.key,
    required this.onNavItemSelected,
    required this.onMenuPressed,
    required this.activeIndex,
  });

  static const List<String> navItems = [
    "Home",
    "About",
    "Music",
    "Videos",
    "Reviews",
    "Instagram",
    "Contact",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1060;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 78,
          padding: EdgeInsets.symmetric(
            horizontal: width > 1300
                ? 36
                : (width > 600 ? 24 : (width < 380 ? 12 : 16)),
          ),
          decoration: const BoxDecoration(
            color: Color(0xEE0A0F1D),
            border: Border(
              bottom: BorderSide(
                color: AppColors.borderCyan,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _buildLogo(context),
                ),
              ),

              // Desktop Menu
              if (isDesktop) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(navItems.length, (index) {
                      final item = navItems[index];
                      final isSelected = activeIndex == index;
                      return _NavItem(
                        title: item,
                        isSelected: isSelected,
                        paddingH: width < 1240 ? 5.0 : 8.0,
                        onTap: () => onNavItemSelected(index),
                      );
                    }),
                    SizedBox(width: width < 1240 ? 8 : 14),
                    CustomButton(
                      text: "Call: 9949008126",
                      icon: Icons.phone_in_talk_rounded,
                      variant: ButtonVariant.gold,
                      padding: EdgeInsets.symmetric(
                        horizontal: width < 1180 ? 12 : 18,
                        vertical: 10,
                      ),
                      onPressed: () => UrlHelper.launchPhone(context, BaluSaxData.phoneDigits),
                    ),
                  ],
                ),
              ] else ...[
                // Mobile Call Icon + Hamburger
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.phone_rounded, color: AppColors.primary, size: 22),
                      padding: width < 380 ? const EdgeInsets.all(6) : const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                      onPressed: () => UrlHelper.launchPhone(context, BaluSaxData.phoneDigits),
                      tooltip: "Call 9949008126",
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, color: AppColors.primary, size: 26),
                      padding: width < 380 ? const EdgeInsets.all(6) : const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                      onPressed: onMenuPressed,
                      tooltip: "Open Menu",
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final fontSize = width < 360 ? 16.0 : (width < 480 ? 18.0 : 22.0);

    return InkWell(
      onTap: () => onNavItemSelected(0),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(
                fontFamily: AppTheme.fontPlayfair,
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.8,
              ),
              children: const [
                TextSpan(text: "Balu "),
                TextSpan(
                  text: "Saxophonist",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontFamily: AppTheme.fontPlayfair,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double paddingH;

  const _NavItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.paddingH = 10.0,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.paddingH, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title.toUpperCase(),
                style: TextStyle(
                  fontFamily: AppTheme.fontInter,
                  color: active ? AppColors.primary : Colors.white.withOpacity(0.9),
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 2.0,
                width: active ? 18 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
