import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _posts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await _apiService.getCommunityPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
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
        title: const Text('Community Forum'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Not implemented yet')),
          );
        },
        backgroundColor: AppColors.accentOrange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Error loading posts', style: Theme.of(context).textTheme.titleLarge),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _fetchPosts();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_posts.isEmpty) {
      return const Center(
        child: Text('No posts found. Be the first to start a discussion!'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _posts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final post = _posts[index];
        final author = post['author'] ?? {};
        final name = '${author['firstName'] ?? 'User'} ${author['lastName'] ?? ''}'.trim();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
                  child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (post['category'] != null)
                        Text(
                          post['category'].toString().toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                if (post['isPinned'] == true)
                  Icon(Icons.push_pin, size: 16, color: AppColors.accentOrange),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              post['content'] ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${post['likes'] ?? 0}'),
                const SizedBox(width: 16),
                Icon(Icons.comment_outlined, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${post['commentsCount'] ?? 0}'),
                const Spacer(),
                Text(
                  post['views'] != null ? '${post['views']} views' : '',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
