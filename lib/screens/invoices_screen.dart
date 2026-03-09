import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _invoices = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
  }

  Future<void> _fetchInvoices() async {
    try {
      final res = await _apiService.getEndpoint('/finance/invoices');
      if (res['success'] == true) {
        setState(() {
          _invoices = res['data'] ?? [];
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
        title: const Text('Financial Invoices'),
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
            const Icon(Icons.money_off, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            const Text('Error loading invoices'),
            ElevatedButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _fetchInvoices();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_invoices.isEmpty) return const Center(child: Text('No invoices found.'));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _invoices.length,
      itemBuilder: (context, index) {
        final i = _invoices[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.receipt, color: AppColors.primaryBlue),
            title: Text('Invoice #${i['id'] ?? 'Unknown'}'),
            subtitle: Text('Amount: \$${i['amount'] ?? '0.00'}'),
            trailing: Text(
              i['status']?.toString().toUpperCase() ?? 'PENDING',
              style: TextStyle(
                color: i['status'] == 'paid' ? Colors.green : AppColors.accentOrange,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }
}
