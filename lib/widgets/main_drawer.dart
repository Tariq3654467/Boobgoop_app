import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../screens/about_screen.dart';
import '../screens/faq_screen.dart';
import '../screens/how_it_works_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/role_selection_screen.dart';
import '../screens/shop_produce_screen.dart';
import '../screens/buyers_info_screen.dart';
import '../screens/sellers_info_screen.dart';
import '../screens/logistics_screen.dart';
import '../screens/quality_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isSomali = localizations.isSomali;
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryBlue),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset('assets/logo/logo.png', width: 200),
              ),
            ),
          ),
          _DrawerTile(
            icon: Icons.home,
            title: isSomali ? 'Guriga' : 'Home',
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.shopping_basket,
            title: isSomali ? 'Alaabta' : 'Shop Produce',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ShopProduceScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.info,
            title: isSomali ? 'Nagu Saabsan' : 'About Us',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.help_center,
            title: isSomali ? 'Sidee Ayuu U Shaqeyaa' : 'How It Works',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HowItWorksScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.person_search,
            title: isSomali ? 'Iibsadayaasha' : 'For Buyers',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BuyersInfoScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.agriculture,
            title: isSomali ? 'Iibiyayaasha' : 'For Sellers',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SellersInfoScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.local_shipping,
            title: isSomali ? 'Gaadiidka' : 'Logistics',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LogisticsScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.verified_user,
            title: isSomali ? 'Quality & Ammaan' : 'Quality & Trust',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const QualityScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.question_answer,
            title: 'FAQ',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const FAQScreen()),
            ),
          ),
          _DrawerTile(
            icon: Icons.contact_phone,
            title: isSomali ? 'Nagnu Xiriir' : 'Contact Us',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ContactScreen()),
            ),
          ),
          const Spacer(),
          // Language Toggle
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.language, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 8),
                Text(
                  isSomali ? 'Afka' : 'Language',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryBlue),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => localizations.toggleLanguage(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    localizations.isEnglish ? 'SO' : 'EN',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'v1.0.0 - BaadiGoob AgroLink',
              style: TextStyle(color: AppColors.textLight, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBlue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
