import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_helper.dart';
import '../widgets/custom_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onScrollDown;
  final VoidCallback? onWatchVideos;

  const HeroSection({
    super.key,
    required this.onScrollDown,
    this.onWatchVideos,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _eqController;
  late AnimationController _pulseController;
  late AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    _eqController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _eqController.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;

    return Padding(
      padding: EdgeInsets.only(
        top: isDesktop ? 48 : (width < 400 ? 20 : 32),
        bottom: isDesktop ? 64 : (width < 400 ? 32 : 44),
      ),
      child: isDesktop ? _buildDesktopHero(context) : _buildMobileHero(context),
    );
  }

  // Desktop Split Hero: Left Text & CTAs, Right Spotlight Artist Visual
  Widget _buildDesktopHero(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Column: Branding, Headline, Tagline, EQ & CTAs
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLiveStatusBadge(),
                  const SizedBox(height: 20),
                  _buildMainHeadline(isCenter: false),
                  const SizedBox(height: 16),
                  _buildMottoBadge(),
                  const SizedBox(height: 22),
                  _buildDescriptionText(isCenter: false),
                  const SizedBox(height: 28),
                  _buildEqualizer(),
                  const SizedBox(height: 32),
                  _buildCtaButtons(),
                  const SizedBox(height: 36),
                  _buildCredentialsRow(),
                ],
              ),
            ),
            const SizedBox(width: 48),

            // Right Column: Centerpiece Artist Spotlight with Glowing Rings
            Expanded(
              flex: 5,
              child: Center(
                child: _buildArtistSpotlight(size: 440),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        _buildScrollIndicator(),
      ],
    );
  }

  // Mobile / Tablet Stacked Hero
  Widget _buildMobileHero(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final double portraitSize = width < 380 ? 250 : (width < 600 ? 290 : 360);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLiveStatusBadge(),
        const SizedBox(height: 16),
        _buildMainHeadline(isCenter: true),
        const SizedBox(height: 12),
        _buildMottoBadge(),
        const SizedBox(height: 28),

        // Glowing Artist Spotlight
        _buildArtistSpotlight(size: portraitSize),
        const SizedBox(height: 28),

        _buildDescriptionText(isCenter: true),
        const SizedBox(height: 24),
        _buildEqualizer(),
        const SizedBox(height: 28),
        _buildCtaButtons(),
        const SizedBox(height: 30),
        _buildCredentialsRow(),
        const SizedBox(height: 36),
        _buildScrollIndicator(),
      ],
    );
  }

  // Live Availability Beacon Badge
  Widget _buildLiveStatusBadge() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, _) {
        final glowAlpha = 0.3 + (_pulseController.value * 0.4);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withOpacity(0.9),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.5),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(glowAlpha * 0.5),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pulsing Green/Cyan Beacon Dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF10B981),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(glowAlpha),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 9),
              Text(
                "LIVE BOOKINGS OPEN • 2026/2027",
                style: TextStyle(
                  fontFamily: AppTheme.fontInter,
                  color: AppColors.primaryLight,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Main Grand Headline: BALU SAXOPHONIST
  Widget _buildMainHeadline({required bool isCenter}) {
    final width = MediaQuery.sizeOf(context).width;
    final double fontSize = width > 1100
        ? 68
        : (width > 768 ? 52 : (width < 380 ? 32 : 38));

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: isCenter ? Alignment.center : Alignment.centerLeft,
      child: RichText(
        textAlign: isCenter ? TextAlign.center : TextAlign.start,
        text: TextSpan(
          style: TextStyle(
            fontFamily: AppTheme.fontPlayfair,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.0,
            height: 1.05,
          ),
          children: [
            const TextSpan(text: "BALU "),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF00E5FF),
                    Color(0xFF67E8F9),
                    Color(0xFF818CF8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  "SAXOPHONIST",
                  style: TextStyle(
                    fontFamily: AppTheme.fontPlayfair,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    shadows: const [
                      Shadow(
                        color: Color(0x9900E5FF),
                        blurRadius: 36,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Motto Pill
  Widget _buildMottoBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.18),
            AppColors.secondary.withOpacity(0.14),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.4)),
      ),
      child: Text(
        BaluSaxData.motto,
        style: const TextStyle(
          fontFamily: AppTheme.fontInter,
          color: AppColors.primaryLight,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.8,
        ),
      ),
    );
  }

  // Tagline & Description
  Widget _buildDescriptionText({required bool isCenter}) {
    final width = MediaQuery.sizeOf(context).width;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Text(
        BaluSaxData.tagline,
        textAlign: isCenter ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontFamily: AppTheme.fontInter,
          fontFamilyFallback: const [
            'system-ui',
            '-apple-system',
            'Segoe UI',
            'Roboto',
            'sans-serif',
          ],
          color: AppColors.textSecondary,
          fontSize: width < 400 ? 13.5 : 15,
          fontWeight: FontWeight.w400,
          height: 1.65,
        ),
      ),
    );
  }

  // Live Sound Equalizer
  Widget _buildEqualizer() {
    return SizedBox(
      height: 44,
      child: AnimatedBuilder(
        animation: _eqController,
        builder: (context, _) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(15, (index) {
              final sinOffset = math.sin((_eqController.value + index * 0.15) * 2 * math.pi);
              final barHeight = 10.0 + (sinOffset.abs() * 32.0);

              final Color baseColor = index % 3 == 0
                  ? AppColors.primary
                  : (index % 3 == 1 ? AppColors.secondary : AppColors.accentRose);

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                width: 4.5,
                height: barHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      baseColor,
                      AppColors.primaryLight,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: baseColor.withOpacity(0.4),
                      blurRadius: 6,
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  // Action CTAs
  Widget _buildCtaButtons() {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      alignment: WrapAlignment.center,
      children: [
        CustomButton(
          text: "Call: 9949008126",
          icon: Icons.phone_in_talk_rounded,
          variant: ButtonVariant.gold,
          onPressed: () => UrlHelper.launchPhone(context, BaluSaxData.phoneDigits),
        ),
        CustomButton(
          text: "WhatsApp",
          icon: Icons.chat_rounded,
          variant: ButtonVariant.ghost,
          onPressed: () => UrlHelper.launchWhatsApp(
            context,
            BaluSaxData.phoneDigits,
            "Hello Balu Saxophonist! Inquiring about performance availability.",
          ),
        ),
        if (widget.onWatchVideos != null)
          CustomButton(
            text: "Watch Live",
            icon: Icons.play_circle_fill_rounded,
            variant: ButtonVariant.ghost,
            onPressed: widget.onWatchVideos,
          ),
      ],
    );
  }

  // Credentials Quick Bar (10+ Yrs, 200+ Shows, 100+ Clients, 20+ Cities)
  Widget _buildCredentialsRow() {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 480;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 14 : 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderCyan),
      ),
      child: Wrap(
        spacing: isSmall ? 10 : 20,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: const [
          _CredBadge(icon: Icons.verified_rounded, text: "6+ Yrs Exp"),
          _CredDivider(),
          _CredBadge(icon: Icons.music_note_rounded, text: "150+ Live Shows"),
          _CredDivider(),
          _CredBadge(icon: Icons.favorite_rounded, text: "100+ Clients"),
          _CredDivider(),
          _CredBadge(icon: Icons.location_on_rounded, text: "Hyd • Vizag • Mumbai"),
        ],
      ),
    );
  }

  // Centerpiece Artist Spotlight with Multi-Layer Concentric Glowing Rings
  Widget _buildArtistSpotlight({required double size}) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Ambient Radial Concert Spotlight
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              final scale = 0.95 + (_pulseController.value * 0.1);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: size * 1.1,
                  height: size * 1.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.24),
                        AppColors.secondary.withOpacity(0.18),
                        AppColors.accentRose.withOpacity(0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Outer Rotating Neon Orbit Ring
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, _) {
              return Transform.rotate(
                angle: _orbitController.value * 2 * math.pi,
                child: Container(
                  width: size * 0.96,
                  height: size * 0.96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.35),
                      width: 1.5,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Counter-Rotating Indigo Orbit Ring
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, _) {
              return Transform.rotate(
                angle: -_orbitController.value * 2 * math.pi,
                child: Container(
                  width: size * 0.88,
                  height: size * 0.88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondary.withOpacity(0.35),
                      width: 1.2,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondary,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Main Glowing Portrait Avatar Frame
          Container(
            width: size * 0.76,
            height: size * 0.76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 3.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 36,
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.3),
                  blurRadius: 24,
                ),
              ],
            ),
            child: ClipOval(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    BaluSaxData.circleWhiteAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surface,
                      child: const Center(
                        child: Icon(Icons.music_note_rounded, size: 64, color: AppColors.primary),
                      ),
                    ),
                  ),
                  // Subtle concert stage dark gradient at the bottom of the photo
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Glass Badge 1: Top Right "Alto Saxophone Artist"
          Positioned(
            top: size * 0.08,
            right: 0,
            child: _buildFloatingGlassBadge(
              icon: Icons.music_note_rounded,
              iconColor: AppColors.primary,
              title: "Alto Saxophone",
              subtitle: "Professional Artist",
            ),
          ),

          // Floating Glass Badge 2: Bottom Left "5.0 ★ Rated • 150+ Shows"
          Positioned(
            bottom: size * 0.08,
            left: 0,
            child: _buildFloatingGlassBadge(
              icon: Icons.star_rate_rounded,
              iconColor: const Color(0xFFFDB813),
              title: "5.0 ★ Top Rated",
              subtitle: "150+ Live Shows",
            ),
          ),
        ],
      ),
    );
  }

  // Floating Glassmorphic Pill Badge
  Widget _buildFloatingGlassBadge({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xDD0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.45),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 14, color: iconColor),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppTheme.fontInter,
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: AppTheme.fontInter,
                  color: AppColors.textMuted,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Scroll Down Mouse Indicator
  Widget _buildScrollIndicator() {
    return InkWell(
      onTap: widget.onScrollDown,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            width: 22,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                width: 3,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "EXPLORE",
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CredBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _CredBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.primary),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontFamily: AppTheme.fontInter,
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CredDivider extends StatelessWidget {
  const _CredDivider();

  @override
  Widget build(BuildContext context) {
    return Text(
      "•",
      style: TextStyle(
        color: AppColors.primary.withOpacity(0.5),
        fontSize: 14,
      ),
    );
  }
}
