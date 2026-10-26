import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class WaveformVisualizer extends StatefulWidget {
  final double height;

  const WaveformVisualizer({super.key, this.height = 100});

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: _WavePainter(_controller.value),
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  final double animationValue;

  _WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final midY = size.height / 2;

    final paint1 = Paint()
      ..shader = AppColors.waveformGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path1 = Path();
    path1.moveTo(0, midY);

    for (double x = 0; x <= size.width; x += 10) {
      final normalizedX = x / size.width;
      final wave1 = math.sin((normalizedX * 4 + animationValue) * 2 * math.pi) * (size.height * 0.35);
      final wave2 = math.cos((normalizedX * 8 - animationValue * 1.5) * 2 * math.pi) * (size.height * 0.15);
      final y = midY + wave1 + wave2;
      path1.lineTo(x, y);
    }

    canvas.drawPath(path1, paint1);

    // Subtle second harmonic wave
    final paint2 = Paint()
      ..color = AppColors.primary.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path2 = Path();
    path2.moveTo(0, midY);
    for (double x = 0; x <= size.width; x += 15) {
      final normalizedX = x / size.width;
      final wave = math.sin((normalizedX * 3 - animationValue * 0.8) * 2 * math.pi) * (size.height * 0.25);
      path2.lineTo(x, midY + wave);
    }

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
