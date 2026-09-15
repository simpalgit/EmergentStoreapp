import 'package:flutter/material.dart';
import '../models/product.dart';

class HandcraftedStudioScreen extends StatefulWidget {
  final Function(Product p) onProductTap;
  final Function(Product p) onQuickAddToCart;

  const HandcraftedStudioScreen({
    super.key,
    required this.onProductTap,
    required this.onQuickAddToCart,
  });

  @override
  State<HandcraftedStudioScreen> createState() => _HandcraftedStudioScreenState();
}

class _HandcraftedStudioScreenState extends State<HandcraftedStudioScreen> {
  final List<Map<String, dynamic>> _artisanItems = const [
    {
      'title': 'Hand-Block Printed Chanderi Saree',
      'artisan': 'Sunita Devi (Jaipur, Rajasthan)',
      'price': '₹2,899',
      'tag': '✋ 100% Hand-Dyed',
      'timeToCraft': '12 Days of Handloom',
      'icon': Icons.woman_rounded,
      'color': Color(0xFFB45309), // Terracotta
    },
    {
      'title': 'Hand-Carved Sheesham Wooden Teapot & Cups',
      'artisan': 'Ramesh Kumar (Saharanpur, UP)',
      'price': '₹1,499',
      'tag': '🪵 Hand-Carved Wood',
      'timeToCraft': '7 Days Crafting',
      'icon': Icons.soup_kitchen_rounded,
      'color': Color(0xFF78350F), // Warm Wood
    },
    {
      'title': 'Clay Terracotta Hand-Painted Tea Kulhad Set',
      'artisan': 'Gopal Prajapati (Khurja, UP)',
      'price': '₹699',
      'tag': '🏺 Pure Clay Pottery',
      'timeToCraft': '5 Days Kiln Fired',
      'icon': Icons.local_cafe_rounded,
      'color': Color(0xFFD97706), // Clay Warm Amber
    },
    {
      'title': 'Hand-Stitched Genuine Leather Journal',
      'artisan': 'Anita Roy (Shantiniketan, WB)',
      'price': '₹999',
      'tag': '✍️ Hand-Bound Leather',
      'timeToCraft': '4 Days Stitched',
      'icon': Icons.menu_book_rounded,
      'color': Color(0xFF92400E),
    },
  ];

  void _showCustomOrderModal() {
    final noteController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Row(
              children: [
                Icon(Icons.handshake_rounded, color: Color(0xFFB45309)),
                SizedBox(width: 10),
                Text(
                  'Request Custom Hand-Made Design',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Tell our master artisans what you would like hand-crafted (e.g. custom embroidery, custom saree length or pottery pattern).',
              style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe your custom handmade request...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Custom Handcrafted request sent to Master Artisan! 🙏'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB45309),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.send_rounded),
                label: const Text('Send Custom Request to Artisan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEB), // Organic Parchment Background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEF3C7),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.brush_rounded, color: Color(0xFFB45309)),
            SizedBox(width: 8),
            Text(
              'Handcrafted Studio ✋',
              style: TextStyle(
                color: Color(0xFF78350F),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // -------------------------------------------------------------------
          // HANDMADE ARTISAN HERITAGE HERO BANNER
          // -------------------------------------------------------------------
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF59E0B), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD97706).withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB45309),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '✨ 100% HANDMADE & ARTISAN CERTIFIED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(Icons.verified_rounded, color: Color(0xFFB45309), size: 24),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Hath Se Banaya Hua Heritage Store',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF78350F),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Directly supporting 500+ traditional Indian weavers, wood carvers, clay potters & Kundan artisans.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF92400E),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _showCustomOrderModal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB45309),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.edit_note_rounded, size: 18),
                  label: const Text(
                    'Order Custom Handmade Piece',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // MASTER ARTISAN STORY CARD
          // -------------------------------------------------------------------
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFFFCD34D), width: 1.5),
            ),
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFFEF3C7),
                    child: Icon(Icons.face_retouching_natural_rounded, color: Color(0xFFB45309), size: 32),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Featured Artisan: Sunita Devi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF78350F),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '4th Generation Chanderi Handloom Master Weaver from Jaipur, Rajasthan.',
                          style: TextStyle(fontSize: 11, color: Color(0xFF92400E)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Artisan Handcrafted Collection',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF78350F),
            ),
          ),

          const SizedBox(height: 14),

          // -------------------------------------------------------------------
          // HANDCRAFTED ITEMS GRID
          // -------------------------------------------------------------------
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _artisanItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (context, index) {
              final item = _artisanItems[index];
              final color = item['color'] as Color;

              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(color: color.withValues(alpha: 0.3), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(item['icon'] as IconData, size: 52, color: color),
                              Positioned(
                                top: 6,
                                left: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item['tag'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['title'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFF78350F),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['artisan'] as String,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF92400E)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['price'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: color,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added "${item['title']}" to cart!'),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
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
