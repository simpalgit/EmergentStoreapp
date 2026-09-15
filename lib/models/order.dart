import 'package:flutter/material.dart';
import 'product.dart';

enum OrderStatus { placed, processing, shipping, delivered }

class OrderItem {
  final String orderId;
  final DateTime date;
  final List<Product> products;
  final double totalAmount;
  final OrderStatus status;
  final String deliveryAddress;
  final String trackingNumber;

  const OrderItem({
    required this.orderId,
    required this.date,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.trackingNumber,
  });

  String get statusName {
    switch (status) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipping:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.placed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.orange;
      case OrderStatus.shipping:
        return Colors.deepPurple;
      case OrderStatus.delivered:
        return Colors.green;
    }
  }

  int get progressStep {
    switch (status) {
      case OrderStatus.placed:
        return 1;
      case OrderStatus.processing:
        return 2;
      case OrderStatus.shipping:
        return 3;
      case OrderStatus.delivered:
        return 4;
    }
  }
}

final List<OrderItem> sampleOrders = [
  OrderItem(
    orderId: 'EMG-908214',
    date: DateTime.now().subtract(const Duration(hours: 4)),
    products: [sampleProducts[0], sampleProducts[2]],
    totalAmount: 498.99,
    status: OrderStatus.shipping,
    deliveryAddress: '124 Innovation Way, Silicon Valley, CA 94025',
    trackingNumber: 'TRK-8829104',
  ),
  OrderItem(
    orderId: 'EMG-771203',
    date: DateTime.now().subtract(const Duration(days: 3)),
    products: [sampleProducts[1]],
    totalAmount: 139.49,
    status: OrderStatus.delivered,
    deliveryAddress: '124 Innovation Way, Silicon Valley, CA 94025',
    trackingNumber: 'TRK-7710293',
  ),
  OrderItem(
    orderId: 'EMG-654921',
    date: DateTime.now().subtract(const Duration(days: 12)),
    products: [sampleProducts[3], sampleProducts[5]],
    totalAmount: 149.98,
    status: OrderStatus.delivered,
    deliveryAddress: '45 Tech Boulevard, Suite 300, San Francisco, CA 94107',
    trackingNumber: 'TRK-6643210',
  ),
];
