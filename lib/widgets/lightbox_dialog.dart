import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

class LightboxDialog extends StatelessWidget {
  final GalleryItem item;

  const LightboxDialog({super.key, required this.item});

  static void show(BuildContext context, GalleryItem item) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.92),
      builder: (context) => LightboxDialog(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Image container
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: width < 600 ? width * 0.94 : width * 0.85,
                maxHeight: height * 0.88,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 40,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: item.isAsset
                            ? Image.asset(
                                item.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 300,
                                  color: AppColors.surface,
                                  child: const Center(
                                    child: Icon(Icons.music_note_rounded, color: AppColors.primary, size: 64),
                                  ),
                                ),
                              )
                            : Image.network(
                                item.imageUrl,
                                fit: BoxFit.contain,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 320,
                                    color: AppColors.surfaceLight,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 300,
                                  color: AppColors.surface,
                                  child: const Center(
                                    child: Icon(Icons.music_note_rounded, color: AppColors.primary, size: 64),
                                  ),
                                ),
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width < 400 ? 14 : 20,
                          vertical: 14,
                        ),
                        color: AppColors.surfaceCard,
                        width: double.infinity,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.primary.withOpacity(0.4)),
                              ),
                              child: Text(
                                item.category.toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
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

            // Close button with protective background
            Positioned(
              top: width < 600 ? 16 : 24,
              right: width < 600 ? 16 : 24,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x990A0F1D),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                  tooltip: "Close",
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
