import 'package:flutter/material.dart';

class LiveShoppingScreen extends StatefulWidget {
  const LiveShoppingScreen({super.key});

  @override
  State<LiveShoppingScreen> createState() => _LiveShoppingScreenState();
}

class _LiveShoppingScreenState extends State<LiveShoppingScreen> {
  int _likesCount = 2840;
  final List<String> _comments = [
    'Riya: Wow! The design on this saree is stunning 😍',
    'Vikram: What is the fabric material?',
    'Kavita: Is free delivery available?',
    'Simpal Host: Yes Kavita! Free express delivery for live viewers today! 🎉',
    'Neha: Just bought 2 items! Cant wait for delivery!',
  ];

  final TextEditingController _commentController = TextEditingController();

  void _sendComment() {
    if (_commentController.text.trim().isEmpty) return;
    setState(() {
      _comments.add('You: ${_commentController.text.trim()}');
      _commentController.clear();
    });
  }

  void _addLike() {
    setState(() {
      _likesCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Simulated Live Stream Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E1065), Color(0xFF581C87), Color(0xFF0F172A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'LIVE SHOPPING SHOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Exclusive Festival Saree & Jewellery Showcase',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),

          // Top Header Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.amber.shade200,
                    child: const Icon(Icons.face_3, color: Colors.purple),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Emergent Studio Live',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        'Host: Designer Ananya',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // LIVE Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.circle, color: Colors.white, size: 8),
                        SizedBox(width: 4),
                        Text(
                          'LIVE 3.4k',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Content Overlay (Pinned Product & Chat)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withValues(alpha: 0.9), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Live Chat Messages
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[_comments.length - 1 - index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              comment,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Pinned Featured Product Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.pink.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.checkroom_rounded, color: Colors.pinkAccent, size: 28),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Handcrafted Silk Festival Saree',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    '₹1,899',
                                    style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    '₹3,999',
                                    style: TextStyle(color: Colors.grey, fontSize: 11, decoration: TextDecoration.lineThrough),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    '52% OFF',
                                    style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('🎉 Live Deal Applied! Added Handcrafted Silk Saree to Cart'),
                                backgroundColor: Colors.pink,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          ),
                          child: const Text('BUY NOW', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Comment Input & Like Floating Button Row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Say something in live chat...',
                            hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
                            filled: true,
                            fillColor: Colors.white.withValues(alpha: 0.15),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: (_) => _sendComment(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _sendComment,
                        icon: const Icon(Icons.send_rounded, color: Colors.amber),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: _addLike,
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.pink.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.pinkAccent),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '$_likesCount',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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
          ),
        ],
      ),
    );
  }
}
