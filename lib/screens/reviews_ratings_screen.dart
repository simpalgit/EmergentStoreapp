import 'package:flutter/material.dart';

class ReviewsRatingsScreen extends StatefulWidget {
  final String productName;

  const ReviewsRatingsScreen({
    super.key,
    this.productName = 'Embroidered Cotton Kurta Set',
  });

  @override
  State<ReviewsRatingsScreen> createState() => _ReviewsRatingsScreenState();
}

class _ReviewsRatingsScreenState extends State<ReviewsRatingsScreen> {
  String _selectedFilter = 'All Reviews';

  final List<String> _filters = ['All Reviews', 'With Photos', '5 Stars', '4 Stars', '3 Stars & Below'];

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Priya Sharma',
      'avatarColor': Colors.pink,
      'rating': 5,
      'date': '2 days ago',
      'review': 'Fabric quality is top notch! Fits perfectly as shown in the pictures. Very comfortable for all day wear. High recommended!',
      'helpfulCount': 24,
      'isHelpful': false,
      'verifiedBuyer': true,
      'hasPhoto': true,
    },
    {
      'name': 'Aman Verma',
      'avatarColor': Colors.indigo,
      'rating': 4,
      'date': '1 week ago',
      'review': 'Great value for money. Color is accurate and delivery was very fast (within 3 days). Only 1 star less due to packaging.',
      'helpfulCount': 12,
      'isHelpful': false,
      'verifiedBuyer': true,
      'hasPhoto': false,
    },
    {
      'name': 'Sneha Patel',
      'avatarColor': Colors.purple,
      'rating': 5,
      'date': '2 weeks ago',
      'review': 'Absolutely beautiful design and stitching! Everyone at the party complimented my look. Will buy again from this seller.',
      'helpfulCount': 38,
      'isHelpful': false,
      'verifiedBuyer': true,
      'hasPhoto': true,
    },
  ];

  void _showAddReviewSheet() {
    int rating = 5;
    final reviewController = TextEditingController();

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
                        'Write a Product Review',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Rate "${widget.productName}":',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starNum = index + 1;
                      return IconButton(
                        icon: Icon(
                          starNum <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: Colors.amber,
                          size: 36,
                        ),
                        onPressed: () {
                          setSheetState(() => rating = starNum);
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'What did you like or dislike? Write your honest feedback...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Photo attached!')),
                      );
                    },
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: const Text('Attach Product Photo'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (reviewController.text.trim().isEmpty) return;
                        setState(() {
                          _reviews.insert(0, {
                            'name': 'You (Verified Buyer)',
                            'avatarColor': Colors.teal,
                            'rating': rating,
                            'date': 'Just now',
                            'review': reviewController.text.trim(),
                            'helpfulCount': 0,
                            'isHelpful': false,
                            'verifiedBuyer': true,
                            'hasPhoto': false,
                          });
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Thank you! Your review was submitted.')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Submit Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
        title: const Text('Reviews & Ratings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Product Name Title
          Text(
            widget.productName,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Rating Summary Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardTheme.color ?? theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                // Average Rating Big Number
                Column(
                  children: [
                    const Text(
                      '4.7',
                      style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, height: 1.0),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '1,280 Ratings',
                      style: TextStyle(color: theme.hintColor, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                const VerticalDivider(width: 1),
                const SizedBox(width: 20),
                // Breakdown Progress Bars
                Expanded(
                  child: Column(
                    children: [
                      _RatingRow(starLabel: '5★', percent: 0.75),
                      _RatingRow(starLabel: '4★', percent: 0.18),
                      _RatingRow(starLabel: '3★', percent: 0.04),
                      _RatingRow(starLabel: '2★', percent: 0.02),
                      _RatingRow(starLabel: '1★', percent: 0.01),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Filters
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final f = _filters[index];
                final isSelected = _selectedFilter == f;
                return ChoiceChip(
                  label: Text(f),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedFilter = f);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Customer Reviews List Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Customer Feedback (${_reviews.length})',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: _showAddReviewSheet,
                icon: const Icon(Icons.rate_review_outlined, size: 18),
                label: const Text('Write Review'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Reviews List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reviews.length,
            separatorBuilder: (context, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final r = _reviews[index];
              final isHelpful = r['isHelpful'] as bool;
              final helpfulCount = r['helpfulCount'] as int;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reviewer Row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: (r['avatarColor'] as Color).withValues(alpha: 0.2),
                            child: Text(
                              (r['name'] as String)[0],
                              style: TextStyle(
                                color: r['avatarColor'] as Color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      r['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    if (r['verifiedBuyer'] == true) ...[
                                      const SizedBox(width: 6),
                                      const Icon(Icons.verified, color: Colors.blue, size: 14),
                                    ],
                                  ],
                                ),
                                Text(
                                  r['date'],
                                  style: TextStyle(color: theme.hintColor, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${r['rating']}',
                                  style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Icon(Icons.star_rounded, color: Colors.green.shade900, size: 14),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        r['review'],
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),

                      if (r['hasPhoto'] == true) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.checkroom_rounded, color: theme.colorScheme.primary, size: 28),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.purple.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.photo_outlined, color: Colors.purple, size: 28),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 4),

                      // Helpful row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Was this review helpful?',
                            style: TextStyle(color: theme.hintColor, fontSize: 12),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                r['isHelpful'] = !isHelpful;
                                r['helpfulCount'] = isHelpful ? helpfulCount - 1 : helpfulCount + 1;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isHelpful ? theme.colorScheme.primary.withValues(alpha: 0.15) : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isHelpful ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
                                    size: 16,
                                    color: isHelpful ? theme.colorScheme.primary : theme.hintColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${r['helpfulCount']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isHelpful ? theme.colorScheme.primary : theme.hintColor,
                                    ),
                                  ),
                                ],
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

class _RatingRow extends StatelessWidget {
  final String starLabel;
  final double percent;

  const _RatingRow({required this.starLabel, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text(
              starLabel,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
