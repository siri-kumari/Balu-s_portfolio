import 'package:flutter/material.dart';

class AppColors {
  // Deep Oceanic Midnight Slate Backgrounds (Modern concert stage depth, NO pitch black)
  static const Color background = Color(0xFF0A0F1D);
  static const Color surface = Color(0xFF0F172A);
  static const Color surfaceCard = Color(0xFF1E293B);
  static const Color surfaceLight = Color(0xFF283548);
  static const Color footerBg = Color(0xFF070B14);

  // Vibrant Electric Neon Cyan & Aqua Palette (Eye-catching, modern, attractive)
  static const Color primary = Color(0xFF00E5FF); // Electric Neon Cyan
  static const Color primaryLight = Color(0xFF67E8F9); // Radiant Aqua Light
  static const Color primaryDark = Color(0xFF0091EA); // Deep Oceanic Cyan

  // Royal Electric Indigo & Purple
  static const Color secondary = Color(0xFF6366F1); // Royal Indigo
  static const Color secondaryLight = Color(0xFF818CF8);
  static const Color secondaryDark = Color(0xFF4338CA);

  // Vibrant Music Stage Accents
  static const Color accentCyan = Color(0xFF00E5FF); // Electric Cyan
  static const Color accentIndigo = Color(0xFF6366F1); // Royal Indigo
  static const Color accentPurple = Color(0xFF8B5CF6); // Electric Amethyst
  static const Color accentRose = Color(0xFFFF3366); // Sunset Coral / Electric Rose
  static const Color accentBlue = Color(0xFF38BDF8); // Sky Blue
  static const Color accentRed = Color(0xFFFF3366);

  // Aliases for seamless component compatibility (replaces all gold references with vibrant cyan/aqua)
  static const Color gold = primary;
  static const Color goldLight = primaryLight;
  static const Color goldDark = primaryDark;
  static const Color goldLine = Color(0x3800E5FF);

  // Line & Glass Strokes
  static const Color borderCyan = Color(0x3300E5FF);
  static const Color glassBorder = Color(0x2E00E5FF); // 18% Cyan border
  static const Color glassBorderHover = Color(0x8000E5FF); // 50% Cyan glow border
  static const Color glassBg = Color(0x0CFFFFFF);
  static const Color glassBgHover = Color(0x18FFFFFF);

  // Typography
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xCCE2E8F0); // 80% Slate White
  static const Color textMuted = Color(0xFF94A3B8); // Slate Gray

  // Modern Electric Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF00E5FF),
      Color(0xFF38BDF8),
      Color(0xFF6366F1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = primaryGradient;

  static const LinearGradient heroOverlayGradient = LinearGradient(
    colors: [
      Color(0x990A0F1D),
      Color(0xE60A0F1D),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient waveformGradient = LinearGradient(
    colors: [
      Color(0xFF00E5FF), // Electric Cyan
      Color(0xFF38BDF8), // Sky Blue
      Color(0xFF6366F1), // Royal Indigo
      Color(0xFFFF3366), // Sunset Rose
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient stageGlowGradient = LinearGradient(
    colors: [
      Color(0xFF00E5FF),
      Color(0xFF6366F1),
      Color(0xFFFF3366),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardBorderGradient = LinearGradient(
    colors: [
      Color(0x6600E5FF),
      Color(0x336366F1),
      Color(0x0000E5FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
