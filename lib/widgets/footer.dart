import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_helper.dart';

class Footer extends StatelessWidget {
  final VoidCallback onBackToTop;
  final Function(int) onNavItemSelected;

  const Footer({
    super.key,
    required this.onBackToTop,
    required this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final paddingH = width > 1280
        ? (width - 1200) / 2
        : (width >= 1060
            ? 48.0
            : (width >= 768 ? 32.0 : (width < 380 ? 14.0 : 20.0)));

    return Container(
      width: double.infinity,
      color: AppColors.footerBg,
      padding: EdgeInsets.symmetric(
        horizontal: paddingH,
        vertical: width < 600 ? 40 : 60,
      ),
      child: Column(
        children: [
          // 4 Columns
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              final isTablet = constraints.maxWidth >= 550 && constraints.maxWidth < 900;

              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildBrandCol()),
                    const SizedBox(width: 32),
                    Expanded(flex: 2, child: _buildLinksCol()),
                    const SizedBox(width: 32),
                    Expanded(flex: 3, child: _buildContactCol(context)),
                    const SizedBox(width: 32),
                    Expanded(flex: 2, child: _buildFollowCol(context)),
                  ],
                );
              } else if (isTablet) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildBrandCol()),
                        const SizedBox(width: 24),
                        Expanded(child: _buildLinksCol()),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildContactCol(context)),
                        const SizedBox(width: 24),
                        Expanded(child: _buildFollowCol(context)),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBrandCol(),
                    const SizedBox(height: 32),
                    _buildLinksCol(),
                    const SizedBox(height: 32),
                    _buildContactCol(context),
                    const SizedBox(height: 32),
                    _buildFollowCol(context),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 48),

          // Divider
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.08),
          ),
          const SizedBox(height: 24),

          // Bottom Bar
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              Text(
                "© ${DateTime.now().year} Balu Saxophonist (Bala Raju Ipparthi). Soulful live saxophone performances.",
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
              InkWell(
                onTap: onBackToTop,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderCyan),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "BACK TO TOP",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_upward_rounded, size: 14, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: AppTheme.fontPlayfair,
              fontSize: 24,
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
        const SizedBox(height: 12),
        const Text(
          "Saxophone. Soul. Stories. Bringing acoustic warmth, soulful romantic melodies, and energetic live music to every celebration.",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "QUICK LINKS",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 14),
        _footerLink("Home", () => onNavItemSelected(0)),
        _footerLink("About the Artist", () => onNavItemSelected(1)),
        _footerLink("Signature Music", () => onNavItemSelected(2)),
        _footerLink("Live Videos", () => onNavItemSelected(3)),
        _footerLink("Client Reviews", () => onNavItemSelected(4)),
        _footerLink("Instagram (@balu_music_vibes_)", () => onNavItemSelected(5)),
        _footerLink("Direct Booking (9949008126)", () => onNavItemSelected(6)),
      ],
    );
  }

  Widget _buildContactCol(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "DIRECT CONTACT",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 14),
        InkWell(
          onTap: () => UrlHelper.launchPhone(context, BaluSaxData.phoneDigits),
          child: const Row(
            children: [
              Icon(Icons.phone_rounded, color: AppColors.primary, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  BaluSaxData.phone,
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => UrlHelper.launchWhatsApp(context, BaluSaxData.phoneDigits, "Hello Balu Saxophonist!"),
          child: const Row(
            children: [
              Icon(Icons.chat_rounded, color: Color(0xFF25D366), size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "WhatsApp: 9949008126",
                  style: TextStyle(color: Color(0xFF25D366), fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => UrlHelper.launchEmail(context, BaluSaxData.email),
          child: const Row(
            children: [
              Icon(Icons.email_outlined, color: AppColors.textMuted, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  BaluSaxData.email,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.location_on_outlined, color: AppColors.textMuted, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                BaluSaxData.location,
                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFollowCol(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "FOLLOW ON INSTAGRAM",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 14),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => UrlHelper.launch(context, BaluSaxData.instagramUrl),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF833AB4),
                    Color(0xFFFD1D1D),
                    Color(0xFFFCB045),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE1306C).withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "@balu_music_vibes_",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Follow for daily live clips, performance reels, and event updates.",
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _footerLink(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _SocialCircle extends StatefulWidget {
  final String label;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialCircle({
    required this.label,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialCircle> createState() => _SocialCircleState();
}

class _SocialCircleState extends State<_SocialCircle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered ? AppColors.primary : Colors.transparent,
              border: Border.all(color: AppColors.borderCyan),
            ),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? const Color(0xFF0A0F1D) : AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
