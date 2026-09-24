import 'package:flutter/material.dart';

class ReturnRequestScreen extends StatefulWidget {
  final String orderId;

  const ReturnRequestScreen({
    super.key,
    this.orderId = 'EMG-89241',
  });

  @override
  State<ReturnRequestScreen> createState() => _ReturnRequestScreenState();
}

class _ReturnRequestScreenState extends State<ReturnRequestScreen> {
  String _selectedReason = 'Size / Fitting Issue';
  String _returnAction = 'Exchange Size'; // or 'Refund to Wallet'

  final List<String> _reasons = [
    'Size / Fitting Issue',
    'Defective or Damaged Item',
    'Wrong Product Delivered',
    'Quality Not as Expected',
    'Changed My Mind',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Return / Exchange Order #${widget.orderId}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Order Header Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.pink.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.checkroom_rounded, color: Colors.pink, size: 32),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Designer Cotton Anarkali Kurti Set',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Delivered on 15 Sep 2026 • Size: M',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Select Return / Exchange Action
          Text(
            'What would you like to do?',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _returnAction = 'Exchange Size'),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _returnAction == 'Exchange Size'
                          ? theme.colorScheme.primary.withValues(alpha: 0.12)
                          : (isDark ? const Color(0xFF1E293B) : Colors.white),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _returnAction == 'Exchange Size' ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.published_with_changes_rounded,
                          color: _returnAction == 'Exchange Size' ? theme.colorScheme.primary : Colors.grey,
                          size: 28,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Exchange Size',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _returnAction == 'Exchange Size' ? theme.colorScheme.primary : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _returnAction = 'Refund to Wallet'),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _returnAction == 'Refund to Wallet'
                          ? theme.colorScheme.primary.withValues(alpha: 0.12)
                          : (isDark ? const Color(0xFF1E293B) : Colors.white),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _returnAction == 'Refund to Wallet' ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: _returnAction == 'Refund to Wallet' ? theme.colorScheme.primary : Colors.grey,
                          size: 28,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Refund to Wallet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _returnAction == 'Refund to Wallet' ? theme.colorScheme.primary : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Select Reason
          Text(
            'Select Reason for Return / Exchange',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Card(
            child: Column(
              children: _reasons.map((reason) {
                final isSelected = _selectedReason == reason;
                return RadioListTile<String>(
                  title: Text(reason, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                  value: reason,
                  groupValue: _selectedReason,
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedReason = val);
                  },
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          // Upload Item Photo Box
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item photo attached for inspection!')),
              );
            },
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text('Attach Item Photo (Optional)'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          const SizedBox(height: 28),

          // Submit Request Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      title: const Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: Colors.green, size: 28),
                          SizedBox(width: 8),
                          Text('Request Submitted'),
                        ],
                      ),
                      content: Text(
                        'Your $_returnAction request for order #${widget.orderId} has been placed. Doorstep pickup is scheduled for tomorrow by 11:00 AM.',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary),
                          child: const Text('OK', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Submit Return Request', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
