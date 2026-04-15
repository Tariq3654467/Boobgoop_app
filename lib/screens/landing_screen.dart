import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/main_drawer.dart';
import 'role_selection_screen.dart';
import 'shop_produce_screen.dart';
import 'how_it_works_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % _featuredProducts.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  static const List<Map<String, dynamic>> _featuredProducts = [
    {
      'name': 'Organic Watermelon',
      'image_url': 'assets/images/watermelon.png',
      'price': '1.20',
      'unit': 'kg',
    },
    {
      'name': 'Grade A Bananas',
      'image_url': 'assets/images/Fresh_banana_gradeA.png',
      'price': '0.75',
      'unit': 'kg',
    },
    {
      'name': 'Iceberg Lettuce',
      'image_url': 'assets/images/lattuce_bagal.png',
      'price': '0.95',
      'unit': 'unit',
    },
    {
      'name': 'Sweet Mangoes',
      'image_url': 'assets/images/mangoes.png',
      'price': '1.70',
      'unit': 'kg',
    },
    {
      'name': 'Premium Tomatoes',
      'image_url': 'assets/images/tomatoes.png',
      'price': '1.05',
      'unit': 'kg',
    },
    {
      'name': 'Fresh Spinach',
      'image_url': 'assets/images/spinch.png',
      'price': '1.10',
      'unit': 'bunch',
    },
    {
      'name': 'Yellow Maize',
      'image_url': 'assets/images/yellow_maize.png',
      'price': '0.65',
      'unit': 'kg',
    },
    {
      'name': 'Premium Sesame Seeds',
      'image_url': 'assets/images/premium_sesum_seeds.png',
      'price': '3.20',
      'unit': 'kg',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isLoggedIn = appState.isLoggedIn;
    final appTranslations = AppLocalizations.of(context).translations;
    final appState = context.watch<AppState>();
    final isLoggedIn = appState.isLoggedIn;
    final appTranslations = AppLocalizations.of(context).translations;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo/logo.png', height: 40),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryBlue,
        elevation: 0,
        actions: [
          if (!isLoggedIn)
            TextButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
              icon: const Icon(Icons.login),
              label: Text(appTranslations.login),
            )
          else
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
              icon: const Icon(Icons.person_outline),
              tooltip: appTranslations.profile,
            ),
        ],
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
                    appTranslations.heroTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appTranslations.heroSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.textMedium),
                  ),
                  const SizedBox(height: 24),
                  // Featured Products Slider
                  SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            itemCount: _featuredProducts.length,
                            itemBuilder: (context, index) {
                              final product = _featuredProducts[index];
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    product['image_url'],
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    right: 20,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            product['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '\$${product['price']}/${product['unit']}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _featuredProducts.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index 
                                  ? AppColors.primaryBlue 
                                  : AppColors.primaryBlue.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShopProduceScreen(),
                              ),
                            ),
                            child: Text(appTranslations.viewAllProducts),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopProduceScreen())),
                          child: Text(appTranslations.startShopping),
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
                          child: Text(appTranslations.requestQuote),
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
                    appTranslations.trustHighlights,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(height: 16),
                  _buildTrustItem(Icons.verified_user, appTranslations.verifiedSellers),
                  _buildTrustItem(Icons.calendar_month, appTranslations.bulkOrdering),
                  _buildTrustItem(Icons.local_shipping, appTranslations.deliveryCoordination),
                  _buildTrustItem(Icons.notifications_active, appTranslations.orderUpdates),
                ],
              ),
            ),

            // --- IMPACT SECTION ---
            Container(
              padding: const EdgeInsets.all(40),
              color: AppColors.secondaryGreen,
              child: Column(
                children: [
                  Text(
                    appTranslations.ourImpact,
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appTranslations.impactDescription,
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
                    appTranslations.howItWorks,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(height: 20),
                  _buildStep(1, appTranslations.step1),
                  _buildStep(2, appTranslations.step2),
                  _buildStep(3, appTranslations.step3),
                  _buildStep(4, appTranslations.step4),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HowItWorksScreen())),
                    child: Text(appTranslations.viewDetailedGuide, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // --- CTA SECTION ---
            if (!isLoggedIn)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    Text(appTranslations.readyToJoin, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen())),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                      child: Text(appTranslations.getStarted),
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
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
