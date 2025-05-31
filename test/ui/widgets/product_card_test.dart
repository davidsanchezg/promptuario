import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:promptuario/ui/widgets/product_card.dart';

void main() {
  group('ProductCard', () {
    testWidgets('renders with title and description', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(title: 'Test Product'),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Description goes here'), findsOneWidget);
    });

    testWidgets('applies custom margin when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(
            title: 'Test Product',
            margin: const EdgeInsets.all(8),
          ),
        ),
      );

      final cardFinder = find.byType(Card);
      expect(cardFinder, findsOneWidget);

      final cardWidget = tester.widget<Card>(cardFinder);
      expect(cardWidget.margin, const EdgeInsets.all(8));
    });

    testWidgets('uses default margin when not provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(title: 'Test Product'),
        ),
      );

      final cardFinder = find.byType(Card);
      expect(cardFinder, findsOneWidget);

      final cardWidget = tester.widget<Card>(cardFinder);
      expect(cardWidget.margin, const EdgeInsets.only(bottom: 16));
    });

    testWidgets('uses titleMedium text style for title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(title: 'Test Product'),
        ),
      );

      final textFinder = find.text('Test Product');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(
        textWidget.style,
        equals(Theme.of(tester.element(textFinder)).textTheme.titleMedium),
      );
    });
  });
}
