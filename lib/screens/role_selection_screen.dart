import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_state.dart';
import '../theme/app_colors.dart';
import 'registration_screen.dart';
import '../widgets/main_drawer.dart';
import 'how_it_works_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryBlue,
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: [
          // Background Branding
          Positioned(
            top: 60,
            left: 24,
            child: Image.asset(
              'assets/logo/logo.png',
              height: 60,
              alignment: Alignment.centerLeft,
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'Join the Marketplace',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 32,
                          color: AppColors.primaryBlue,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Connecting verified Somali female farmers directly to bulk buyers.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 40),
                  
                  // Seller Card
                  _RoleCard(
                    title: 'Sellers',
                    subtitle: 'Get consistent buyers and faster sales.',
                    cta: 'Become a Seller',
                    imagePath: 'assets/images/farmer-portrait-1.jpg',
                    onTap: () {
                      context.read<AppState>().setRole(UserRole.seller);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen(role: 'Seller')));
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Buyer Card
                  _RoleCard(
                    title: 'Buyers',
                    subtitle: 'Order smarter, reduce shortages.',
                    cta: 'Register as a Buyer',
                    imagePath: 'assets/images/farmer-portrait-2.jpg',
                    onTap: () {
                      context.read<AppState>().setRole(UserRole.buyer);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen(role: 'Buyer')));
                    },
                  ),
                  const SizedBox(height: 20),
                  // Driver / Transporter Card
                  _RoleCard(
                    title: 'Transporters',
                    subtitle: 'Receive delivery assignments and earn per trip.',
                    cta: 'Register as Driver',
                    imagePath: 'assets/images/farmer-portrait-1.jpg',
                    onTap: () {
                      context.read<AppState>().setRole(UserRole.driver);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen(role: 'Driver')));
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HowItWorksScreen()));
                    },
                    child: Text(
                      'How it works? Read our Guide',
                      style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cta;
  final String imagePath;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.cta,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accentOrange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  cta,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
