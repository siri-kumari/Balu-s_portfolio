import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Balu Saxophonist Portfolio loads properly on desktop', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    expect(find.byType(PortfolioApp), findsOneWidget);
    expect(find.textContaining('Balu', findRichText: true), findsWidgets);
  });

  testWidgets('Balu Saxophonist Portfolio loads properly on mobile', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    expect(find.byType(PortfolioApp), findsOneWidget);
    expect(find.textContaining('Balu', findRichText: true), findsWidgets);
  });
}
