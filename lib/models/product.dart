import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewsCount;
  final String description;
  final IconData icon;
  final Color badgeColor;
  final String tag;
  final List<String> sizes;
  final List<Color> colors;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.icon,
    required this.badgeColor,
    required this.tag,
    this.sizes = const ['S', 'M', 'L', 'XL'],
    this.colors = const [Colors.pink, Colors.purple, Colors.teal, Colors.amber],
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  int get discountPercent => hasDiscount
      ? (((originalPrice! - price) / originalPrice!) * 100).round()
      : 0;
}

final List<Product> sampleProducts = [
  // 1. Women Ethnic - Kurti
  const Product(
    id: 'p1',
    name: 'Designer Cotton Anarkali Kurti & Dupatta Set',
    category: 'Women Ethnic',
    price: 899.00,
    originalPrice: 1999.00,
    rating: 4.8,
    reviewsCount: 1420,
    description:
        'Premium 100% pure breathable cotton flared Anarkali Kurti with intricate floral embroidery work and matching chiffon dupatta.',
    icon: Icons.woman_rounded,
    badgeColor: Colors.pink,
    tag: 'Best Seller',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: [Colors.pink, Colors.purple, Colors.amber],
  ),

  // 2. Women Ethnic - Sarees & Suits
  const Product(
    id: 'p2',
    name: 'Silk Blend Banarasi Designer Saree',
    category: 'Women Ethnic',
    price: 1299.00,
    originalPrice: 2999.00,
    rating: 4.7,
    reviewsCount: 980,
    description:
        'Royal zari woven Banarasi silk saree with unstitched blouse piece. Perfect for festive celebrations, weddings, and parties.',
    icon: Icons.checkroom_rounded,
    badgeColor: Colors.purple,
    tag: '56% OFF',
    colors: [Colors.red, Colors.deepOrange, Colors.indigo],
  ),

  // 3. Western Wear - Crop Top
  const Product(
    id: 'p3',
    name: 'Ribbed Cotton Full Sleeve Crop Top',
    category: 'Western Wear',
    price: 399.00,
    originalPrice: 899.00,
    rating: 4.6,
    reviewsCount: 850,
    description:
        'Trendy stretchable ribbed cotton crop top with crew neck. High durability and comfortable daily casual fit.',
    icon: Icons.dry_cleaning_rounded,
    badgeColor: Colors.deepOrange,
    tag: 'Trending',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: [Colors.black, Colors.white, Colors.pinkAccent],
  ),

  // 4. Jewellery / Jevar - Necklace Set
  const Product(
    id: 'p4',
    name: '24K Gold Plated Kundan Choker Necklace Set',
    category: 'Jewellery',
    price: 699.00,
    originalPrice: 2499.00,
    rating: 4.9,
    reviewsCount: 2150,
    description:
        'Traditional bridal Kundan & pearl necklace with matching dangle earrings. Anti-tarnish gold plating for lasting shine.',
    icon: Icons.auto_awesome_rounded,
    badgeColor: Colors.amber,
    tag: '72% OFF',
    colors: [Colors.amber, Colors.orangeAccent],
  ),

  // 5. Jewellery - Earrings
  const Product(
    id: 'p5',
    name: 'Traditional Jhumka Earrings with Pearl Drops',
    category: 'Jewellery',
    price: 299.00,
    originalPrice: 999.00,
    rating: 4.8,
    reviewsCount: 1890,
    description:
        'Lightweight oxidised silver finish Jhumkas featuring intricate meenakari detailing and faux pearl beads.',
    icon: Icons.diamond_rounded,
    badgeColor: Colors.teal,
    tag: 'Hot Deal',
    colors: [Colors.grey, Colors.amber],
  ),

  // 6. Kitchenware - Cookware Set
  const Product(
    id: 'p6',
    name: 'Non-Stick Aluminium 3-Piece Kitchen Cookware Set',
    category: 'Kitchen',
    price: 1499.00,
    originalPrice: 3499.00,
    rating: 4.6,
    reviewsCount: 620,
    description:
        'Induction & gas friendly non-stick Dosa Tawa, Fry Pan, and Kadai with glass lid. PFOA-free food grade coating.',
    icon: Icons.soup_kitchen_rounded,
    badgeColor: Colors.deepOrange,
    tag: 'Top Rated',
    colors: [Colors.black, Colors.red],
  ),

  // 7. Kitchenware - Stainless Containers
  const Product(
    id: 'p7',
    name: 'Airtight Stainless Steel Grocery Storage Container Set',
    category: 'Kitchen',
    price: 799.00,
    originalPrice: 1599.00,
    rating: 4.5,
    reviewsCount: 430,
    description:
        'Set of 6 rust-free heavy gauge stainless steel containers with see-through leakproof lids.',
    icon: Icons.kitchen_rounded,
    badgeColor: Colors.blueGrey,
    tag: 'Essential',
    colors: [Colors.grey, Colors.blue],
  ),

  // 8. Footwear - Women Heels
  const Product(
    id: 'p8',
    name: 'Women Stylish Block Heel Sandals',
    category: 'Footwear',
    price: 599.00,
    originalPrice: 1499.00,
    rating: 4.7,
    reviewsCount: 940,
    description:
        'Comfortable 2-inch block heels with cushioned footbed and secure ankle strap closure.',
    icon: Icons.roller_skating_rounded,
    badgeColor: Colors.pink,
    tag: '60% OFF',
    sizes: ['UK 4', 'UK 5', 'UK 6', 'UK 7'],
    colors: [Colors.black, Colors.pinkAccent, Colors.amber],
  ),

  // 9. Electronics - Headphones
  const Product(
    id: 'p9',
    name: 'Wireless Noise Cancelling Bluetooth Headphones',
    category: 'Electronics',
    price: 1499.00,
    originalPrice: 3999.00,
    rating: 4.8,
    reviewsCount: 3200,
    description:
        'Deep bass wireless headset with active noise cancellation, 40-hour playback time, and fast charging.',
    icon: Icons.headphones_rounded,
    badgeColor: Colors.deepPurple,
    tag: 'Super Saver',
    colors: [Colors.black, Colors.indigo, Colors.grey],
  ),

  // 10. Electronics - Smart Watch
  const Product(
    id: 'p10',
    name: 'Smart Watch with Bluetooth Calling & Fitness Tracker',
    category: 'Electronics',
    price: 1299.00,
    originalPrice: 4999.00,
    rating: 4.7,
    reviewsCount: 5400,
    description:
        '1.85-inch HD display, voice assistant, 100+ sports modes, SpO2 & 24x7 heart rate monitor.',
    icon: Icons.watch_rounded,
    badgeColor: Colors.indigo,
    tag: 'Best Price',
    colors: [Colors.black, Colors.blue, Colors.pink],
  ),
];
