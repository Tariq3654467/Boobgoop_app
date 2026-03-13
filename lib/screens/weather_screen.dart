import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _weather;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      // Dummy coords for Mogadishu, Somalia
      final weather = await _apiService.getWeather(2.0469, 45.3182);
      setState(() {
        _weather = weather;
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
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.weatherForecast),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      final translations = AppLocalizations.of(context).translations;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            Text(translations.errorLoading),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _fetchWeather();
              },
              child: Text(translations.retry),
            ),
          ],
        ),
      );
    }

    final current = _weather?['current'] ?? {};
    final temp = current['temp'] ?? '--';
    final translations = AppLocalizations.of(context).translations;
    final desc = current['condition'] ?? translations.unknownWeather;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny, size: 100, color: AppColors.accentOrange),
          const SizedBox(height: 20),
          Text(
            '$temp°C',
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
          ),
          Text(
            desc.toString().toUpperCase(),
            style: TextStyle(fontSize: 24, color: Colors.grey[700]),
          ),
          const SizedBox(height: 40),
          if (_weather?['forecast'] != null) ...[
            Text(translations.upcomingForecast, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Dummy length for now
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(translations.tomorrow),
                          const SizedBox(height: 8),
                          Icon(Icons.cloud, color: Colors.blueGrey),
                          const SizedBox(height: 8),
                          const Text('30°C'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ]
        ],
      ),
    );
  }
}
