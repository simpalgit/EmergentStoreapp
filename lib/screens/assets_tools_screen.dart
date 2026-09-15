import 'package:flutter/material.dart';

class AssetToolItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String category;

  const AssetToolItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.category,
  });
}

class AssetsToolsScreen extends StatelessWidget {
  const AssetsToolsScreen({super.key});

  final List<AssetToolItem> _tools = const [
    AssetToolItem(
      title: 'Visual Camera Search',
      subtitle: 'Snap a picture to find matching products',
      icon: Icons.camera_alt_rounded,
      color: Colors.indigo,
      category: 'Media & Camera',
    ),
    AssetToolItem(
      title: 'Gallery & Picture Picker',
      subtitle: 'Upload product reviews & avatar images',
      icon: Icons.photo_library_rounded,
      color: Colors.purple,
      category: 'Media & Camera',
    ),
    AssetToolItem(
      title: 'Quick Add to Cart',
      subtitle: 'Instant 1-tap cart addition',
      icon: Icons.add_shopping_cart_rounded,
      color: Colors.deepOrange,
      category: 'Commerce',
    ),
    AssetToolItem(
      title: 'Store Locator & Map',
      subtitle: 'Find nearest offline partner store',
      icon: Icons.location_on_rounded,
      color: Colors.red,
      category: 'Commerce',
    ),
    AssetToolItem(
      title: 'Alerts & Bell Center',
      subtitle: 'Configure real-time push notifications',
      icon: Icons.notifications_active_rounded,
      color: Colors.amber,
      category: 'System & Alerts',
    ),
    AssetToolItem(
      title: 'Phone Call Support',
      subtitle: 'Direct hotline to customer executive',
      icon: Icons.call_rounded,
      color: Colors.green,
      category: 'Support',
    ),
    AssetToolItem(
      title: 'Live Chat & Comments',
      subtitle: 'Interactive support & feedback thread',
      icon: Icons.chat_bubble_rounded,
      color: Colors.blue,
      category: 'Support',
    ),
    AssetToolItem(
      title: 'Share Product & Deals',
      subtitle: 'Share link via WhatsApp, SMS, Socials',
      icon: Icons.share_rounded,
      color: Colors.teal,
      category: 'Social',
    ),
    AssetToolItem(
      title: 'Clear Cache & Trash',
      subtitle: 'Delete temporary image cache files',
      icon: Icons.delete_outline_rounded,
      color: Colors.grey,
      category: 'System & Alerts',
    ),
    AssetToolItem(
      title: 'Sync & Refresh Data',
      subtitle: 'Re-sync live product stock & rates',
      icon: Icons.refresh_rounded,
      color: Colors.cyan,
      category: 'System & Alerts',
    ),
    AssetToolItem(
      title: 'Add Apps & Modules',
      subtitle: 'Integrate new feature extensions',
      icon: Icons.add_box_rounded,
      color: Colors.orange,
      category: 'System & Alerts',
    ),
    AssetToolItem(
      title: 'List & Grid Toggle',
      subtitle: 'Switch catalog layout preferences',
      icon: Icons.list_alt_rounded,
      color: Colors.blueGrey,
      category: 'Commerce',
    ),
    AssetToolItem(
      title: 'Attachments & Clip',
      subtitle: 'Attach invoice receipt / proof documents',
      icon: Icons.attach_file_rounded,
      color: Colors.deepPurple,
      category: 'Support',
    ),
    AssetToolItem(
      title: 'App Tools Hub',
      subtitle: 'Explore all registered ecosystem apps',
      icon: Icons.dashboard_rounded,
      color: Colors.pink,
      category: 'System & Alerts',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets & Tools Center'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  const Color(0xFF4338CA),
                ],
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.widgets_rounded, color: Colors.white, size: 44),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '14 Quick Asset Utilities',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Camera, Share, Location, Cart & Support shortcuts',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text(
            'Quick Action Utilities Grid',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tools.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final tool = _tools[index];
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Activated tool: ${tool.title}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: tool.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(tool.icon, color: tool.color, size: 24),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          tool.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tool.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
