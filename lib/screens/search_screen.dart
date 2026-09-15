import 'package:flutter/material.dart';
import '../models/product.dart';

class SearchScreen extends StatefulWidget {
  final Set<String> favoriteProductIds;
  final Function(Product p) onToggleFavorite;
  final Function(Product p) onProductTap;
  final Function(Product p) onQuickAddToCart;

  const SearchScreen({
    super.key,
    required this.favoriteProductIds,
    required this.onToggleFavorite,
    required this.onProductTap,
    required this.onQuickAddToCart,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<String> _popularSearches = const [
    'short kurti',
    'saree',
    'kurti',
    'tshirt',
    'earring',
    'top for women',
    'slipper',
    'watch',
    'top',
    'water bottle',
    'kurti set',
    'shoes',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Filter Logic
    var results = sampleProducts.where((p) {
      final matchesQuery = p.name.toLowerCase().contains(_query.toLowerCase()) ||
          p.category.toLowerCase().contains(_query.toLowerCase());
      return matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF212121)),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (val) => setState(() => _query = val),
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search by Keyword or Prod...',
                hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_query.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 18, color: Color(0xFF64748B)),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    else ...[
                      const Icon(Icons.mic_none_rounded, color: Color(0xFF64748B), size: 20),
                      const SizedBox(width: 8),
                      const Icon(Icons.camera_alt_outlined, color: Color(0xFF64748B), size: 20),
                      const SizedBox(width: 12),
                    ],
                  ],
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: _query.isEmpty
          ? ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // -------------------------------------------------------------
                // POPULAR SEARCHES CHIPS
                // -------------------------------------------------------------
                const Text(
                  'Popular Searches',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: _popularSearches.map((term) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        _searchController.text = term;
                        setState(() => _query = term);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          term,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // -------------------------------------------------------------
                // PROMOTIONAL BANNER CARD
                // -------------------------------------------------------------
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF8FAF2), Color(0xFFF1F5F9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Jhumka Bareilly ka\nya Saree Banarasi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF334155),
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: const [
                                Text(
                                  'Shop what you ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.favorite, color: Color(0xFF8A1C78), size: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A1C78).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.woman_2_rounded,
                          size: 56,
                          color: Color(0xFF8A1C78),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : results.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off_rounded, size: 70, color: theme.hintColor),
                      const SizedBox(height: 16),
                      Text(
                        'No results for "$_query"',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: results.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final p = results[index];
                    return ListTile(
                      onTap: () => widget.onProductTap(p),
                      leading: Icon(p.icon, color: p.badgeColor),
                      title: Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text('₹${p.price.toStringAsFixed(0)}'),
                      trailing: const Icon(Icons.chevron_right, size: 20),
                    );
                  },
                ),
    );
  }
}
