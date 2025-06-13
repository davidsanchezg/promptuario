import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:promptuario/ui/widgets/product_card.dart';

void main() {
  group('ProductCard', () {
    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(
            title: 'Test Product',
            seller: 'Test Seller',
            price: 29.99,
            rating: 4.5,
            mediaUrl: 'https://example.com/image.jpg',
            isVideo: false,
          ),
        ),
      );

      // Verify basic info is rendered
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Test Seller'), findsOneWidget);
      expect(find.text('\$29.99'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
    });

    testWidgets('shows video indicator for video products', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(
            title: 'Video Product',
            seller: 'Video Seller',
            price: 39.99,
            rating: 4.7,
            mediaUrl: 'https://example.com/video.mp4',
            isVideo: true,
            thumbnailUrl: 'https://example.com/thumbnail.jpg',
          ),
        ),
      );

      // Verify video indicator is shown (using play_arrow icon)
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('shows error icon for invalid image URL', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductCard(
            title: 'Invalid Image',
            seller: 'Test',
            price: 9.99,
            rating: 3.0,
            mediaUrl: 'invalid-url',
            isVideo: false,
          ),
        ),
      );

      // Pump a frame to allow the error to be caught
      await tester.pump();

      // Should show error icon for invalid URL
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });
  });
}
