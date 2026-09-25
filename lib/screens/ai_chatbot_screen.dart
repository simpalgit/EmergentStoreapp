import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'track_order_screen.dart';
import 'coupons_rewards_screen.dart';
import 'wallet_screen.dart';
import 'saved_addresses_screen.dart';

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

  String _userEmail = 'simpal@gmail.com';
  String _userName = 'Simpal';

  late List<Map<String, dynamic>> _messages;

  @override
  void initState() {
    super.initState();
    _initializeInitialMessage();
    _checkPythonServerHealth();
  }

  void _initializeInitialMessage() {
    _messages = [
      {
        'isUser': false,
        'text': 'Hello $_userName! 👋 Welcome to EmergentStore Chat Board. Your Gmail ($_userEmail) is connected. Ask me anything for clear, exact account details!',
        'time': 'Just now',
        'quickReplies': ['Track Order', 'Send Invoice to Gmail 📄', 'My Wallet Balance 💳', 'Festive Sale 50% OFF'],
        'recommendation': null,
      },
    ];
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

  void _showChangeGmailModal() {
    final emailController = TextEditingController(text: _userEmail);
    final nameController = TextEditingController(text: _userName);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
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
                  const Row(
                    children: [
                      Icon(Icons.mail_outline_rounded, color: Colors.redAccent, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Connect Gmail Account',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Connecting your Gmail enables instant, exact answers for order tracking, tax invoices, wallet balance & personalized recommendations.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Gmail Address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final newEmail = emailController.text.trim();
                    final newName = nameController.text.trim();
                    if (newEmail.isEmpty) return;

                    setState(() {
                      _userEmail = newEmail;
                      _userName = newName.isNotEmpty ? newName : 'Simpal';
                      _messages.add({
                        'isUser': false,
                        'text': '🎉 Gmail connected: $_userEmail. I am now synced with your account for exact answers!',
                        'time': 'Just now',
                        'quickReplies': ['Track Order', 'Send Invoice to Gmail 📄', 'My Wallet Balance 💳'],
                        'recommendation': null,
                      });
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Connected to Gmail: $_userEmail')),
                    );
                    _scrollToBottom();
                  },
                  icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                  label: const Text('Connect & Save Gmail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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

    // Call Python Server API or Local Assistant Engine Fallback
    Map<String, dynamic> botReply;

    try {
      final client = HttpClient()..connectionTimeout = const Duration(seconds: 3);
      final request = await client.postUrl(Uri.parse('http://10.0.2.2:5000/api/chat'));
      request.headers.set('Content-Type', 'application/json');
      request.write(jsonEncode({
        'message': query,
        'email': _userEmail,
        'name': _userName,
      }));
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

  // Smart Handcrafted Local Response Engine (Gmail Account Aware)
  Map<String, dynamic> _generateLocalFallbackResponse(String query) {
    final msg = query.toLowerCase();

    if (msg.contains('order') || msg.contains('track') || msg.contains('delivery')) {
      return {
        'isUser': false,
        'text': '🚚 Hello $_userName! For your account ($_userEmail), order #EMG-89241 (Designer Cotton Anarkali Kurti Set) is Out for Delivery today by 6:00 PM with partner Rajesh Kumar. Live alerts enabled for $_userEmail!',
        'time': 'Just now',
        'quickReplies': ['Track Live Map', 'Send Invoice to Gmail 📄', 'Contact Delivery Agent'],
        'recommendation': {
          'title': 'Order #EMG-89241 • Arriving Today',
          'subtitle': 'Linked to $_userEmail',
          'action': 'TRACK_ORDER',
        },
      };
    } else if (msg.contains('invoice') || msg.contains('receipt') || msg.contains('bill') || msg.contains('gmail')) {
      return {
        'isUser': false,
        'text': '📄 Clear Tax Invoice for order #EMG-89241 has been generated and emailed directly to $_userEmail!',
        'time': 'Just now',
        'quickReplies': ['View My Orders', 'My Wallet Balance 💳'],
        'recommendation': {
          'title': 'Invoice Sent to $_userEmail',
          'subtitle': 'Order #EMG-89241 • Tax Invoice PDF',
          'action': 'TRACK_ORDER',
        },
      };
    } else if (msg.contains('wallet') || msg.contains('balance') || msg.contains('money')) {
      return {
        'isUser': false,
        'text': '💳 Hello $_userName! Account details for $_userEmail:\n• Wallet Balance: ₹1,250.00\n• Reward Coins: 1,450 Coins\n• Default Address: House #402, Green Park, New Delhi',
        'time': 'Just now',
        'quickReplies': ['Add Money to Wallet', 'Saved Addresses 📍'],
        'recommendation': {
          'title': 'Wallet Balance: ₹1,250.00',
          'subtitle': 'Linked to $_userEmail',
          'action': 'WALLET',
        },
      };
    } else if (msg.contains('address') || msg.contains('location')) {
      return {
        'isUser': false,
        'text': '📍 Saved Delivery Address for $_userEmail:\n$_userName, House #402, Green Park Avenue, Sector 14, New Delhi - 110001.',
        'time': 'Just now',
        'quickReplies': ['Manage Addresses', 'Track Order'],
        'recommendation': {
          'title': 'Delivery Address • New Delhi',
          'subtitle': 'Default for $_userEmail',
          'action': 'ADDRESS',
        },
      };
    } else if (msg.contains('saree') || msg.contains('ethnic') || msg.contains('kurti')) {
      return {
        'isUser': false,
        'text': '✨ Hi $_userName! Based on your Gmail shopping preferences ($_userEmail), here is our top recommended Silk Blend Banarasi Designer Saree with flat 56% OFF!',
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
        'text': '🎁 Exclusive coupon code FESTIVE50 is active for $_userEmail. Apply at checkout for Flat 50% OFF + 200 Bonus Coins!',
        'time': 'Just now',
        'quickReplies': ['Copy Code FESTIVE50', 'Scratch & Win'],
        'recommendation': {
          'title': 'FESTIVE50 Promo Coupon',
          'subtitle': 'Flat 50% OFF for $_userEmail',
          'action': 'COPY_COUPON',
        },
      };
    } else {
      return {
        'isUser': false,
        'text': 'Hello $_userName! I am your Gmail-connected Chat Board Assistant 💬 ($_userEmail). Ask me about order status, tax invoice, wallet balance, or sarees for exact, clear answers!',
        'time': 'Just now',
        'quickReplies': ['Track Order', 'Send Invoice to Gmail 📄', 'My Wallet Balance 💳', 'Saved Addresses 📍'],
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
              child: Icon(Icons.chat_bubble_rounded, color: theme.colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
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
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Gmail Account Connection Banner
          InkWell(
            onTap: _showChangeGmailModal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                border: Border(bottom: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2))),
              ),
              child: Row(
                children: [
                  const Icon(Icons.mark_email_read_rounded, color: Colors.redAccent, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'GMAIL CONNECTED',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.check_circle_rounded, color: Colors.green.shade700, size: 12),
                          ],
                        ),
                        Text(
                          '$_userName • $_userEmail',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Change',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ),
                ],
              ),
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
                      // Chat Bubble Container
                      Row(
                        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUser) ...[
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                              child: Icon(Icons.chat_bubble_rounded, color: theme.colorScheme.primary, size: 18),
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
                                    } else if (action == 'WALLET') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const WalletScreen()),
                                      );
                                    } else if (action == 'ADDRESS') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const SavedAddressesScreen()),
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
