import 'package:flutter/material.dart';
import '../models/order.dart';
import 'track_order_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders & Tracking'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: sampleOrders.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final order = sampleOrders[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${order.orderId}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${order.date.day}/${order.date.month}/${order.date.year} • ${order.products.length} items',
                            style: TextStyle(color: theme.hintColor, fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: order.statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          order.statusName,
                          style: TextStyle(
                            color: order.statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Progress Step Bar
                  Row(
                    children: [
                      _StepCircle(step: 1, currentStep: order.progressStep, label: 'Placed'),
                      _StepLine(step: 1, currentStep: order.progressStep),
                      _StepCircle(step: 2, currentStep: order.progressStep, label: 'Process'),
                      _StepLine(step: 2, currentStep: order.progressStep),
                      _StepCircle(step: 3, currentStep: order.progressStep, label: 'Shipping'),
                      _StepLine(step: 3, currentStep: order.progressStep),
                      _StepCircle(step: 4, currentStep: order.progressStep, label: 'Delivered'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Products in Order Preview
                  Row(
                    children: order.products.map((p) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: p.badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(p.icon, color: p.badgeColor, size: 24),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 14),

                  // Tracking ID & Amount Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tracking: ${order.trackingNumber}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Total: ₹${order.totalAmount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackOrderScreen(
                                orderId: order.orderId,
                                trackingNumber: order.trackingNumber,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.location_searching_rounded, size: 16),
                        label: const Text('Track Order'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
    );
  }
}

class _StepCircle extends StatelessWidget {
  final int step;
  final int currentStep;
  final String label;

  const _StepCircle({
    required this.step,
    required this.currentStep,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = step <= currentStep;

    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isDone ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.3),
          child: Icon(
            isDone ? Icons.check : Icons.circle,
            size: isDone ? 14 : 8,
            color: isDone ? Colors.white : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
            color: isDone ? theme.colorScheme.primary : theme.hintColor,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final int step;
  final int currentStep;

  const _StepLine({required this.step, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = step < currentStep;

    return Expanded(
      child: Container(
        height: 3,
        color: isDone ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.3),
      ),
    );
  }
}
