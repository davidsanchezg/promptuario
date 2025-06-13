import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:promptuario/ui/widgets/responsive_scaffold.dart';

void main() {
  group('ResponsiveScaffold', () {
    testWidgets('renders desktop layout with NavigationRail', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveScaffold(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favorites'),
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (index) {},
            body: const Text('Body'),
          ),
        ),
      );

      // Verify NavigationRail is present
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
    });

    testWidgets('renders mobile layout with AppBar', (tester) async {
      // Set a small screen size to trigger mobile layout
      tester.view.physicalSize = const Size(300, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveScaffold(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (index) {},
            appBar: AppBar(title: const Text('Test Title')),
            body: const Text('Body'),
          ),
        ),
      );

      // Verify AppBar is present
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });


  });
}
