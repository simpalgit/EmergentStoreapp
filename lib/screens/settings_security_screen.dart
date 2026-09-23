import 'package:flutter/material.dart';

class SettingsSecurityScreen extends StatefulWidget {
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsSecurityScreen({
    super.key,
    required this.currentThemeMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsSecurityScreen> createState() => _SettingsSecurityScreenState();
}

class _SettingsSecurityScreenState extends State<SettingsSecurityScreen> {
  bool _biometricEnabled = true;
  bool _orderNotifications = true;
  bool _promoAlerts = true;
  bool _twoFactorAuth = false;

  void _showChangePasswordDialog() {
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPassController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPassController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🔒 Password updated successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Security'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Theme & Appearance
          Text(
            'App Preferences',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark background theme'),
                  value: isDark,
                  onChanged: (val) {
                    widget.onThemeChanged(val ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_active_outlined, color: Colors.indigo),
                  title: const Text('Order Push Notifications'),
                  subtitle: const Text('Get real-time shipment updates'),
                  value: _orderNotifications,
                  onChanged: (val) => setState(() => _orderNotifications = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.local_offer_outlined, color: Colors.pink),
                  title: const Text('Promotions & Deals Alerts'),
                  subtitle: const Text('Daily discount codes and sale notifications'),
                  value: _promoAlerts,
                  onChanged: (val) => setState(() => _promoAlerts = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Account Security
          Text(
            'Account Security',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock_outline_rounded, color: Colors.amber),
                  title: const Text('Change Password'),
                  subtitle: const Text('Last changed 3 months ago'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _showChangePasswordDialog,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.fingerprint_rounded, color: Colors.teal),
                  title: const Text('Biometric / Fingerprint Lock'),
                  subtitle: const Text('Require fingerprint to open app'),
                  value: _biometricEnabled,
                  onChanged: (val) => setState(() => _biometricEnabled = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.verified_user_outlined, color: Colors.blue),
                  title: const Text('Two-Factor Authentication (2FA)'),
                  subtitle: const Text('SMS OTP on login'),
                  value: _twoFactorAuth,
                  onChanged: (val) => setState(() => _twoFactorAuth = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Privacy & Data
          Text(
            'Privacy & Account Options',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.download_for_offline_outlined, color: Colors.purple),
                  title: const Text('Download My Personal Data'),
                  subtitle: const Text('Request copy of purchase history & profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data export request sent to your registered email!')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_forever_outlined, color: Colors.red),
                  title: const Text('Deactivate / Delete Account', style: TextStyle(color: Colors.red)),
                  subtitle: const Text('Permanently remove account and wallet data'),
                  trailing: const Icon(Icons.chevron_right, color: Colors.red),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Contact support to deactivate account.')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
