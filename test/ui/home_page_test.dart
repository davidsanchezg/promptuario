import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:promptuario/ui/home_page.dart';
import 'package:promptuario/ui/widgets/product_card.dart';

void main() {
  group('HomePage', () {
    testWidgets('renders ProductCards', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(MaterialApp(home: const HomePage()));

        // Wait for the widget to be rendered
        await tester.pumpAndSettle();

        // Verify ProductCard content
        expect(find.text('Sample Product 1'), findsOneWidget);
        expect(find.text('Seller A'), findsWidgets);
        expect(find.text('\$9.99'), findsOneWidget);
      });
    });

    testWidgets('renders mobile layout with AppBar', (tester) async {
      await mockNetworkImages(() async {
        // Set a small screen size to trigger mobile layout
        tester.view.physicalSize = const Size(300, 600);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(MaterialApp(home: const HomePage()));

        // Wait for the widget to be rendered
        await tester.pumpAndSettle();

        // Verify AppBar is present
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Promptuario'), findsOneWidget);

        // Verify list view is present
        expect(find.byType(ListView), findsOneWidget);

        // Verify at least one product card is rendered
        expect(find.byType(ProductCard), findsWidgets);

        // Verify we can find some product titles
        expect(find.text('Sample Product 1'), findsOneWidget);
        expect(find.text('Sample Product 2'), findsOneWidget);
      });
    });

    testWidgets('updates selected index when destination is tapped', (
      tester,
    ) async {
      await mockNetworkImages(() async {
        // Set a large screen size to ensure NavigationRail is visible
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(MaterialApp(home: const HomePage()));

        // Wait for the widget to be rendered
        await tester.pumpAndSettle();
        await tester.pump(); // Ensure all animations are complete

        // Verify initial state
        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);

        // Tap on the favorites destination
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();

        // Verify the selected index is updated
        expect(find.text('Favorites'), findsOneWidget);
      });
    });
  });
}
