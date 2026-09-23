import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      'text': 'Hello Simpal! 👋 I am your Emergent AI Shopping Assistant powered by Python 🐍. How can I help you today?',
      'time': 'Just now',
      'quickReplies': ['Track Order', 'Festive Sale 50% OFF', 'Flash Sale Deals', 'Coupons & Coins'],
      'recommendation': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkPythonServerHealth();
  }

  // Check if Python Chatbot HTTP Server is online
  Future<void> _checkPythonServerHealth() async {
    try {
      final response = await http
          .get(Uri.parse('http://10.0.2.2:5000/health'))
          .timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        setState(() {
          _isPythonServerOnline = true;
        });
      }
    } catch (_) {
      // Python server offline; fallback to local AI engine
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

    // Call Python Server API or Local AI Engine Fallback
    Map<String, dynamic> botReply;

    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/chat');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': query}),
      ).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
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

  // Smart Local Fallback Response Engine
  Map<String, dynamic> _generateLocalFallbackResponse(String query) {
    final msg = query.lowerCase;

    if (msg.contains('order') || msg.contains('track') || msg.contains('delivery')) {
      return {
        'isUser': false,
        'text': '🚚 Your order #EMG-89241 is Out for Delivery today by 6:00 PM with partner Rajesh Kumar!',
        'time': 'Just now',
        'quickReplies': ['Track Live Status', 'Contact Delivery Agent'],
        'recommendation': {
          'title': 'Order #EMG-89241',
          'subtitle': 'Arriving Today by 6 PM',
          'action': 'TRACK_ORDER',
        },
      };
    } else if (msg.contains('saree') || msg.contains('ethnic') || msg.contains('kurti')) {
      return {
        'isUser': false,
        'text': '✨ Here is our top trending Silk Blend Banarasi Designer Saree at 56% OFF!',
        'time': 'Just now',
        'quickReplies': ['View Sarees', 'Apply FESTIVE50'],
        'recommendation': {
          'title': 'Silk Blend Banarasi Designer Saree',
          'price': '₹1,299',
          'action': 'VIEW_PRODUCT',
        },
      };
    } else if (msg.contains('coupon') || msg.contains('discount') || msg.contains('offer')) {
      return {
        'isUser': false,
        'text': '🎁 Use code FESTIVE50 at checkout for Flat 50% OFF + 200 Bonus Coins!',
        'time': 'Just now',
        'quickReplies': ['Copy Code FESTIVE50', 'Scratch & Win'],
        'recommendation': {
          'title': 'FESTIVE50 Promo Coupon',
          'subtitle': 'Flat 50% OFF',
          'action': 'COPY_COUPON',
        },
      };
    } else {
      return {
        'isUser': false,
        'text': 'I am Python AI Assistant 🤖. You can ask me about deals, orders, sarees, or coupons!',
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
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_rounded, color: Colors.indigo, size: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergent AI Chatbot',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: _isPythonServerOnline ? Colors.green : Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _isPythonServerOnline ? 'Python Server Online 🐍' : 'Local AI Engine 🤖',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _isPythonServerOnline ? Colors.green : Colors.amber.shade800,
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
          // Python Server Status Header Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: _isPythonServerOnline
                ? Colors.green.withValues(alpha: 0.12)
                : Colors.amber.withValues(alpha: 0.12),
            child: Row(
              children: [
                Icon(
                  _isPythonServerOnline ? Icons.check_circle_outline : Icons.info_outline_rounded,
                  color: _isPythonServerOnline ? Colors.green : Colors.amber.shade900,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _isPythonServerOnline
                        ? 'Connected to Python Backend (http://0.0.0.0:5000)'
                        : 'Python Server offline. Using embedded smart AI engine.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _isPythonServerOnline ? Colors.green.shade900 : Colors.amber.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                      // Chat Bubble
                      Row(
                        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUser) ...[
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.indigo.shade100,
                              child: const Icon(Icons.smart_toy_rounded, color: Colors.indigo, size: 16),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? theme.colorScheme.primary
                                    : (isDark ? const Color(0xFF1E293B) : Colors.white),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(18),
                                  topRight: const Radius.circular(18),
                                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                                  bottomRight: Radius.circular(isUser ? 4 : 18),
                                ),
                                border: isUser
                                    ? null
                                    : Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                msg['text'],
                                style: TextStyle(
                                  color: isUser ? Colors.white : (isDark ? Colors.white : Colors.black87),
                                  fontSize: 14,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Recommendation Card Widget (if available)
                      if (rec != null) ...[
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 36),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E293B) : Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.indigo.shade200),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.stars_rounded, color: Colors.indigo, size: 32),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                  child: const Text('Open', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      // Quick Reply Chips
                      if (quickReplies != null && quickReplies.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 36),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 6,
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
                                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
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
                    'Python AI is typing...',
                    style: TextStyle(color: theme.hintColor, fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

          // Input Text Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.cardTheme.color ?? theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Ask Python AI about products, deals, order...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                    onSubmitted: (_) => _handleSendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 22,
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

extension StringExtension on String {
  String get lowerCase => toLowerCase();
}
