import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

enum ButtonVariant { gold, ghost, ghostSmall, outline }

class CustomButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.variant = ButtonVariant.gold,
    this.isLoading = false,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
    this.borderRadius = 999, // Pill shape button
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Decoration decoration;
    Color textColor = const Color(0xFF0A0F1D);

    switch (widget.variant) {
      case ButtonVariant.gold:
        decoration = BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(_isHovered ? 0.45 : 0.25),
              blurRadius: _isHovered ? 24 : 14,
              offset: const Offset(0, 6),
            ),
          ],
        );
        textColor = const Color(0xFF0A0F1D);
        break;
      case ButtonVariant.ghost:
        decoration = BoxDecoration(
          color: _isHovered ? AppColors.primary.withOpacity(0.14) : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _isHovered ? AppColors.primary : Colors.white.withOpacity(0.4),
            width: 1.4,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        );
        textColor = _isHovered ? AppColors.primaryLight : Colors.white;
        break;
      case ButtonVariant.ghostSmall:
        decoration = BoxDecoration(
          color: _isHovered ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.6),
            width: 1.0,
          ),
        );
        textColor = _isHovered ? const Color(0xFF0A0F1D) : AppColors.primary;
        break;
      case ButtonVariant.outline:
        decoration = BoxDecoration(
          color: _isHovered ? AppColors.primary.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.5),
            width: 1.2,
          ),
        );
        textColor = _isHovered ? AppColors.primaryLight : Colors.white;
        break;
    }

    return MouseRegion(
      cursor: widget.onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedScale(
          scale: _isHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: Container(
            width: widget.width,
            padding: widget.variant == ButtonVariant.ghostSmall
                ? const EdgeInsets.symmetric(horizontal: 18, vertical: 9)
                : widget.padding,
            decoration: decoration,
            child: widget.isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0A0F1D)),
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, size: 16, color: textColor),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          widget.text.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: widget.variant == ButtonVariant.ghostSmall ? 11 : 12,
                            letterSpacing: 1.5,
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
