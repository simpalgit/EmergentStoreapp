import 'package:flutter/material.dart';

class VideoFindsScreen extends StatelessWidget {
  const VideoFindsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Finds',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) {
          final titles = [
            'Banarasi Silk Saree Unboxing & Drape Tutorial ✨',
            'Top 5 Summer Kurtis Under ₹399 💃',
            'Trending Kundan Jewellery Set Review 💎',
          ];
          final colors = [
            Colors.purple.shade900,
            Colors.pink.shade900,
            Colors.amber.shade900,
          ];

          return Container(
            color: colors[index % colors.length],
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_circle_fill_rounded, size: 80, color: Colors.white),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          titles[index % titles.length],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 80,
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.white, size: 32),
                        onPressed: () {},
                      ),
                      const Text('12.4k', style: TextStyle(color: Colors.white, fontSize: 12)),
                      const SizedBox(height: 16),
                      IconButton(
                        icon: const Icon(Icons.comment, color: Colors.white, size: 32),
                        onPressed: () {},
                      ),
                      const Text('482', style: TextStyle(color: Colors.white, fontSize: 12)),
                      const SizedBox(height: 16),
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.white, size: 32),
                        onPressed: () {},
                      ),
                      const Text('Share', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
