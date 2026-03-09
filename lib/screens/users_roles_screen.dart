import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class UsersRolesScreen extends StatefulWidget {
  const UsersRolesScreen({super.key});

  @override
  State<UsersRolesScreen> createState() => _UsersRolesScreenState();
}

class _UsersRolesScreenState extends State<UsersRolesScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _users = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final res = await _apiService.getEndpoint('/users');
      if (res['success'] == true) {
        setState(() {
          _users = res['data'] ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users & Roles'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            const Text('Error loading users'),
            ElevatedButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _fetchUsers();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_users.isEmpty) return const Center(child: Text('No users found.'));

    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final u = _users[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(u['name'] ?? 'Unknown User'),
          subtitle: Text(u['email'] ?? 'No email'),
          trailing: Chip(label: Text(u['role'] ?? 'USER', style: const TextStyle(fontSize: 10))),
        );
      },
    );
  }
}
