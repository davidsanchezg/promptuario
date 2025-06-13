import 'package:flutter/material.dart';

import 'widgets/product_card.dart';
import 'widgets/responsive_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final destinations = [
      const NavigationRailDestination(
        icon: Icon(Icons.home),
        label: Text('Home'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.favorite),
        label: Text('Favorites'),
      ),
    ];

    // Sample product data
    final List<Map<String, dynamic>> sampleProducts = List.generate(10, (index) => {
      'title': 'Sample Product ${index + 1}',
      'seller': 'Seller ${String.fromCharCode(65 + (index % 3))}',
      'price': 9.99 + (index * 5.0),
      'rating': 3.5 + (index % 5) * 0.5,
      'mediaUrl': 'https://picsum.photos/seed/$index/600/400',
      'isVideo': index % 3 == 0,
      'thumbnailUrl': 'https://picsum.photos/seed/thumb$index/300/200',
    });

    return ResponsiveScaffold(
      destinations: destinations,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      appBar: AppBar(
        title: const Text('Promptuario'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1024) {
            // Desktop view - 3 column grid
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: sampleProducts.length,
              itemBuilder: (context, index) {
                final product = sampleProducts[index];
                return ProductCard(
                  title: product['title'],
                  seller: product['seller'],
                  price: product['price'],
                  rating: product['rating'],
                  mediaUrl: product['mediaUrl'],
                  isVideo: product['isVideo'],
                  thumbnailUrl: product['thumbnailUrl'],
                );
              },
            );
          } else {
            // Tablet and mobile view - single column list
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sampleProducts.length,
              itemBuilder: (context, index) {
                final product = sampleProducts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ProductCard(
                    title: product['title'],
                    seller: product['seller'],
                    price: product['price'],
                    rating: product['rating'],
                    mediaUrl: product['mediaUrl'],
                    isVideo: product['isVideo'],
                    thumbnailUrl: product['thumbnailUrl'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
