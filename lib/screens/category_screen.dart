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
    this.startingPrice = '',
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
  int _selectedCategoryIndex = 1; // Default to 'Kurti, Saree &...'

  final List<CategoryItem> _categories = const [
    CategoryItem(
      id: 'popular',
      title: 'Popular',
      icon: Icons.star_rounded,
      color: Colors.amber,
      groups: [
        CategoryGroup(
          title: 'Top Picks',
          items: [
            CategorySubItem(title: 'Sarees', startingPrice: '₹199', icon: Icons.checkroom_rounded, color: Colors.purple),
            CategorySubItem(title: 'Kurtis', startingPrice: '₹299', icon: Icons.woman_rounded, color: Colors.pink),
            CategorySubItem(title: 'Jewellery', startingPrice: '₹99', icon: Icons.auto_awesome_rounded, color: Colors.amber),
            CategorySubItem(title: 'Western', startingPrice: '₹399', icon: Icons.dry_cleaning_rounded, color: Colors.deepOrange),
            CategorySubItem(title: 'Footwear', startingPrice: '₹199', icon: Icons.roller_skating_rounded, color: Colors.teal),
            CategorySubItem(title: 'Watches', startingPrice: '₹149', icon: Icons.watch_rounded, color: Colors.indigo),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'ethnic',
      title: 'Kurti, Saree &...',
      icon: Icons.woman_rounded,
      color: Color(0xFF8A1C78),
      groups: [
        CategoryGroup(
          title: 'Sarees',
          items: [
            CategorySubItem(title: 'All Sarees', icon: Icons.checkroom_rounded, color: Colors.teal),
            CategorySubItem(title: 'Georgette Sarees', icon: Icons.woman_2_rounded, color: Colors.pink),
            CategorySubItem(title: 'Chiffon Sarees', icon: Icons.dry_cleaning_rounded, color: Colors.purple),
            CategorySubItem(title: 'Cotton Sarees', icon: Icons.checkroom_outlined, color: Colors.blue),
            CategorySubItem(title: 'Net Sarees', icon: Icons.light_mode_outlined, color: Colors.green),
            CategorySubItem(title: 'Under 299', icon: Icons.discount_rounded, color: Colors.orange),
            CategorySubItem(title: 'Silk Sarees', icon: Icons.auto_awesome_rounded, color: Colors.red),
            CategorySubItem(title: 'New Collection', icon: Icons.new_releases_rounded, color: Colors.teal),
            CategorySubItem(title: 'Bridal Sarees', icon: Icons.diamond_rounded, color: Colors.pinkAccent),
          ],
        ),
        CategoryGroup(
          title: 'Kurtis',
          items: [
            CategorySubItem(title: 'All Kurtis', icon: Icons.woman_rounded, color: Colors.amber),
            CategorySubItem(title: 'Anarkali Kurtis', icon: Icons.dry_cleaning_rounded, color: Colors.red),
            CategorySubItem(title: 'Rayon Kurtis', icon: Icons.checkroom_rounded, color: Colors.indigo),
            CategorySubItem(title: 'Cotton Kurtis', icon: Icons.woman_2_rounded, color: Colors.green),
            CategorySubItem(title: 'Kurti Sets', icon: Icons.checkroom_outlined, color: Colors.purple),
            CategorySubItem(title: 'Under 399', icon: Icons.discount_outlined, color: Colors.orange),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'western',
      title: 'Women Western',
      icon: Icons.checkroom_rounded,
      color: Colors.deepOrange,
      groups: [
        CategoryGroup(
          title: 'Topwear & Dresses',
          items: [
            CategorySubItem(title: 'Tops', icon: Icons.dry_cleaning_rounded, color: Colors.deepOrange),
            CategorySubItem(title: 'Dresses', icon: Icons.woman_rounded, color: Colors.pink),
            CategorySubItem(title: 'Jeans', icon: Icons.iron_rounded, color: Colors.blue),
            CategorySubItem(title: 'Gowns', icon: Icons.auto_awesome, color: Colors.purple),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'lingerie',
      title: 'Lingerie',
      icon: Icons.favorite_border_rounded,
      color: Colors.pinkAccent,
      groups: [
        CategoryGroup(
          title: 'Innerwear',
          items: [
            CategorySubItem(title: 'Bra', icon: Icons.favorite_rounded, color: Colors.pink),
            CategorySubItem(title: 'Briefs', icon: Icons.checkroom, color: Colors.purple),
            CategorySubItem(title: 'Nightwear', icon: Icons.bedtime_rounded, color: Colors.indigo),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'men',
      title: 'Men',
      icon: Icons.man_rounded,
      color: Colors.red,
      groups: [
        CategoryGroup(
          title: 'Men Fashion',
          items: [
            CategorySubItem(title: 'T-Shirts', icon: Icons.dry_cleaning_rounded, color: Colors.red),
            CategorySubItem(title: 'Shirts', icon: Icons.checkroom_rounded, color: Colors.blue),
            CategorySubItem(title: 'Jeans & Trousers', icon: Icons.straighten, color: Colors.blueGrey),
            CategorySubItem(title: 'Kurtas', icon: Icons.woman_rounded, color: Colors.amber),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'kids',
      title: 'Kids & Toys',
      icon: Icons.toys_rounded,
      color: Colors.orange,
      groups: [
        CategoryGroup(
          title: 'Kids Wear',
          items: [
            CategorySubItem(title: 'Boys Clothing', icon: Icons.child_care_rounded, color: Colors.blue),
            CategorySubItem(title: 'Girls Clothing', icon: Icons.child_friendly_rounded, color: Colors.pink),
            CategorySubItem(title: 'Soft Toys', icon: Icons.smart_toy_rounded, color: Colors.amber),
          ],
        ),
      ],
    ),
    CategoryItem(
      id: 'home',
      title: 'Home &...',
      icon: Icons.home_rounded,
      color: Colors.teal,
      groups: [
        CategoryGroup(
          title: 'Home Decor',
          items: [
            CategorySubItem(title: 'Bedsheets', icon: Icons.bed_rounded, color: Colors.teal),
            CategorySubItem(title: 'Curtains', icon: Icons.curtains_rounded, color: Colors.purple),
            CategorySubItem(title: 'Kitchenware', icon: Icons.soup_kitchen_rounded, color: Colors.deepOrange),
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
          'CATEGORIES',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            letterSpacing: 0.8,
            color: Color(0xFF212121),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF212121)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Color(0xFF212121)),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF212121)),
                  onPressed: () {},
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF8A1C78),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child: Row(
              children: [
                // -------------------------------------------------------------
                // LEFT SIDEBAR (VERTICAL CATEGORY SELECTOR)
                // -------------------------------------------------------------
                Container(
                  width: 98,
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF7F8FA),
                  child: ListView.builder(
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: isSelected ? const Color(0xFF8A1C78) : Colors.transparent,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: isSelected
                                    ? const Color(0xFFF8E7F4)
                                    : (isDark ? Colors.grey.shade800 : const Color(0xFFEDEDED)),
                                child: Icon(
                                  cat.icon,
                                  size: 18,
                                  color: isSelected ? const Color(0xFF8A1C78) : Colors.amber.shade700,
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
                                      ? const Color(0xFF8A1C78)
                                      : (isDark ? Colors.white70 : const Color(0xFF555555)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFEEEEEE)),

                // -------------------------------------------------------------
                // RIGHT CONTENT AREA (SUB-CATEGORIES 3-COLUMN GRID)
                // -------------------------------------------------------------
                Expanded(
                  child: Container(
                    color: isDark ? const Color(0xFF0F172A) : Colors.white,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      children: [
                        // Header bar text e.g., "KURTI, SAREE & LEHENGA"
                        Row(
                          children: [
                            Text(
                              activeCategory.title.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF757575),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Groups loop e.g., "Sarees", "Kurtis"
                        ...activeCategory.groups.map((group) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF212121),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // 3-Column Grid for Sub-categories
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
                                  return InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(12),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5F5F5),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  item.icon,
                                                  size: 38,
                                                  color: item.color,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item.title,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF424242),
                                          ),
                                        ),
                                      ],
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
          ),
        ],
      ),
    );
  }
}
