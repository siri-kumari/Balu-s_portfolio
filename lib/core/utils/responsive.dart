import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isSmallMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 380;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 768 &&
      MediaQuery.sizeOf(context).width < 1060;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1060;

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > 1280) {
      return (width - 1200) / 2;
    } else if (width >= 1060) {
      return 48;
    } else if (width >= 768) {
      return 32;
    } else if (width >= 380) {
      return 20;
    } else {
      return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1060) {
      return desktop;
    } else if (width >= 768 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
