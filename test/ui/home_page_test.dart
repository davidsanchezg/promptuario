import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:promptuario/ui/home_page.dart';
import 'package:promptuario/ui/widgets/product_card.dart';

void main() {
  group('HomePage', () {
    testWidgets('renders ProductCards', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const HomePage(),
        ),
      );

      // Wait for the widget to be rendered
      await tester.pumpAndSettle();
      await tester.pump(); // Ensure animations are complete

      // Verify ProductCard content
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('renders mobile layout with AppBar', (tester) async {
      // Set a small screen size to trigger mobile layout
      tester.binding.window.physicalSizeTestValue = const Size(300, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: const HomePage(),
        ),
      );

      // Wait for the widget to be rendered
      await tester.pumpAndSettle();
      await tester.pump(); // Ensure animations are complete

      // Verify AppBar is present
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Promptuario'), findsOneWidget);

      // Verify list view
      expect(find.byType(ListView), findsOneWidget);
      
      // Verify ProductCard content
      for (int i = 0; i < 5; i++) {
        expect(find.text('Item ${i + 1}'), findsOneWidget);
      }
    });

    testWidgets('updates selected index when destination is tapped', (tester) async {
      // Set a large screen size to ensure NavigationRail is visible
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: const HomePage(),
        ),
      );

      // Wait for the widget to be rendered
      await tester.pumpAndSettle();
      await tester.pump(); // Ensure all animations are complete

      // Verify initial state
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);

      // Tap Favorites
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      // Verify Favorites is selected
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
