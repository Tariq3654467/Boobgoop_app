import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class PartnerDashboardScreen extends StatefulWidget {
  const PartnerDashboardScreen({super.key});

  @override
  State<PartnerDashboardScreen> createState() => _PartnerDashboardScreenState();
}

class _PartnerDashboardScreenState extends State<PartnerDashboardScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _impactData;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchImpact();
  }

  Future<void> _fetchImpact() async {
    try {
      final data = await _apiService.getImpactReport();
      setState(() {
        _impactData = data;
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
        title: const Text('Partner Dashboard'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
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
            Text('Error loading impact data', style: Theme.of(context).textTheme.titleLarge),
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
                _fetchImpact();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final data = _impactData ?? {};
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Global Impact Metrics',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            context,
            title: 'Total Farmers Empowered',
            value: '${data['totalFarmers'] ?? 0}',
            icon: Icons.group,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildStatCard(
            context,
            title: 'Active Buyers Connectivity',
            value: '${data['totalBuyers'] ?? 0}',
            icon: Icons.store,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildStatCard(
            context,
            title: 'Products in Marketplace',
            value: '${data['activeProducts'] ?? 0}',
            icon: Icons.agriculture,
            color: AppColors.accentOrange,
          ),
          const SizedBox(height: 24),
          Text(
            'Active Regions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (data['regions'] != null)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (data['regions'] as List).map((r) => Chip(label: Text(r.toString()))).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
