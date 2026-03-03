import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/main_drawer.dart';
import 'role_selection_screen.dart';
import 'shop_produce_screen.dart';
import 'how_it_works_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo/logo.png', height: 40),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HERO SECTION ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Buy fresh produce in bulk — delivered with confidence.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Verified sellers, clear order confirmation, and reliable delivery coordination by the BaadiGoob AgroLink team.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.textMedium),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopProduceScreen())),
                          child: const Text('Start Shopping'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.accentOrange,
                            foregroundColor: Colors.white,
                            side: BorderSide.none,
                          ),
                          child: const Text('Request Quote'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- TRUST HIGHLIGHTS ---
            Container(
              padding: const EdgeInsets.all(24),
              color: AppColors.offWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trust Highlights',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(height: 16),
                  _buildTrustItem(Icons.verified_user, 'Verified sellers and basic quality checks'),
                  _buildTrustItem(Icons.calendar_month, 'Bulk ordering + repeat schedules (daily/weekly)'),
                  _buildTrustItem(Icons.local_shipping, 'Aggregation and delivery coordination'),
                  _buildTrustItem(Icons.notifications_active, 'Order status updates (In-app + WhatsApp)'),
                ],
              ),
            ),

            // --- IMPACT SECTION ---
            Container(
              padding: const EdgeInsets.all(40),
              color: AppColors.secondaryGreen,
              child: Column(
                children: [
                  const Text(
                    'Our Impact',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'BaadiGoob AgroLink increases income for women farmers, improves fair pricing, and reduces post-harvest losses through coordinated delivery routines.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),

            // --- HOW IT WORKS (Quick View) ---
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'How It Works',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(height: 20),
                  _buildStep(1, 'Browse & choose products'),
                  _buildStep(2, 'Place an order or Request Quote'),
                  _buildStep(3, 'We confirm & coordinate supply'),
                  _buildStep(4, 'Delivery arranged with updates'),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HowItWorksScreen())),
                    child: const Text('View Detailed Guide', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // --- CTA SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const Text('Ready to join?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen())),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      backgroundColor: AppColors.primaryBlue,
                    ),
                    child: const Text('Get Started / Register'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondaryGreen, size: 24),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.accentOrange,
            child: Text(number.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
