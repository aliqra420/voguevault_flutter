import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voguevault/screens/auth/login_screen.dart';
import 'package:voguevault/screens/home/home_screen.dart';
import 'package:voguevault/screens/product/product_details_screen.dart';
import 'package:voguevault/screens/product/show_all_products_screen.dart';
import 'package:voguevault/screens/profile/profile_screen.dart';
import 'package:voguevault/widgets/home/feature_products.dart';
import 'package:voguevault/widgets/home/men_hero_banner.dart';
import 'package:voguevault/widgets/home/top_collection.dart';
import 'package:voguevault/widgets/product_card.dart';

void main() {
  testWidgets('Home screen uses the mixed category carousel for the default Women view', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.byType(MenHeroBanner), findsOneWidget);
  });

  testWidgets('Tapping a feature product opens the product details screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: FeatureProducts(category: 'Women'))));

    await tester.tap(find.text('Sportwear Set'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductDetailsScreen), findsOneWidget);
  });

  testWidgets('Tapping the hero carousel opens the matching collection screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MenHeroBanner(category: 'Women')));

    await tester.tap(find.byType(Image).first, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.byType(ShowAllProductsScreen), findsOneWidget);
  });

  testWidgets('Tapping Show all opens the category-aware products screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ShowAllProductsScreen(section: 'Feature', category: 'Women')));

    expect(find.byType(ShowAllProductsScreen), findsOneWidget);
    expect(find.text('Women'), findsWidgets);
    expect(find.text('Feature Products'), findsOneWidget);
  });

  testWidgets('Top Collection show all shows only the preview products for the selected category', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ShowAllProductsScreen(section: 'Top Collection', category: 'Women')));

    expect(find.text('Slim Beauty'), findsOneWidget);
    expect(find.text('Fabulous Design'), findsOneWidget);
    expect(find.text('Sportwear Set'), findsNothing);
    expect(find.byType(ProductCard), findsWidgets);
  });

  testWidgets('Tapping a top collection card opens the product details screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TopCollection(category: 'Women')));

    await tester.tap(find.textContaining('FOR SLIM'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductDetailsScreen), findsOneWidget);
  });

  testWidgets('Tapping log out navigates to the login screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
