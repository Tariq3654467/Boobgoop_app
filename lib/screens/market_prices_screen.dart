import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class MarketPricesScreen extends StatefulWidget {
  const MarketPricesScreen({super.key});

  @override
  State<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _prices = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchPrices();
  }

  Future<void> _fetchPrices() async {
    try {
      final prices = await _apiService.getMarketPrices();
      setState(() {
        _prices = prices;
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
        title: const Text('Market Prices'),
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
            Text('Error loading prices', style: Theme.of(context).textTheme.titleLarge),
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
                _fetchPrices();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_prices.isEmpty) {
      return const Center(
        child: Text('No market prices available.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _prices.length,
      itemBuilder: (context, index) {
        final price = _prices[index];
        final isPositive = (price['priceChange'] ?? 0) >= 0;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
              child: Icon(Icons.shopping_basket, color: AppColors.primaryBlue),
            ),
            title: Text(
              price['productName'] ?? 'Unknown Product',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${price['market']} - ${price['region']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${price['currency']} ${price['pricePerUnit']}/${price['unit']}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                if (price['priceChangePercent'] != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 14,
                      ),
                      Text(
                        '${price['priceChangePercent']}%',
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
