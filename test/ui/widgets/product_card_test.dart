import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:promptuario/ui/widgets/product_card.dart';

void main() {
  group('ProductCard', () {
    testWidgets('renders with title and default styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(title: 'Test Product'),
        ),
      );

      // Verify title is rendered
      expect(find.text('Test Product'), findsOneWidget);
      // Verify default description is rendered
      expect(find.text('Description goes here'), findsOneWidget);
      // Verify default margin is applied
      final cardFinder = find.byType(Card);
      final cardWidget = tester.widget<Card>(cardFinder);
      expect(cardWidget.margin, const EdgeInsets.only(bottom: 16));
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
      final cardWidget = tester.widget<Card>(cardFinder);
      expect(cardWidget.margin, const EdgeInsets.all(8));
    });
  });
}
