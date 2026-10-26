import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class AnimatedMusicBg extends StatefulWidget {
  final Widget child;

  const AnimatedMusicBg({super.key, required this.child});

  @override
  State<AnimatedMusicBg> createState() => _AnimatedMusicBgState();
}

class _AnimatedMusicBgState extends State<AnimatedMusicBg> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        // Solid Midnight Velvet Obsidian Base
        Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.background,
        ),

        // Ambient Concert Stage Spotlights
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;
            final pulse1 = math.sin(t * 2 * math.pi) * 0.05;
            final pulse2 = math.cos(t * 2 * math.pi) * 0.04;

            return Stack(
              children: [
                // Top Electric Neon Cyan Stage Spotlight (center)
                Positioned(
                  top: -size.height * 0.18,
                  left: size.width * 0.5 - 450,
                  child: Container(
                    width: 900,
                    height: 900,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.18 + pulse1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Top-Left Electric Amethyst Spotlight
                Positioned(
                  top: 60,
                  left: -140,
                  child: Container(
                    width: 550,
                    height: 550,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.accentPurple.withOpacity(0.20 + pulse2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Mid-Right Warm Sunset Rose & Coral Glow
                Positioned(
                  top: size.height * 0.45,
                  right: -160,
                  child: Container(
                    width: 600,
                    height: 600,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.accentRose.withOpacity(0.16 + pulse1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Lower-Left Electric Cyan Shimmer
                Positioned(
                  bottom: -100,
                  left: size.width * 0.2,
                  child: Container(
                    width: 480,
                    height: 480,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.accentCyan.withOpacity(0.08 + pulse2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Floating Multicolored Musical Notes Canvas
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _MusicalNotesPainter(_controller.value),
                );
              },
            ),
          ),
        ),

        // Content
        widget.child,
      ],
    );
  }
}

class _MusicalNotesPainter extends CustomPainter {
  final double progress;

  _MusicalNotesPainter(this.progress);

  static const List<_NoteDef> notes = [
    _NoteDef(symbol: '♪', xRel: 0.08, speed: 1.0, size: 28, seed: 1, colorIndex: 0),
    _NoteDef(symbol: '♫', xRel: 0.22, speed: 0.8, size: 36, seed: 2, colorIndex: 1),
    _NoteDef(symbol: '♬', xRel: 0.42, speed: 1.2, size: 30, seed: 3, colorIndex: 2),
    _NoteDef(symbol: '♩', xRel: 0.62, speed: 0.9, size: 24, seed: 4, colorIndex: 0),
    _NoteDef(symbol: '♫', xRel: 0.80, speed: 1.1, size: 32, seed: 5, colorIndex: 1),
    _NoteDef(symbol: '♪', xRel: 0.94, speed: 0.7, size: 26, seed: 6, colorIndex: 2),
  ];

  static const List<Color> noteColors = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.accentRose,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (final note in notes) {
      final adjustedProg = (progress * note.speed + note.seed * 0.2) % 1.0;
      final y = size.height * (1.0 - adjustedProg);
      final xOffset = math.sin(adjustedProg * 2 * math.pi + note.seed) * 32;
      final x = size.width * note.xRel + xOffset;

      final opacity = math.sin(adjustedProg * math.pi) * 0.5;
      final baseColor = noteColors[note.colorIndex % noteColors.length];

      textPainter.text = TextSpan(
        text: note.symbol,
        style: TextStyle(
          color: baseColor.withOpacity(opacity.clamp(0.0, 1.0)),
          fontSize: note.size,
          shadows: [
            Shadow(
              color: baseColor.withOpacity(opacity * 0.8),
              blurRadius: 18,
            ),
          ],
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant _MusicalNotesPainter oldDelegate) => true;
}

class _NoteDef {
  final String symbol;
  final double xRel;
  final double speed;
  final double size;
  final int seed;
  final int colorIndex;

  const _NoteDef({
    required this.symbol,
    required this.xRel,
    required this.speed,
    required this.size,
    required this.seed,
    this.colorIndex = 0,
  });
}
