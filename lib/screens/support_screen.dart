import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'How long does shipping take?',
      'answer': 'Standard shipping takes 2-3 business days. Express next-day shipping is available at checkout.',
    },
    {
      'question': 'What is your return policy?',
      'answer': 'We offer a 30-day hassle-free return policy for all unused items with original tags and packaging.',
    },
    {
      'question': 'How can I apply discount promo codes?',
      'answer': 'Enter your promo code (e.g. EMERGENT20) on the My Cart checkout summary screen before placing your order.',
    },
    {
      'question': 'Are my payment details secure?',
      'answer': 'Yes, all transactions are encrypted using bank-grade AES-256 SSL encryption and PCI-DSS compliance.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Contact Us Quick Cards
          Row(
            children: [
              Expanded(
                child: Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Starting live support chat...')),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded, color: theme.colorScheme.primary, size: 28),
                          const SizedBox(height: 8),
                          const Text('Live Chat', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Available 24/7', style: TextStyle(fontSize: 11, color: theme.hintColor)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Calling +1 (800) EMERGENT...')),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Icon(Icons.phone_outlined, color: Colors.green, size: 28),
                          const SizedBox(height: 8),
                          const Text('Call Center', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Toll Free 24/7', style: TextStyle(fontSize: 11, color: theme.hintColor)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text(
            'Frequently Asked Questions',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // FAQ Expansion Panels
          Card(
            child: Column(
              children: _faqs.map((faq) {
                return ExpansionTile(
                  title: Text(
                    faq['question']!,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        faq['answer']!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
