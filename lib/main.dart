import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'views/portfolio_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balu Saxophonist | Professional Alto Saxophone Artist',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.luxuryTheme,
      home: const PortfolioHomePage(),
    );
  }
}
