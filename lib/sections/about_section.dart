import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 950;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width < 600 ? 36 : 60),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _buildPortraitCard(context)),
                const SizedBox(width: 60),
                Expanded(flex: 6, child: _buildTextContent(context)),
              ],
            )
          : Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: _buildPortraitCard(context),
                ),
                SizedBox(height: width < 600 ? 36 : 48),
                _buildTextContent(context),
              ],
            ),
    );
  }

  Widget _buildPortraitCard(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final double cardHeight = width >= 950
        ? 460.0
        : (width >= 600 ? 400.0 : (width < 380 ? 300.0 : 360.0));
    final double offset = width < 480 ? 10.0 : 18.0;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ambient Stage Glow
          Positioned(
            top: -offset,
            left: -offset,
            right: -offset,
            bottom: -offset,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withOpacity(0.25),
                    AppColors.primary.withOpacity(0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Offset Radiant Frame
          Positioned(
            top: offset,
            left: offset,
            right: -offset,
            bottom: -offset,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
            ),
          ),

          // Main Image Card
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: cardHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    BaluSaxData.suitPortraitAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surface,
                      child: const Center(
                        child: Icon(Icons.music_note_rounded, size: 80, color: AppColors.primary),
                      ),
                    ),
                  ),
                  // Dark gradient overlay on bottom of image
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            "Balu Saxophonist",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTheme.fontPlayfair,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                          ),
                          child: const Text(
                            "ALTO SAX",
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          eyebrow: "— About the Artist —",
          titlePrefix: "A Soulful Sound.",
          titleGold: "An Unforgettable",
          titleSuffix: "Experience.",
          isCenter: false,
        ),
        const SizedBox(height: 18),

        const Text(
          BaluSaxData.aboutNarrative,
          style: TextStyle(
            fontFamily: AppTheme.fontInter,
            color: AppColors.textSecondary,
            fontSize: 15,
            fontWeight: FontWeight.w300,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 20),

        // Repertoire list with stylish modern chips
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: BaluSaxData.repertoireHighlights.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderCyan),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.music_note_rounded, color: AppColors.primary, size: 15),
                  const SizedBox(width: 8),
                  Text(
                    item.replaceFirst("✦ ", ""),
                    style: const TextStyle(
                      fontFamily: AppTheme.fontInter,
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),

        // 4 Performance Stat Cards with Glass Borders & Icons
        Container(
          padding: const EdgeInsets.only(top: 24),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.borderCyan)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 520;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BaluSaxData.stats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 4 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: isWide ? 1.4 : 1.6,
                ),
                itemBuilder: (context, index) {
                  final stat = BaluSaxData.stats[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.glassBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(stat.icon, size: 18, color: AppColors.primary),
                            const Spacer(),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stat.value,
                          style: const TextStyle(
                            fontFamily: AppTheme.fontPlayfair,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          stat.label.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTheme.fontInter,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMuted,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
