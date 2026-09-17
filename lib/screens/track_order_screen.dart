import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;
  final String trackingNumber;

  const TrackOrderScreen({
    super.key,
    this.orderId = 'EMG-89241',
    this.trackingNumber = 'EMG9872140',
  });

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final List<Map<String, dynamic>> _timelineSteps = [
    {
      'title': 'Order Placed & Confirmed',
      'subtitle': '15 Sep 2026, 10:30 AM',
      'location': 'Emergent Store Hub, Mumbai',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'Packed at Warehouse',
      'subtitle': '15 Sep 2026, 04:15 PM',
      'location': 'Central Fulfillment Center, Pune',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'In Transit via Express Courier',
      'subtitle': '16 Sep 2026, 08:00 AM',
      'location': 'Sort Facility, New Delhi',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'Out for Delivery Today',
      'subtitle': 'Expected by 06:00 PM',
      'location': 'Local Hub, Connaught Place',
      'isCompleted': false,
      'isCurrent': true,
    },
    {
      'title': 'Delivered',
      'subtitle': 'Awaiting delivery',
      'location': 'Your Delivery Address',
      'isCompleted': false,
      'isCurrent': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order #${widget.orderId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tracking link for ${widget.trackingNumber} copied!')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Order Summary Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, Colors.indigo.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
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
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'ARRIVING TODAY',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const Icon(Icons.local_shipping_rounded, color: Colors.white, size: 28),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Estimated Delivery: Today by 6:00 PM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'AWB Tracking ID: ${widget.trackingNumber} • Express Courier',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Delivery Driver Agent Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.indigo.shade100,
                    child: const Icon(Icons.person_pin_circle_rounded, color: Colors.indigo, size: 32),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Rajesh Kumar',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                            Text(' 4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Delivery Agent • On the way to your address',
                          style: TextStyle(color: theme.hintColor, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.indigo),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Calling delivery partner Rajesh Kumar...')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Live Progress Timeline Title
          Text(
            'Shipment Progress Timeline',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // Stepper Timeline
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _timelineSteps.length,
            itemBuilder: (context, index) {
              final step = _timelineSteps[index];
              final isCompleted = step['isCompleted'] as bool;
              final isCurrent = step['isCurrent'] as bool;
              final isLast = index == _timelineSteps.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dot & Vertical Line Column
                    Column(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCurrent
                                ? Colors.amber
                                : (isCompleted ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.3)),
                            border: isCurrent ? Border.all(color: theme.colorScheme.primary, width: 3) : null,
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : (isCurrent ? Icons.directions_bike_rounded : Icons.circle),
                            size: 14,
                            color: isCurrent ? Colors.black : Colors.white,
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 3,
                              color: isCompleted ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.3),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    // Step Info
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step['title'],
                              style: TextStyle(
                                fontWeight: (isCompleted || isCurrent) ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                                color: (isCompleted || isCurrent) ? null : theme.hintColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${step['subtitle']} • ${step['location']}',
                              style: TextStyle(color: theme.hintColor, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // Address Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.redAccent, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery Address',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Simpal, House #402, Green Park Avenue, Sector 14, New Delhi - 110001',
                          style: TextStyle(color: theme.hintColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
