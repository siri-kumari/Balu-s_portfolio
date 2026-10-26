import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../widgets/lightbox_dialog.dart';
import '../widgets/section_title.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth < 600 ? 36 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            eyebrow: "— Photo Gallery —",
            titlePrefix: "Moments in",
            titleGold: "Motion",
            subtitle:
                "A glimpse into unforgettable stages, acoustic celebrations, and soulful evenings performed live.",
          ),
          SizedBox(height: screenWidth < 600 ? 32 : 48),

          // Responsive Gallery Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final gridWidth = constraints.maxWidth;
              final isDesktop = gridWidth >= 950;
              final crossAxisCount = isDesktop ? 3 : (gridWidth > 600 ? 2 : 1);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BaluSaxData.gallery.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: gridWidth < 600 ? 14 : 20,
                  mainAxisSpacing: gridWidth < 600 ? 16 : 20,
                  childAspectRatio: isDesktop ? 1.0 : (gridWidth > 600 ? 1.05 : 1.15),
                ),
                itemBuilder: (context, index) {
                  final item = BaluSaxData.gallery[index];
                  return _GalleryCard(item: item);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GalleryCard extends StatefulWidget {
  final GalleryItem item;

  const _GalleryCard({required this.item});

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => LightboxDialog.show(context, item),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _isHovered ? AppColors.primary : AppColors.borderCyan,
                width: _isHovered ? 1.5 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered ? AppColors.primary.withOpacity(0.3) : Colors.black.withOpacity(0.3),
                  blurRadius: _isHovered ? 24 : 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                AnimatedScale(
                  scale: _isHovered ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  child: item.isAsset
                      ? Image.asset(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.surfaceLight,
                            child: const Center(
                              child: Icon(Icons.photo_outlined, color: AppColors.primary, size: 40),
                            ),
                          ),
                        )
                      : Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.surfaceLight,
                            child: const Center(
                              child: Icon(Icons.photo_outlined, color: AppColors.primary, size: 40),
                            ),
                          ),
                        ),
                ),

                // Dark hover overlay
                AnimatedOpacity(
                  opacity: _isHovered ? 0.6 : 0.25,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                // Play / Expand icon on hover
                AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0F1D).withOpacity(0.85),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: const Icon(
                        Icons.fullscreen_rounded,
                        color: AppColors.primary,
                        size: 26,
                      ),
                    ),
                  ),
                ),

                // Bottom title banner
                Positioned(
                  bottom: 14,
                  left: 14,
                  right: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTheme.fontPlayfair,
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.primary.withOpacity(0.4)),
                        ),
                        child: Text(
                          item.category.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 9,
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
      ),
    );
  }
}
