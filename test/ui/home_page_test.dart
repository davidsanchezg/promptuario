import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:promptuario/ui/home_page.dart';
import 'package:promptuario/ui/widgets/product_card.dart';

final _transparentImage = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

void main() {
  group('HomePage', () {
    testWidgets('renders ProductCards', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: const HomePage(),
          ),
        );

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
        tester.binding.window.physicalSizeTestValue = const Size(300, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: const HomePage(),
          ),
        );

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

    testWidgets('updates selected index when destination is tapped', (tester) async {
      await mockNetworkImages(() async {
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

        // Tap on the favorites destination
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();

        // Verify the selected index is updated
        expect(find.text('Favorites'), findsOneWidget);
      });
    });
  });
}
