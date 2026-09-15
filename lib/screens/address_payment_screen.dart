import 'package:flutter/material.dart';

class AddressPaymentScreen extends StatefulWidget {
  const AddressPaymentScreen({super.key});

  @override
  State<AddressPaymentScreen> createState() => _AddressPaymentScreenState();
}

class _AddressPaymentScreenState extends State<AddressPaymentScreen> {
  final List<Map<String, String>> _addresses = [
    {
      'title': 'Home Address',
      'address': '124 Innovation Way, Silicon Valley, CA 94025',
      'phone': '+1 (555) 019-2834',
      'isDefault': 'true',
    },
    {
      'title': 'Office',
      'address': '45 Tech Boulevard, Suite 300, San Francisco, CA 94107',
      'phone': '+1 (555) 012-9988',
      'isDefault': 'false',
    },
  ];

  void _showAddAddressDialog() {
    final titleController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Shipping Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Address Label (e.g. Home / Office)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Full Street Address',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && addressController.text.isNotEmpty) {
                setState(() {
                  _addresses.add({
                    'title': titleController.text,
                    'address': addressController.text,
                    'phone': phoneController.text,
                    'isDefault': 'false',
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Address'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses & Payments'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping Addresses',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: theme.colorScheme.primary,
                onPressed: _showAddAddressDialog,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Address List Cards
          ..._addresses.map((item) {
            final isDefault = item['isDefault'] == 'true';
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              item['title']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        if (isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Default',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(item['address']!, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(item['phone']!, style: TextStyle(color: theme.hintColor, fontSize: 12)),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 20),
          Text(
            'Saved Payment Cards',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.credit_card_rounded, color: Colors.indigo, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Visa •••• 4242', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text('Expires 08/28', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const Icon(Icons.check_circle_rounded, color: Colors.green),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
