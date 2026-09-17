import 'package:flutter/material.dart';

class SupplierDashboardScreen extends StatefulWidget {
  const SupplierDashboardScreen({super.key});

  @override
  State<SupplierDashboardScreen> createState() => _SupplierDashboardScreenState();
}

class _SupplierDashboardScreenState extends State<SupplierDashboardScreen> {
  final List<Map<String, dynamic>> _myProducts = [
    {
      'title': 'Handcrafted Silk Saree',
      'price': 1899.0,
      'stock': 24,
      'sales': 142,
      'inStock': true,
      'category': 'Women Ethnic',
      'icon': Icons.checkroom_rounded,
      'color': Colors.pink,
    },
    {
      'title': 'Wireless Noise Cancelling Earbuds',
      'price': 2499.0,
      'stock': 12,
      'sales': 89,
      'inStock': true,
      'category': 'Electronics',
      'icon': Icons.headphones_rounded,
      'color': Colors.indigo,
    },
    {
      'title': 'Stainless Steel Cookware Set',
      'price': 1299.0,
      'stock': 0,
      'sales': 210,
      'inStock': false,
      'category': 'Kitchen',
      'icon': Icons.kitchen_rounded,
      'color': Colors.amber,
    },
  ];

  void _showAddProductSheet() {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    String selectedCat = 'Women Ethnic';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add New Product to Shop',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Product Name / Title',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.shopping_bag_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Price (₹)',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.currency_rupee),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: stockController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Stock Units',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.inventory_2_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCat,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.category_outlined),
                    ),
                    items: ['Women Ethnic', 'Electronics', 'Kitchen', 'Footwear', 'Jewellery']
                        .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setSheetState(() => selectedCat = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  // Image Upload Placeholder Button
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Product image selected from gallery!')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.indigo.withValues(alpha: 0.3), style: BorderStyle.solid),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text(
                            'Upload Product Photos (Max 5)',
                            style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.trim().isEmpty) return;
                        setState(() {
                          _myProducts.add({
                            'title': titleController.text.trim(),
                            'price': double.tryParse(priceController.text) ?? 999.0,
                            'stock': int.tryParse(stockController.text) ?? 10,
                            'sales': 0,
                            'inStock': true,
                            'category': selectedCat,
                            'icon': Icons.storefront_rounded,
                            'color': Colors.purple,
                          });
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product "${titleController.text}" published successfully!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Publish Product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Seller Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Supplier Support Hotline: 1800-889-0099')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Supplier Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF0F766E), const Color(0xFF0D9488)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'VERIFIED SUPPLIER',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '0% Commission',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Simpal Crafts & Fashion Store',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supplier ID: EMP-982143 • GSTIN: 27AABCU9603R1ZM',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Business Performance Metrics Grid
          Text(
            'Business Analytics Overview',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _MetricCard(
                title: 'Total Revenue',
                value: '₹1,84,500',
                change: '+18.4% this month',
                icon: Icons.account_balance_wallet_outlined,
                color: Colors.teal,
              ),
              _MetricCard(
                title: 'Total Orders',
                value: '320',
                change: '42 pending dispatch',
                icon: Icons.local_shipping_outlined,
                color: Colors.indigo,
              ),
              _MetricCard(
                title: 'Active Products',
                value: '${_myProducts.length}',
                change: 'All compliant',
                icon: Icons.inventory_2_outlined,
                color: Colors.amber,
              ),
              _MetricCard(
                title: 'Seller Score',
                value: '4.8 ★',
                change: 'Top Rated Seller',
                icon: Icons.stars_outlined,
                color: Colors.purple,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Supplier Benefits Horizontal Cards
          Text(
            'Supplier Perks & Services',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _PerkTile(
                  icon: Icons.flash_on_rounded,
                  title: '7-Day Payments',
                  subtitle: 'Direct bank payout',
                  color: Colors.orange,
                ),
                const SizedBox(width: 12),
                _PerkTile(
                  icon: Icons.local_shipping_rounded,
                  title: 'Lowest Shipping Fee',
                  subtitle: 'Pan-India pickup',
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                _PerkTile(
                  icon: Icons.verified_user_rounded,
                  title: 'RTO Protection',
                  subtitle: 'Free return shipping',
                  color: Colors.green,
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // My Product Listings Header & Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Catalog Listings',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _showAddProductSheet,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Products List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _myProducts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = _myProducts[index];
              final isStock = item['inStock'] as bool;
              final itemColor = item['color'] as Color;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: itemColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(item['icon'] as IconData, color: itemColor, size: 30),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${item['price']} • ${item['sales']} Sales',
                              style: TextStyle(color: theme.hintColor, fontSize: 12),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isStock ? Colors.green.shade100 : Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    isStock ? 'In Stock (${item['stock']})' : 'Out of Stock',
                                    style: TextStyle(
                                      color: isStock ? Colors.green.shade800 : Colors.red.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isStock,
                        activeTrackColor: theme.colorScheme.primary,
                        onChanged: (val) {
                          setState(() {
                            item['inStock'] = val;
                          });
                        },
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

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final MaterialColor color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: theme.hintColor, fontSize: 11, fontWeight: FontWeight.w600)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            change,
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _PerkTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _PerkTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
