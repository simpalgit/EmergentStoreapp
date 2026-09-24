import 'package:flutter/material.dart';
import '../models/product.dart';

class ExploreStoriesScreen extends StatefulWidget {
  final Function(Product p) onProductTap;

  const ExploreStoriesScreen({
    super.key,
    required this.onProductTap,
  });

  @override
  State<ExploreStoriesScreen> createState() => _ExploreStoriesScreenState();
}

class _ExploreStoriesScreenState extends State<ExploreStoriesScreen> {
  final List<Map<String, dynamic>> _stories = [
    {
      'title': 'Festive Royal Lookbook',
      'creator': 'Ananya Fashion',
      'views': '18.4K',
      'color': Colors.purple,
      'icon': Icons.checkroom_rounded,
      'product': sampleProducts[0],
    },
    {
      'title': 'Jewellery Styling Guide',
      'creator': 'Rhea Jewels',
      'views': '24.2K',
      'color': Colors.amber,
      'icon': Icons.auto_awesome_rounded,
      'product': sampleProducts[3],
    },
    {
      'title': 'Casual Western Vibe',
      'creator': 'Urban Wear',
      'views': '12.8K',
      'color': Colors.deepOrange,
      'icon': Icons.dry_cleaning_rounded,
      'product': sampleProducts[2],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Stories & Lookbook 📸'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Trending Fashion Lookbooks',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          // Lookbook Cards List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _stories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final story = _stories[index];
              final p = story['product'] as Product;
              final color = story['color'] as Color;

              return Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '👀 ${story['views']} views',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                          Icon(story['icon'] as IconData, color: Colors.white, size: 36),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            story['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Styled by ${story['creator']}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => widget.onProductTap(p),
                        icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                        label: Text('Shop Outfit (${p.price.toStringAsFixed(0)})'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: color,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
