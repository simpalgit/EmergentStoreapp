import 'package:flutter/material.dart';

class CouponsRewardsScreen extends StatefulWidget {
  const CouponsRewardsScreen({super.key});

  @override
  State<CouponsRewardsScreen> createState() => _CouponsRewardsScreenState();
}

class _CouponsRewardsScreenState extends State<CouponsRewardsScreen> {
  int _coinsBalance = 1450;
  final Set<String> _copiedCoupons = {};
  final Set<int> _scratchedCards = {};

  final List<Map<String, dynamic>> _scratchCards = [
    {
      'id': 1,
      'title': 'Daily Mystery Rewards',
      'reward': '₹150 OFF Coupon',
      'code': 'MYSTERY150',
      'color': Colors.purple,
    },
    {
      'id': 2,
      'title': 'Festive Special Scratch',
      'reward': '200 Bonus Coins',
      'code': 'COIN200',
      'color': Colors.amber,
    },
    {
      'id': 3,
      'title': 'Super Saver Scratch',
      'reward': 'Free Delivery Pass',
      'code': 'FREESHIPX',
      'color': Colors.teal,
    },
  ];

  final List<Map<String, dynamic>> _coupons = [
    {
      'code': 'FESTIVE50',
      'title': 'Flat 50% OFF on Festive Wear',
      'subtitle': 'Valid on orders above ₹999 • Expires in 2 days',
      'discount': '50% OFF',
      'badgeColor': Colors.pink,
    },
    {
      'code': 'WELCOME100',
      'title': 'Flat ₹100 Instant Discount',
      'subtitle': 'For your next order • No minimum cart value',
      'discount': '₹100 OFF',
      'badgeColor': Colors.indigo,
    },
    {
      'code': 'FREESHIP',
      'title': 'Free Express Delivery',
      'subtitle': 'Zero delivery fee on all footwear & apparel',
      'discount': 'FREE SHIP',
      'badgeColor': Colors.teal,
    },
    {
      'code': 'SUPER20',
      'title': 'Extra 20% Cashback',
      'subtitle': 'Max cashback ₹300 credited to Emergent Wallet',
      'discount': '20% CB',
      'badgeColor': Colors.orange,
    },
  ];

  void _scratchCard(int id, String reward) {
    if (_scratchedCards.contains(id)) return;
    setState(() {
      _scratchedCards.add(id);
      if (reward.contains('Coins')) {
        _coinsBalance += 200;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 Congratulations! You won $reward'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _copyCoupon(String code) {
    setState(() {
      _copiedCoupons.add(code);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Coupon code "$code" copied to clipboard!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupons & Rewards'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 18),
                const SizedBox(width: 6),
                Text(
                  '$_coinsBalance Coins',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Rewards Membership Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
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
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'GOLD MEMBER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.stars_rounded, color: Colors.amber, size: 28),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Emergent Rewards Club',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Earn 10 coins on every ₹100 spent. Redeem for vouchers!',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13),
                ),
                const SizedBox(height: 16),
                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tier Progress (1,450 / 2,000 Coins)',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '550 to Platinum',
                          style: TextStyle(color: Colors.amber.shade200, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 1450 / 2000,
                        minHeight: 8,
                        backgroundColor: Colors.white.withValues(alpha: 0.25),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Scratch Cards Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Scratch & Win Cards 🎁',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '${_scratchCards.length - _scratchedCards.length} Unopened',
                style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _scratchCards.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final card = _scratchCards[index];
                final id = card['id'] as int;
                final isScratched = _scratchedCards.contains(id);
                final cardColor = card['color'] as Color;

                return InkWell(
                  onTap: () => _scratchCard(id, card['reward']),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 150,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isScratched ? Colors.white : cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isScratched ? cardColor : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: cardColor.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isScratched ? Icons.card_giftcard_rounded : Icons.auto_awesome_rounded,
                          color: isScratched ? cardColor : Colors.white,
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isScratched ? card['reward'] : 'Tap to Scratch',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isScratched ? Colors.black87 : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        if (isScratched) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Code: ${card['code']}',
                            style: TextStyle(color: theme.hintColor, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 28),

          // Available Coupons Header
          Text(
            'Available Promo Coupons 🏷️',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // Coupons List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _coupons.length,
            separatorBuilder: (context, index) => const SizedBox(width: 0, height: 12),
            itemBuilder: (context, index) {
              final c = _coupons[index];
              final code = c['code'] as String;
              final isCopied = _copiedCoupons.contains(code);
              final badgeColor = c['badgeColor'] as Color;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.discount_rounded, color: badgeColor, size: 24),
                            const SizedBox(height: 2),
                            Text(
                              c['discount'],
                              style: TextStyle(
                                color: badgeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                code,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              c['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              c['subtitle'],
                              style: TextStyle(
                                color: theme.hintColor,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _copyCoupon(code),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isCopied ? Colors.green : theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        ),
                        child: Text(
                          isCopied ? 'COPIED' : 'COPY',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
