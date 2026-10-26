import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_helper.dart';
import '../widgets/section_title.dart';

class InstagramSection extends StatelessWidget {
  const InstagramSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth < 600 ? 36 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            eyebrow: "— Live Stories & Reels —",
            titlePrefix: "Connect on",
            titleGold: "Instagram",
            subtitle:
                "Catch daily saxophone reels, live wedding highlights, concert stories, and performance updates with Balu Saxophonist.",
          ),
          SizedBox(height: screenWidth < 600 ? 32 : 48),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: _InstagramFeatureCard(),
          ),
        ],
      ),
    );
  }
}

class _InstagramFeatureCard extends StatefulWidget {
  @override
  State<_InstagramFeatureCard> createState() => _InstagramFeatureCardState();
}

class _InstagramFeatureCardState extends State<_InstagramFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 720;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? const Color(0xFFE1306C) : AppColors.borderCyan,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? const Color(0xFFE1306C).withOpacity(0.25)
                  : Colors.black.withOpacity(0.3),
              blurRadius: _isHovered ? 36 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(width < 400 ? 16 : (width < 600 ? 22 : 32)),
          child: Column(
            children: [
              // Top Profile Bar
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildAvatar(),
                        const SizedBox(width: 22),
                        Expanded(child: _buildProfileInfo()),
                        const SizedBox(width: 20),
                        _buildFollowButton(context),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildAvatar(),
                        const SizedBox(height: 16),
                        _buildProfileInfo(centerAlign: true),
                        const SizedBox(height: 20),
                        _buildFollowButton(context),
                      ],
                    ),

              const SizedBox(height: 28),

              // Decorative Instagram Highlights Grid
              const Divider(color: Color(0x22FFFFFF), height: 1),
              const SizedBox(height: 24),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 600;
                  return isWide
                      ? Row(
                          children: [
                            Expanded(
                              child: _buildHighlightTile(
                                context,
                                icon: Icons.music_note_rounded,
                                title: "Soulful Reels",
                                tag: "@balu_music_vibes_",
                                subtitle: "Acoustic saxophone melodies & trending romantic hits",
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildHighlightTile(
                                context,
                                icon: Icons.stars_rounded,
                                title: "Stage Highlights",
                                tag: "Live Concerts",
                                subtitle: "Electrifying concert solos & wedding entry moments",
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildHighlightTile(
                                context,
                                icon: Icons.video_collection_outlined,
                                title: "Behind The Scenes",
                                tag: "Rehearsals",
                                subtitle: "Studio practice sessions & live jamming updates",
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _buildHighlightTile(
                              context,
                              icon: Icons.music_note_rounded,
                              title: "Soulful Reels",
                              tag: "@balu_music_vibes_",
                              subtitle: "Acoustic saxophone melodies & trending romantic hits",
                            ),
                            const SizedBox(height: 12),
                            _buildHighlightTile(
                              context,
                              icon: Icons.stars_rounded,
                              title: "Stage Highlights",
                              tag: "Live Concerts",
                              subtitle: "Electrifying concert solos & wedding entry moments",
                            ),
                            const SizedBox(height: 12),
                            _buildHighlightTile(
                              context,
                              icon: Icons.video_collection_outlined,
                              title: "Behind The Scenes",
                              tag: "Rehearsals",
                              subtitle: "Studio practice sessions & live jamming updates",
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(3.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFF833AB4),
            Color(0xFFFD1D1D),
            Color(0xFFFCB045),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(2.5),
        decoration: const BoxDecoration(
          color: Color(0xFF0A0F1D),
          shape: BoxShape.circle,
        ),
        child: const CircleAvatar(
          radius: 38,
          backgroundImage: AssetImage(BaluSaxData.circleWhiteAsset),
        ),
      ),
    );
  }

  Widget _buildProfileInfo({bool centerAlign = false}) {
    return Column(
      crossAxisAlignment: centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
          children: [
            Text(
              BaluSaxData.fullName,
              style: const TextStyle(
                fontFamily: AppTheme.fontPlayfair,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.verified_rounded,
              color: Color(0xFF3897F0),
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          BaluSaxData.instagramHandle,
          style: const TextStyle(
            color: Color(0xFFE1306C),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Professional Alto Saxophonist • Weddings • Concerts • Private Galas",
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildFollowButton(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlHelper.launch(context, BaluSaxData.instagramUrl),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width < 400 ? 18 : 24,
            vertical: width < 400 ? 12 : 14,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF833AB4),
                Color(0xFFE1306C),
                Color(0xFFFD1D1D),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE1306C).withOpacity(0.4),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(
                  "OPEN INSTAGRAM",
                  style: TextStyle(
                    fontFamily: AppTheme.fontInter,
                    color: Colors.white,
                    fontSize: width < 400 ? 12 : 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_outward_rounded, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String tag,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () => UrlHelper.launch(context, BaluSaxData.instagramUrl),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1306C).withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: const Color(0xFFE1306C), size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  "Watch on Instagram",
                  style: TextStyle(
                    color: Color(0xFFE1306C),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, color: Color(0xFFE1306C), size: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
