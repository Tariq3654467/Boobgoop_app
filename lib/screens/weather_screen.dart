import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../l10n/app_translations.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class SomaliCity {
  final String name;
  final double lat;
  final double lng;

  const SomaliCity(this.name, this.lat, this.lng);
}

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
  SomaliCity? _selectedCity;

  final List<SomaliCity> _somaliCities = const [
    SomaliCity('Mogadishu', 2.0469, 45.3182),
    SomaliCity('Hargeisa', 9.5624, 44.0770),
    SomaliCity('Kismayo', -0.3582, 42.5454),
    SomaliCity('Baidoa', 3.1138, 43.6498),
    SomaliCity('Jowhar', 2.7787, 45.5005),
    SomaliCity('Bosaso', 11.2842, 49.1816),
    SomaliCity('Galkayo', 6.7697, 47.4308),
    SomaliCity('Garowe', 8.4021, 48.4828),
    SomaliCity('Berbera', 10.4396, 45.0143),
    SomaliCity('Merca', 1.7032, 44.7717),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCity = _somaliCities[0]; // Default to Mogadishu
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    if (_selectedCity == null) return;

    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      final weather = await _apiService.getWeather(_selectedCity!.lat, _selectedCity!.lng);
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
        actions: [
          PopupMenuButton<SomaliCity>(
            onSelected: (city) {
              setState(() {
                _selectedCity = city;
              });
              _fetchWeather();
            },
            itemBuilder: (context) => _somaliCities.map((city) => PopupMenuItem(
              value: city,
              child: Text(city.name),
            )).toList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(_selectedCity?.name ?? 'Select City'),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(translations),
    );
  }

  Widget _buildBody(AppTranslations translations) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
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
    final humidity = current['humidity'] ?? '--';
    final wind = current['wind_speed'] ?? '--';
    final desc = current['condition'] ?? translations.unknownWeather;
    final forecast = _weather?['forecast'] as List<dynamic>? ?? [];

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_selectedCity?.name ?? 'Unknown City', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.wb_sunny, size: 72, color: AppColors.accentOrange),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$temp°C', style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(desc.toString().toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _weatherMetric(Icons.opacity, 'Humidity', '$humidity%'),
                    _weatherMetric(Icons.air, 'Wind', '$wind km/h'),
                    _weatherMetric(Icons.thermostat, 'Feels Like', '$temp°C'),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: AppColors.primaryBlue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Weather alert: Check harvest and transport plans before travel. Heavy rain or wind may affect deliveries.',
                          style: TextStyle(color: AppColors.primaryBlue.withOpacity(0.95)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(translations.upcomingForecast, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: forecast.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: forecast.length,
                  itemBuilder: (context, index) {
                    final day = forecast[index] as Map<String, dynamic>;
                    final dayLabel = day['day'] ?? 'Day ${index + 1}';
                    final high = day['high'] ?? '--';
                    final low = day['low'] ?? '--';
                    final icon = day['icon'] ?? Icons.cloud;
                    return Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.lightGray),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(dayLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Icon(icon is IconData ? icon : Icons.cloud, size: 36, color: AppColors.primaryBlue),
                          const SizedBox(height: 12),
                          Text('High: $high°C'),
                          Text('Low: $low°C'),
                        ],
                      ),
                    );
                  },
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    3,
                    (index) => Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.lightGray),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(translations.tomorrow),
                          const SizedBox(height: 12),
                          const Icon(Icons.cloud, size: 32, color: Colors.blueGrey),
                          const SizedBox(height: 12),
                          const Text('30°C'),
                          const Text('22°C'),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: _fetchWeather,
        ),
      ],
    );
  }

  Widget _weatherMetric(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 24),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: AppColors.textMedium)),
        ],
      ),
    );
  }
}
