import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'User Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Account Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language Preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy & Security'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
