import 'package:flutter/material.dart';
import '../models/product.dart';

class CategoryItem {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<CategoryGroup> groups;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.groups,
  });
}

class CategoryGroup {
  final String title;
  final List<CategorySubItem> items;

  const CategoryGroup({
    required this.title,
    required this.items,
  });
}

class CategorySubItem {
  final String title;
  final String startingPrice;
  final IconData icon;
  final Color color;

  const CategorySubItem({
    required this.title,
    this.startingPrice = '₹199',
    required this.icon,
    required this.color,
  });
}

class CategoryScreen extends StatefulWidget {
  final Function(Product p) onProductTap;
  final Function(Product p) onQuickAddToCart;

  const CategoryScreen({
    super.key,
    required this.onProductTap,
    required this.onQuickAddToCart,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selectedCategoryIndex = 1; // Default to 'Kurti & Sarees'

  final List<CategoryItem> _categories = [
    CategoryItem(
      id: 'popular',
      title: 'Trending',
      icon: Icons.auto_awesome_rounded,
      color: Colors.amber,
      groups: [
        CategoryGroup(
          title: 'Top Popular Categories',
          items: [
            CategorySubItem(title: 'Sarees', startingPrice: '₹299', icon: Icons.checkroom_rounded, color: Colors.purple),
            CategorySubItem(title: 'Kurtis', startingPrice: '₹199', icon: Icons.woman_rounded, color: Colors.pink),
            CategorySubItem(title: 'Jewellery', startingPrice: '₹99', icon: Icons.diamond_rounded, color: Colors.amber),
            CategorySubItem(title: 'Western', startingPrice: '₹399', icon: Icons.dry_cleaning_rounded, color: Colors.deepOrange),
            CategorySubItem(title: 'Footwear', startingPrice: '₹199', icon: Icons.roller_skating_rounded, color: Colors.teal),
            CategorySubItem(title: 'Watches', startingPrice: '₹149', icon: Icons.watch_rounded, color: Colors.indigo),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'ethnic',
      title: 'Kurti & Sarees',
      icon: Icons.woman_rounded,
      color: const Color(0xFF6366F1),
      groups: [
        CategoryGroup(
          title: 'Saree Collection',
          items: [
            CategorySubItem(title: 'All Sarees', startingPrice: '₹299', icon: Icons.checkroom_rounded, color: Colors.teal),
            CategorySubItem(title: 'Banarasi Silk', startingPrice: '₹599', icon: Icons.woman_2_rounded, color: Colors.pink),
            CategorySubItem(title: 'Georgette', startingPrice: '₹399', icon: Icons.dry_cleaning_rounded, color: Colors.purple),
            CategorySubItem(title: 'Cotton Sarees', startingPrice: '₹249', icon: Icons.checkroom_outlined, color: Colors.blue),
            CategorySubItem(title: 'Chiffon & Net', startingPrice: '₹349', icon: Icons.light_mode_outlined, color: Colors.green),
            CategorySubItem(title: 'Bridal Heavy', startingPrice: '₹999', icon: Icons.diamond_rounded, color: Colors.pinkAccent),
          ],
        ),
        CategoryGroup(
          title: 'Kurti & Suit Sets',
          items: [
            CategorySubItem(title: 'Anarkali Sets', startingPrice: '₹499', icon: Icons.woman_rounded, color: Colors.amber),
            CategorySubItem(title: 'Cotton Kurtis', startingPrice: '₹199', icon: Icons.dry_cleaning_rounded, color: Colors.red),
            CategorySubItem(title: 'Rayon Kurtis', startingPrice: '₹299', icon: Icons.checkroom_rounded, color: Colors.indigo),
            CategorySubItem(title: 'Straight Suits', startingPrice: '₹399', icon: Icons.woman_2_rounded, color: Colors.green),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'western',
      title: 'Western Wear',
      icon: Icons.checkroom_rounded,
      color: Colors.deepOrange,
      groups: [
        CategoryGroup(
          title: 'Tops & Casual Wear',
          items: [
            CategorySubItem(title: 'Crop Tops', startingPrice: '₹199', icon: Icons.dry_cleaning_rounded, color: Colors.deepOrange),
            CategorySubItem(title: 'Dresses', startingPrice: '₹399', icon: Icons.woman_rounded, color: Colors.pink),
            CategorySubItem(title: 'Jeans & Denim', startingPrice: '₹499', icon: Icons.iron_rounded, color: Colors.blue),
            CategorySubItem(title: 'Party Gowns', startingPrice: '₹799', icon: Icons.auto_awesome, color: Colors.purple),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'jewellery',
      title: 'Jewellery',
      icon: Icons.diamond_rounded,
      color: Colors.amber,
      groups: [
        CategoryGroup(
          title: 'Fashion Jewellery',
          items: [
            CategorySubItem(title: 'Kundan Sets', startingPrice: '₹299', icon: Icons.auto_awesome_rounded, color: Colors.amber),
            CategorySubItem(title: 'Earrings & Jhumkas', startingPrice: '₹99', icon: Icons.diamond_rounded, color: Colors.purple),
            CategorySubItem(title: 'Bangles & Cuffs', startingPrice: '₹149', icon: Icons.circle_outlined, color: Colors.pink),
            CategorySubItem(title: 'Silver Oxidised', startingPrice: '₹199', icon: Icons.stars_rounded, color: Colors.teal),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'men',
      title: 'Men Fashion',
      icon: Icons.man_rounded,
      color: Colors.indigo,
      groups: [
        CategoryGroup(
          title: 'Men Wear',
          items: [
            CategorySubItem(title: 'T-Shirts', startingPrice: '₹199', icon: Icons.dry_cleaning_rounded, color: Colors.indigo),
            CategorySubItem(title: 'Casual Shirts', startingPrice: '₹349', icon: Icons.checkroom_rounded, color: Colors.blue),
            CategorySubItem(title: 'Jeans', startingPrice: '₹499', icon: Icons.straighten, color: Colors.blueGrey),
            CategorySubItem(title: 'Ethnic Kurtas', startingPrice: '₹399', icon: Icons.woman_rounded, color: Colors.amber),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'footwear',
      title: 'Footwear',
      icon: Icons.roller_skating_rounded,
      color: Colors.teal,
      groups: [
        CategoryGroup(
          title: 'Shoes & Sandals',
          items: [
            CategorySubItem(title: 'Heels & Wedges', startingPrice: '₹299', icon: Icons.roller_skating_rounded, color: Colors.pink),
            CategorySubItem(title: 'Flats & Juttis', startingPrice: '₹199', icon: Icons.checkroom, color: Colors.amber),
            CategorySubItem(title: 'Sneakers', startingPrice: '₹499', icon: Icons.directions_run_rounded, color: Colors.indigo),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeCategory = _categories[_selectedCategoryIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EXPLORE CATEGORIES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Row(
        children: [
          // -------------------------------------------------------------------
          // LEFT HANDCRAFTED SIDEBAR
          // -------------------------------------------------------------------
          Container(
            width: 104,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              border: Border(
                right: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                ),
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = index == _selectedCategoryIndex;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? const Color(0xFF0F172A) : Colors.white)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? cat.color.withValues(alpha: 0.15)
                                : (isDark ? const Color(0xFF334155) : Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            cat.icon,
                            size: 20,
                            color: isSelected ? cat.color : theme.hintColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          cat.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : (isDark ? Colors.white70 : const Color(0xFF475569)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // -------------------------------------------------------------------
          // RIGHT HANDCRAFTED CARD-BASED GRID CONTENT
          // -------------------------------------------------------------------
          Expanded(
            child: Container(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Category Header Banner Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [activeCategory.color, activeCategory.color.withValues(alpha: 0.75)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: activeCategory.color.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'FEATURED COLLECTION',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                activeCategory.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Explore top handcrafted styles',
                                style: TextStyle(color: Colors.white70, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Icon(activeCategory.icon, color: Colors.white, size: 42),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Groups & Cards
                  ...activeCategory.groups.map((group) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Handcrafted 3-Column Card Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: group.items.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: (context, idx) {
                            final item = group.items[idx];
                            return Container(
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  widget.onProductTap(sampleProducts.first);
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: item.color.withValues(alpha: 0.12),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(item.icon, size: 26, color: item.color),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.title,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? Colors.white : const Color(0xFF1E293B),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'From ${item.startingPrice}',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
