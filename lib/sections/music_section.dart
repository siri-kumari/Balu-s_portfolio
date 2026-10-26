import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../widgets/section_title.dart';
import '../widgets/waveform_visualizer.dart';

class MusicSection extends StatelessWidget {
  final Function(String eventType)? onSetSelected;

  const MusicSection({super.key, this.onSetSelected});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width < 600 ? 36 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            eyebrow: "— Featured Repertoire —",
            titlePrefix: "Signature",
            titleGold: "Musical Sets",
            subtitle:
                "A curated collection of live saxophone performances — soulful romantic tunes, energetic live hits, and grand stage orchestrations.",
          ),
          SizedBox(height: width < 600 ? 32 : 48),

          // 3 Signature Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final cardAreaWidth = constraints.maxWidth;
              final isDesktop = cardAreaWidth >= 950;
              final crossAxisCount = isDesktop ? 3 : (cardAreaWidth > 600 ? 2 : 1);
              final double cardAspectRatio = isDesktop
                  ? 0.76
                  : (cardAreaWidth > 600
                      ? 0.82
                      : (cardAreaWidth < 380 ? 0.74 : 0.80));

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BaluSaxData.signatureSets.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: cardAreaWidth < 600 ? 16 : 24,
                  mainAxisSpacing: cardAreaWidth < 600 ? 20 : 24,
                  childAspectRatio: cardAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final set = BaluSaxData.signatureSets[index];
                  return _PerformanceCard(
                    set: set,
                    onTap: () {
                      if (onSetSelected != null) {
                        onSetSelected!(set.title);
                      }
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 56),

          // Animated Sound Waveform
          const WaveformVisualizer(height: 90),
        ],
      ),
    );
  }
}

class _PerformanceCard extends StatefulWidget {
  final PerformanceSet set;
  final VoidCallback onTap;

  const _PerformanceCard({required this.set, required this.onTap});

  @override
  State<_PerformanceCard> createState() => _PerformanceCardState();
}

class _PerformanceCardState extends State<_PerformanceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final set = widget.set;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.borderCyan,
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? AppColors.primary.withOpacity(0.25) : Colors.black.withOpacity(0.3),
                blurRadius: _isHovered ? 30 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Header with zoom
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedScale(
                        scale: _isHovered ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: set.isAsset
                            ? Image.asset(
                                set.imageUrl,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.surface,
                                  child: const Center(
                                    child: Icon(Icons.music_note_rounded, size: 48, color: AppColors.primary),
                                  ),
                                ),
                              )
                            : Image.network(
                                set.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.surface,
                                  child: const Center(
                                    child: Icon(Icons.music_note_rounded, size: 48, color: AppColors.primary),
                                  ),
                                ),
                              ),
                      ),
                      // Tag badge
                      Positioned(
                        top: 14,
                        right: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0F1D).withOpacity(0.85),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                          ),
                          child: Text(
                            set.tag.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Body
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          set.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTheme.fontPlayfair,
                            color: _isHovered ? AppColors.primaryLight : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            set.description,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontInter,
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "CALL TO BOOK (9949008126)",
                                style: TextStyle(
                                  fontFamily: AppTheme.fontInter,
                                  color: _isHovered ? AppColors.primary : AppColors.textMuted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 13,
                                color: _isHovered ? AppColors.primary : AppColors.textMuted,
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
          ),
        ),
      ),
    );
  }
}
