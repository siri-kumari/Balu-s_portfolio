import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../widgets/section_title.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth < 600 ? 36 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            eyebrow: "— Audience & Client Reviews —",
            titlePrefix: "Voices from the",
            titleGold: "Stage & Audience",
            subtitle:
                "Genuine words from wedding couples, luxury hotels, and event directors who experienced Balu's live saxophone magic.",
          ),
          SizedBox(height: screenWidth < 600 ? 32 : 48),

          // Responsive Grid of Testimonials
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 850;
              final double childAspect = isDesktop
                  ? 1.65
                  : (constraints.maxWidth > 500 ? 1.45 : 1.25);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BaluSaxData.testimonials.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 2 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: childAspect,
                ),
                itemBuilder: (context, index) {
                  final item = BaluSaxData.testimonials[index];
                  return _TestimonialCard(item: item);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatefulWidget {
  final TestimonialItem item;

  const _TestimonialCard({required this.item});

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _isHovered = false;

  String _getInitials(String author) {
    final match = RegExp(r'\(([A-Za-z])').firstMatch(author);
    if (match != null) return match.group(1)!;
    final alphaMatch = RegExp(r'[A-Za-z]').firstMatch(author);
    if (alphaMatch != null) return alphaMatch.group(0)!;
    return author.characters.isNotEmpty ? author.characters.first : "B";
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.glassBorder,
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.22)
                  : Colors.black.withOpacity(0.3),
              blurRadius: _isHovered ? 24 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Stars + Quotation Mark Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    item.rating,
                    (index) => const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFDB813),
                      size: 20,
                    ),
                  ),
                ),
                Icon(
                  Icons.format_quote_rounded,
                  color: AppColors.primary.withOpacity(0.4),
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Quote text with Telugu font fallback
            Expanded(
              child: Text(
                "\"${item.quote}\"",
                style: const TextStyle(
                  fontFamily: AppTheme.fontInter,
                  fontFamilyFallback: [
                    'Noto Sans Telugu',
                    'Gautami',
                    'sans-serif',
                  ],
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Client Info & Monogram Avatar
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(item.author),
                      style: const TextStyle(
                        fontFamily: AppTheme.fontPlayfair,
                        color: Color(0xFF0A0F1D),
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              item.author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontPlayfair,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.verified_rounded,
                            size: 15,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontInter,
                          color: AppColors.primaryLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
