import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promptuario/ui/widgets/category_chip.dart';
import 'package:promptuario/ui/widgets/product_card.dart';
import 'package:promptuario/ui/widgets/search_bar.dart' show SearchBarWidget;
import 'package:promptuario/ui/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'All',
    'AI Art',
    'Writing',
    'Marketing',
    'Code',
    'Video',
    'Music',
  ];

  // Sample data for featured products
  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'id': '1',
      'title': 'AI Art Generator Pro',
      'seller': 'AI Creative Labs',
      'price': 29.99,
      'rating': 4.8,
      'category': 'Art',
      'mediaUrl': 'https://picsum.photos/seed/ai-art/600/400',
      'thumbnailUrl': 'https://picsum.photos/seed/ai-art-thumb/300/200',
      'isVideo': false,
    },
    {
      'id': '2',
      'title': 'Code Assistant X',
      'seller': 'DevTools Inc',
      'price': 49.99,
      'rating': 4.9,
      'category': 'Development',
      'mediaUrl': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcjFtbjZlc3l2eWxwZ2NxZzV4dWt4aGd3Y2JqZ2VqY2VnZ3V4dSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7TKtq7mQxJmQx9K0/giphy.gif',
      'thumbnailUrl': 'https://picsum.photos/seed/code-assistant-thumb/300/200',
      'isVideo': true,
    },
    {
      'id': '3',
      'title': 'AI Art Generator Pro',
      'seller': 'AI Studio',
      'price': 29.99,
      'rating': 4.8,
      'category': 'Art',
      'mediaUrl': 'https://picsum.photos/seed/5/600/400',
      'thumbnailUrl': 'https://picsum.photos/seed/5-thumb/300/200',
      'isVideo': false,
    },
    {
      'id': '4',
      'title': 'ChatGPT Plus',
      'seller': 'OpenAI',
      'price': 19.99,
      'rating': 4.9,
      'category': 'Chat',
      'mediaUrl': 'https://picsum.photos/seed/6/600/400',
      'thumbnailUrl': 'https://picsum.photos/seed/6-thumb/300/200',
      'isVideo': false,
    },
    {
      'id': '5',
      'title': 'Code Complete AI',
      'seller': 'DevTools',
      'price': 39.99,
      'rating': 4.7,
      'category': 'Development',
      'mediaUrl': 'https://picsum.photos/seed/7/600/400',
      'thumbnailUrl': 'https://picsum.photos/seed/7-thumb/300/200',
      'isVideo': true,
    },
    {
      'id': '6',
      'title': 'Marketing Pro',
      'seller': 'GrowthHack',
      'price': 24.99,
      'rating': 4.6,
      'category': 'Marketing',
      'mediaUrl': 'https://picsum.photos/seed/8/600/400',
      'thumbnailUrl': 'https://picsum.photos/seed/8-thumb/300/200',
      'isVideo': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final isMediumScreen = MediaQuery.of(context).size.width < 1000;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Promptuario',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 26),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            SearchBarWidget(
              controller: _searchController,
              hintText: 'Search for AI tools, prompts...',
              onChanged: (value) {},
              onSearchPressed: () {},
            ),
            const SizedBox(height: 24),

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  _categories.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CategoryChip(
                      label: _categories[index],
                      isSelected: _selectedCategoryIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Featured Section
            SectionHeader(
              title: 'Featured Tools',
              actionText: 'See All',
              onActionPressed: () {},
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 280, // Slightly taller to accommodate the new card design
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = _featuredProducts[index];
                  return SizedBox(
                    width: 220, // Slightly narrower for better mobile view
                    child: ProductCard(
                      title: product['title'],
                      price: product['price'],
                      rating: product['rating'] is double ? product['rating'] : (product['rating'] as num).toDouble(),
                      seller: product['seller'],
                      mediaUrl: product['mediaUrl'] ?? 'https://picsum.photos/seed/featured-$index/600/400',
                      thumbnailUrl: product['thumbnailUrl'] ?? 'https://picsum.photos/seed/featured-thumb-$index/300/200',
                      isVideo: product['isVideo'] == true,
                      margin: const EdgeInsets.only(right: 16),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // Latest Products
            SectionHeader(
              title: 'Latest AI Tools',
              actionText: 'View All',
              onActionPressed: () {},
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmallScreen ? 2 : (isMediumScreen ? 3 : 4),
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                final product = _featuredProducts[index % _featuredProducts.length];
                return ProductCard(
                  title: product['title'],
                  price: product['price'] is double ? product['price'] : double.tryParse(product['price'] ?? '0') ?? 0.0,
                  rating: product['rating'] is double ? product['rating'] : (product['rating'] as num).toDouble(),
                  seller: product['seller'],
                  mediaUrl: product['mediaUrl'],
                  thumbnailUrl: product['thumbnailUrl'],
                  isVideo: product['isVideo'] == true,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
