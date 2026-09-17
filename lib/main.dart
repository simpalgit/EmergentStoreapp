import 'package:flutter/material.dart';
import 'models/product.dart';
import 'models/cart_item.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/search_screen.dart';
import 'screens/category_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/video_finds_screen.dart';
import 'screens/live_shopping_screen.dart';
import 'widgets/banner_carousel.dart';

void main() {
  runApp(const EmergentShopApp());
}

class EmergentShopApp extends StatefulWidget {
  const EmergentShopApp({super.key});

  @override
  State<EmergentShopApp> createState() => _EmergentShopAppState();
}

class _EmergentShopAppState extends State<EmergentShopApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primarySeed = Color(0xFF6366F1); // Modern Indigo

    return MaterialApp(
      title: 'EmergentStore',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: primarySeed,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: primarySeed,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardTheme: CardThemeData(
          elevation: 0,
          color: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF334155)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: MainNavigationScreen(
        currentThemeMode: _themeMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const MainNavigationScreen({
    super.key,
    required this.currentThemeMode,
    required this.onThemeChanged,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<CartItem> _cartItems = [];
  final Set<String> _favoriteProductIds = {};

  int get totalCartQuantity => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void _toggleFavorite(Product p) {
    setState(() {
      if (_favoriteProductIds.contains(p.id)) {
        _favoriteProductIds.remove(p.id);
      } else {
        _favoriteProductIds.add(p.id);
      }
    });
  }

  void _addToCart(Product product, String size, Color color) {
    setState(() {
      final index = _cartItems.indexWhere(
        (item) =>
            item.product.id == product.id &&
            item.selectedSize == size &&
            item.selectedColor == color,
      );
      if (index >= 0) {
        _cartItems[index].quantity += 1;
      } else {
        _cartItems.add(
          CartItem(
            product: product,
            quantity: 1,
            selectedSize: size,
            selectedColor: color,
          ),
        );
      }
    });
  }

  void _updateQuantity(CartItem item, int delta) {
    setState(() {
      item.quantity += delta;
      if (item.quantity <= 0) {
        _cartItems.remove(item);
      }
    });
  }

  void _removeFromCart(CartItem item) {
    setState(() {
      _cartItems.remove(item);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  void _navigateToDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          isFavorite: _favoriteProductIds.contains(product.id),
          onToggleFavorite: () => _toggleFavorite(product),
          onAddToCart: _addToCart,
        ),
      ),
    );
  }

  void _navigateToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(
          favoriteProductIds: _favoriteProductIds,
          onToggleFavorite: _toggleFavorite,
          onProductTap: _navigateToDetail,
          onQuickAddToCart: (p) => _addToCart(
            p,
            p.sizes.isNotEmpty ? p.sizes.first : 'Standard',
            p.colors.isNotEmpty ? p.colors.first : Colors.indigo,
          ),
        ),
      ),
    );
  }

  void _navigateToWishlist() {
    final favoriteProducts =
        sampleProducts.where((p) => _favoriteProductIds.contains(p.id)).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WishlistScreen(
          favoriteProducts: favoriteProducts,
          onToggleFavorite: _toggleFavorite,
          onProductTap: _navigateToDetail,
        ),
      ),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: _cartItems,
          onQuantityChanged: _updateQuantity,
          onRemoveItem: _removeFromCart,
          onClearCart: _clearCart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      ShopCatalogScreen(
        favoriteProductIds: _favoriteProductIds,
        favoriteCount: _favoriteProductIds.length,
        cartCount: totalCartQuantity,
        onToggleFavorite: _toggleFavorite,
        onProductTap: _navigateToDetail,
        onSearchTap: _navigateToSearch,
        onOpenWishlist: _navigateToWishlist,
        onOpenCart: _navigateToCart,
        onQuickAddToCart: (p) => _addToCart(
          p,
          p.sizes.isNotEmpty ? p.sizes.first : 'Standard',
          p.colors.isNotEmpty ? p.colors.first : Colors.indigo,
        ),
      ),
      CategoryScreen(
        onProductTap: _navigateToDetail,
        onQuickAddToCart: (p) => _addToCart(
          p,
          p.sizes.isNotEmpty ? p.sizes.first : 'Standard',
          p.colors.isNotEmpty ? p.colors.first : Colors.indigo,
        ),
      ),
      const OrdersScreen(),
      const VideoFindsScreen(),
      ProfileScreen(
        currentThemeMode: widget.currentThemeMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.15),
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          height: 65,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.checkroom_outlined),
              selectedIcon: Icon(Icons.checkroom),
              label: 'Categories',
            ),
            const NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2),
              label: 'My Orders',
            ),
            const NavigationDestination(
              icon: Icon(Icons.ondemand_video_outlined),
              selectedIcon: Icon(Icons.ondemand_video),
              label: 'Video Finds',
            ),
            const NavigationDestination(
              icon: Icon(Icons.face_3_outlined),
              selectedIcon: Icon(Icons.face_3),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SHOP CATALOG HOMEPAGE
// -----------------------------------------------------------------------------
class ShopCatalogScreen extends StatefulWidget {
  final Set<String> favoriteProductIds;
  final int favoriteCount;
  final int cartCount;
  final Function(Product p) onToggleFavorite;
  final Function(Product p) onProductTap;
  final VoidCallback onSearchTap;
  final VoidCallback onOpenWishlist;
  final VoidCallback onOpenCart;
  final Function(Product p) onQuickAddToCart;

  const ShopCatalogScreen({
    super.key,
    required this.favoriteProductIds,
    required this.favoriteCount,
    required this.cartCount,
    required this.onToggleFavorite,
    required this.onProductTap,
    required this.onSearchTap,
    required this.onOpenWishlist,
    required this.onOpenCart,
    required this.onQuickAddToCart,
  });

  @override
  State<ShopCatalogScreen> createState() => _ShopCatalogScreenState();
}

class _ShopCatalogScreenState extends State<ShopCatalogScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Women Ethnic',
    'Western Wear',
    'Jewellery',
    'Kitchen',
    'Footwear',
    'Electronics',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredProducts = sampleProducts.where((p) {
      return _selectedCategory == 'All' || p.category == _selectedCategory;
    }).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Top Bar Greeting & Brand
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Collections 🛍️',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'EmergentStore',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Badge(
                      isLabelVisible: widget.favoriteCount > 0,
                      label: Text('${widget.favoriteCount}'),
                      child: const Icon(Icons.favorite_border),
                    ),
                    onPressed: widget.onOpenWishlist,
                  ),
                  IconButton(
                    icon: Badge(
                      isLabelVisible: widget.cartCount > 0,
                      label: Text('${widget.cartCount}'),
                      child: const Icon(Icons.shopping_bag_outlined),
                    ),
                    onPressed: widget.onOpenCart,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                      child: Icon(Icons.notifications_none_rounded, color: theme.colorScheme.primary, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Clean Search Bar Trigger
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.onSearchTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: theme.cardTheme.color ?? theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.hintColor),
                  const SizedBox(width: 12),
                  Text(
                    'Search electronics, shoes, fashion...',
                    style: TextStyle(color: theme.hintColor, fontSize: 14),
                  ),
                  const Spacer(),
                  Icon(Icons.tune_rounded, size: 20, color: theme.hintColor),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Live Shopping Show Highlight Banner
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LiveShoppingScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF831843), Color(0xFFBE185D)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.live_tv_rounded, color: Colors.amber, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'LIVE SHOW',
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.circle, color: Colors.greenAccent, size: 8),
                            SizedBox(width: 4),
                            Text(
                              '3.4k watching',
                              style: TextStyle(color: Colors.white70, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Festival Saree & Jewellery Live Showcase 💖',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Promo Sale Banner Carousel
          const BannerCarousel(),

          const SizedBox(height: 20),

          // Category Chips Horizontal Scroll
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedCategory = cat);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCategory == 'All' ? 'Featured Products' : '$_selectedCategory Collection',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${filteredProducts.length} items',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Product Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (context, index) {
              final p = filteredProducts[index];
              final isFav = widget.favoriteProductIds.contains(p.id);

              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => widget.onProductTap(p),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Graphic Container
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: p.badgeColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(p.icon, size: 52, color: p.badgeColor),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor:
                                        theme.cardTheme.color ?? theme.colorScheme.surface,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        isFav ? Icons.favorite : Icons.favorite_border,
                                        color: isFav ? Colors.red : Colors.grey,
                                        size: 18,
                                      ),
                                      onPressed: () => widget.onToggleFavorite(p),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 6,
                                  left: 6,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: p.badgeColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      p.tag,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
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

                        // Rating
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${p.rating}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' (${p.reviewsCount})',
                              style: TextStyle(fontSize: 11, color: theme.hintColor),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Name
                        Text(
                          p.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Price & Quick Add Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹${p.price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                if (p.hasDiscount)
                                  Text(
                                    '₹${p.originalPrice!.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                widget.onQuickAddToCart(p);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added "${p.name}" to cart'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
