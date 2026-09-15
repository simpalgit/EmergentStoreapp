import 'package:flutter/material.dart';

class BannerItem {
  final String tag;
  final String title;
  final String subtitle;
  final String code;
  final IconData icon;
  final List<Color> gradientColors;

  const BannerItem({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.icon,
    required this.gradientColors,
  });
}

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<BannerItem> _banners = const [
    BannerItem(
      tag: '🔥 SUMMER SALE',
      title: 'Up to 50% OFF',
      subtitle: 'Use code: EMERGENT20 at checkout',
      code: 'EMERGENT20',
      icon: Icons.local_offer_rounded,
      gradientColors: [Color(0xFF6366F1), Color(0xFF4F46E5), Color(0xFF7C3AED)],
    ),
    BannerItem(
      tag: '🎧 NEW TECH ARRIVALS',
      title: 'Next-Gen Audio',
      subtitle: 'Noise Cancelling Headphones & Accessories',
      code: 'AUDIO15',
      icon: Icons.headphones_rounded,
      gradientColors: [Color(0xFF0EA5E9), Color(0xFF2563EB), Color(0xFF1D4ED8)],
    ),
    BannerItem(
      tag: '🚚 EXPRESS DELIVERY',
      title: 'Free Shipping',
      subtitle: 'On all orders above ₹1,999 across India',
      code: 'FREESHIP',
      icon: Icons.local_shipping_rounded,
      gradientColors: [Color(0xFF10B981), Color(0xFF059669), Color(0xFF047857)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 165,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final b = _banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: b.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: b.gradientColors.first.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              b.tag,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            b.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            b.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      b.icon,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 58,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Carousel Dot Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (index) {
            final isSelected = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isSelected ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).dividerColor.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
