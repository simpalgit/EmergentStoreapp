import 'package:flutter/material.dart';

class BannerItem {
  final String tag;
  final String title;
  final String subtitle;
  final String code;
  final IconData icon;
  final List<Color> gradientColors;
  final Color accentColor;

  const BannerItem({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.icon,
    required this.gradientColors,
    required this.accentColor,
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
      tag: '✨ ROYAL FESTIVE COLLECTION',
      title: 'Grand Festive Sale',
      subtitle: 'Flat 50% OFF on Luxury Sarees & Suits',
      code: 'FESTIVE50',
      icon: Icons.checkroom_rounded,
      gradientColors: [Color(0xFF4C1D95), Color(0xFF6D28D9), Color(0xFF8B5CF6)],
      accentColor: Color(0xFFF59E0B),
    ),
    BannerItem(
      tag: '⚡ FLASH SALE • LIMITED DEAL',
      title: 'Up to 70% OFF',
      subtitle: 'Top Brands in Footwear & Electronics',
      code: 'SUPER70',
      icon: Icons.bolt_rounded,
      gradientColors: [Color(0xFF881337), Color(0xFFBE123C), Color(0xFFE11D48)],
      accentColor: Color(0xFFFDE047),
    ),
    BannerItem(
      tag: '💎 HANDCRAFTED LUXURY',
      title: 'Artisan Heritage',
      subtitle: 'Exclusive Pure Silk & Silver Jewellery',
      code: 'ROYAL100',
      icon: Icons.auto_awesome_rounded,
      gradientColors: [Color(0xFF064E3B), Color(0xFF047857), Color(0xFF10B981)],
      accentColor: Color(0xFFF59E0B),
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
          height: 180,
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: b.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: b.gradientColors.first.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Background Glow Accent Circle
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: b.accentColor.withValues(alpha: 0.5)),
                                ),
                                child: Text(
                                  b.tag,
                                  style: TextStyle(
                                    color: b.accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                b.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                b.subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(height: 12),
                              // CTA Button
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('🎉 Promo Code "${b.code}" Applied!'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'SHOP DEALS',
                                        style: TextStyle(
                                          color: b.gradientColors.first,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: b.gradientColors.first,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          b.icon,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 64,
                        ),
                      ],
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
              width: isSelected ? 28 : 8,
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
