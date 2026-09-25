import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'track_order_screen.dart';
import 'coupons_rewards_screen.dart';

class AIChatbotScreen extends StatefulWidget {
  final Function(Product p)? onProductTap;

  const AIChatbotScreen({
    super.key,
    this.onProductTap,
  });

  @override
  State<AIChatbotScreen> createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends State<AIChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isTyping = false;
  bool _isPythonServerOnline = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Welcome to EmergentStore Boutique Concierge! 🛍️✨ How may I assist you with orders, styling, or festive discounts today?',
      'time': 'Just now',
      'quickReplies': ['Track Live Order', 'Festive Sarees 50% OFF', 'Flash Sale Deals', 'Claim Free Coupons'],
      'recommendation': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkPythonServerHealth();
  }

  // Check if Chatbot HTTP Server is online using dart:io HttpClient
  Future<void> _checkPythonServerHealth() async {
    try {
      final client = HttpClient()..connectionTimeout = const Duration(seconds: 2);
      final request = await client.getUrl(Uri.parse('http://10.0.2.2:5000/health'));
      final response = await request.close();
      if (response.statusCode == 200) {
        setState(() {
          _isPythonServerOnline = true;
        });
      }
    } catch (_) {
      setState(() {
        _isPythonServerOnline = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSendMessage([String? presetText]) async {
    final query = presetText ?? _textController.text.trim();
    if (query.isEmpty) return;

    if (presetText == null) _textController.clear();

    setState(() {
      _messages.add({
        'isUser': true,
        'text': query,
        'time': 'Just now',
        'quickReplies': null,
        'recommendation': null,
      });
      _isTyping = true;
    });

    _scrollToBottom();

    // Call Server API or Local Assistant Engine Fallback
    Map<String, dynamic> botReply;

    try {
      final client = HttpClient()..connectionTimeout = const Duration(seconds: 3);
      final request = await client.postUrl(Uri.parse('http://10.0.2.2:5000/api/chat'));
      request.headers.set('Content-Type', 'application/json');
      request.write(jsonEncode({'message': query}));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody) as Map<String, dynamic>;
        botReply = {
          'isUser': false,
          'text': data['response'] ?? 'How can I assist you further?',
          'time': 'Just now',
          'quickReplies': data['quick_replies'],
          'recommendation': data['recommendation'],
        };
        _isPythonServerOnline = true;
      } else {
        botReply = _generateLocalFallbackResponse(query);
      }
    } catch (_) {
      botReply = _generateLocalFallbackResponse(query);
    }

    if (!mounted) return;

    setState(() {
      _isTyping = false;
      _messages.add(botReply);
    });

    _scrollToBottom();
  }

  // Smart Handcrafted Local Response Engine
  Map<String, dynamic> _generateLocalFallbackResponse(String query) {
    final msg = query.toLowerCase();

    if (msg.contains('order') || msg.contains('track') || msg.contains('delivery')) {
      return {
        'isUser': false,
        'text': '🚚 Great news! Your order #EMG-89241 is Out for Delivery today by 6:00 PM with partner Rajesh Kumar.',
        'time': 'Just now',
        'quickReplies': ['Track Live Map', 'Call Delivery Partner'],
        'recommendation': {
          'title': 'Order #EMG-89241 • 2 Items',
          'subtitle': 'Arriving Today by 6 PM',
          'action': 'TRACK_ORDER',
        },
      };
    } else if (msg.contains('saree') || msg.contains('ethnic') || msg.contains('kurti')) {
      return {
        'isUser': false,
        'text': '✨ Here is our top recommended Silk Blend Banarasi Designer Saree with flat 56% OFF!',
        'time': 'Just now',
        'quickReplies': ['View Sarees', 'Apply FESTIVE50 Code'],
        'recommendation': {
          'title': 'Silk Blend Banarasi Designer Saree',
          'price': '₹1,299',
          'action': 'VIEW_PRODUCT',
        },
      };
    } else if (msg.contains('coupon') || msg.contains('discount') || msg.contains('offer')) {
      return {
        'isUser': false,
        'text': '🎁 Use promo code FESTIVE50 at checkout for Flat 50% OFF + 200 Bonus Coins!',
        'time': 'Just now',
        'quickReplies': ['Copy Code FESTIVE50', 'Scratch & Win'],
        'recommendation': {
          'title': 'FESTIVE50 Promo Coupon',
          'subtitle': 'Flat 50% Instant Discount',
          'action': 'COPY_COUPON',
        },
      };
    } else {
      return {
        'isUser': false,
        'text': 'I am your Emergent Shopping Concierge 💬. How can I help you find products or check delivery updates?',
        'time': 'Just now',
        'quickReplies': ['Track Order', 'Festive Sale 50% OFF', 'Flash Sale Deals', 'Wallet & Coins'],
        'recommendation': null,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
              child: Icon(Icons.support_agent_rounded, color: theme.colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergent Chat Board',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      _isPythonServerOnline ? 'Python Server Online 🐍' : 'Live Concierge 💬',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                final quickReplies = msg['quickReplies'] as List<dynamic>?;
                final rec = msg['recommendation'] as Map<String, dynamic>?;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      // Chat Bubble Container
                      Row(
                        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUser) ...[
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                              child: Icon(Icons.support_agent_rounded, color: theme.colorScheme.primary, size: 18),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? theme.colorScheme.primary
                                    : (isDark ? const Color(0xFF1E293B) : Colors.white),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20),
                                  topRight: const Radius.circular(20),
                                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                                  bottomRight: Radius.circular(isUser ? 4 : 20),
                                ),
                                border: isUser
                                    ? null
                                    : Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                msg['text'],
                                style: TextStyle(
                                  color: isUser ? Colors.white : (isDark ? Colors.white : const Color(0xFF1E293B)),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Rich Recommendation Card (if present)
                      if (rec != null) ...[
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E293B) : Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.indigo.shade200),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.stars_rounded, color: theme.colorScheme.primary, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rec['title'] ?? 'Featured Item',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                      if (rec['subtitle'] != null || rec['price'] != null) ...[
                                        const SizedBox(height: 2),
                                        Text(
                                          rec['subtitle'] ?? rec['price'] ?? '',
                                          style: TextStyle(color: theme.hintColor, fontSize: 11),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final action = rec['action'];
                                    if (action == 'TRACK_ORDER') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const TrackOrderScreen()),
                                      );
                                    } else if (action == 'COPY_COUPON') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CouponsRewardsScreen()),
                                      );
                                    } else {
                                      if (widget.onProductTap != null) {
                                        widget.onProductTap!(sampleProducts.first);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  ),
                                  child: const Text('Open', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      // Quick Action Chips
                      if (quickReplies != null && quickReplies.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: quickReplies.map((reply) {
                              return ActionChip(
                                label: Text(
                                  reply.toString(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.08),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.25)),
                                ),
                                onPressed: () => _handleSendMessage(reply.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),

          // Typing Indicator
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    'Chat Board is typing...',
                    style: TextStyle(color: theme.hintColor, fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

          // Handcrafted Dock Input Field
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Ask Chat Board about orders, sarees, deals...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    ),
                    onSubmitted: (_) => _handleSendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    onPressed: () => _handleSendMessage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
