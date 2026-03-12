import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../screens/landing_screen.dart';
import '../screens/placeholder_screen.dart';
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
import '../screens/add_produce_screen.dart';
import '../screens/logistics_screen.dart';
import '../screens/quality_screen.dart';

import '../screens/market_prices_screen.dart';
import '../screens/community_screen.dart';
import '../screens/partner_dashboard_screen.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/hub_dashboard_screen.dart';
import '../screens/ops_dashboard_screen.dart';
import '../screens/finance_dashboard_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/weather_screen.dart';
import '../screens/deliveries_screen.dart';
import '../screens/my_listings_screen.dart';
import '../screens/proof_of_delivery_screen.dart';
import '../screens/sorting_packaging_screen.dart';
import '../screens/dispatch_screen.dart';
import '../screens/users_roles_screen.dart';
import '../screens/disputes_screen.dart';
import '../screens/invoices_screen.dart';
import '../screens/stub_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLocalizations>(
      builder: (context, localizations, child) {
        final isSomali = localizations.isSomali;
        final role = context.watch<AppState>().currentRole;

        final roleLabel = _roleLabel(role, isSomali);
        final menuItems = _menuItemsForRole(role, context, isSomali);

        return Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: AppColors.primaryBlue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo/logo.png', width: 200),
                    const SizedBox(height: 12),
                    Text(
                      roleLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ...menuItems.map(
                (item) => _DrawerTile(
                  icon: item.icon,
                  title: item.title,
                  onTap: item.onTap,
                ),
              ),
              const Spacer(),
              _DrawerTile(
                icon: Icons.swap_horiz,
                title: isSomali ? 'Dooro Doorka' : 'Switch Role',
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const RoleSelectionScreen(),
                    ),
                  );
                },
              ),
              // Language Toggle
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.language,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isSomali ? 'Afka' : 'Language',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => localizations.toggleLanguage(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                      ),
                      child: Text(
                        localizations.isEnglish ? 'SO' : 'EN',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
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
      },
    );
  }

  String _roleLabel(UserRole role, bool isSomali) {
    switch (role) {
      case UserRole.buyer:
        return isSomali ? 'Iibiyaha' : 'Buyer';
      case UserRole.seller:
        return isSomali ? 'Iibiyaha' : 'Seller';
      case UserRole.opsAgent:
        return isSomali ? 'Wakiilka' : 'Ops / Agent';
      case UserRole.driver:
        return isSomali ? 'Darawal' : 'Driver';
      case UserRole.admin:
        return isSomali ? 'Maamulaha' : 'Admin';
      case UserRole.finance:
        return isSomali ? 'Maaliyadda' : 'Finance';
      case UserRole.hub:
        return isSomali ? 'Xarunta' : 'Hub Staff';
      case UserRole.partner:
        return isSomali ? 'Shuraakada' : 'Partner';
      case UserRole.expert:
        return isSomali ? 'Khabiir' : 'Expert';
      case UserRole.unknown:
      default:
        return isSomali ? 'Dooro Doorka' : 'Choose a Role';
    }
  }

  List<_DrawerMenuItem> _menuItemsForRole(
    UserRole role,
    BuildContext context,
    bool isSomali,
  ) {
    final navigator = (String title) => () {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => StubScreen(title: title)));
    };

    switch (role) {
      case UserRole.buyer:
        return [
          _DrawerMenuItem(Icons.home, isSomali ? 'Guriga' : 'Home', () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.show_chart,
            isSomali ? 'Qiimayaasha Suuqa' : 'Market Prices',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.shopping_basket,
            isSomali ? 'Suuqa' : 'Marketplace',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopProduceScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            isSomali ? 'Amarada' : 'Orders',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(Icons.cloud, isSomali ? 'Cimilada' : 'Weather', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const WeatherScreen()));
          }),
          _DrawerMenuItem(Icons.forum, isSomali ? 'Bulshada' : 'Community', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const CommunityScreen()));
          }),
          _DrawerMenuItem(
            Icons.support_agent,
            isSomali ? 'Taageero' : 'Support',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ContactScreen()));
            },
          ),
          _DrawerMenuItem(Icons.person, isSomali ? 'Profile' : 'Profile', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.seller:
        return [
          _DrawerMenuItem(Icons.home, isSomali ? 'Guriga' : 'Home', () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.add_box,
            isSomali ? 'Ku dar Wax-soo-saarka' : 'Add Produce',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddProduceScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.list_alt,
            isSomali ? 'Liiska Iibka' : 'My Listings',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MyListingsScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            isSomali ? 'Amarada' : 'Orders',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            isSomali ? 'Qiimayaasha Suuqa' : 'Market Prices',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(Icons.cloud, isSomali ? 'Cimilada' : 'Weather', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const WeatherScreen()));
          }),
          _DrawerMenuItem(Icons.forum, isSomali ? 'Bulshada' : 'Community', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const CommunityScreen()));
          }),
          _DrawerMenuItem(
            Icons.support_agent,
            isSomali ? 'Taageero' : 'Support',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ContactScreen()));
            },
          ),
          _DrawerMenuItem(Icons.person, isSomali ? 'Profile' : 'Profile', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.opsAgent:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            isSomali ? 'Dashboard' : 'Dashboard',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OpsDashboardScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            isSomali ? 'Amarada' : 'Orders',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.group,
            isSomali ? 'Beeralayda' : 'Farmers',
            navigator(isSomali ? 'Beeralayda' : 'Farmers'),
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            isSomali ? 'Qiimayaasha' : 'Prices',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.local_shipping,
            isSomali ? 'Saadka' : 'Logistics',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LogisticsScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.report_problem,
            isSomali ? 'Arrimaha' : 'Issues',
            navigator(isSomali ? 'Arrimaha' : 'Issues'),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            isSomali ? 'Warbixinno' : 'Reports',
            navigator(isSomali ? 'Warbixinno' : 'Reports'),
          ),
        ];
      case UserRole.driver:
        return [
          _DrawerMenuItem(Icons.home, isSomali ? 'Guriga' : 'Home', () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.map,
            isSomali ? 'Safarrada' : 'My Trips',
            navigator(isSomali ? 'Safarrada' : 'My Trips'),
          ),
          _DrawerMenuItem(
            Icons.download,
            isSomali ? 'Qaado' : 'Pickups',
            navigator(isSomali ? 'Qaado' : 'Pickups'),
          ),
          _DrawerMenuItem(
            Icons.delivery_dining,
            isSomali ? 'Gawaarida' : 'Deliveries',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DeliveriesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt,
            isSomali ? 'Caddaynta Gaarsiinta' : 'Proof of Delivery',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProofOfDeliveryScreen(),
                ),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.account_balance_wallet,
            isSomali ? 'Dakhliga' : 'Earnings',
            navigator(isSomali ? 'Dakhliga' : 'Earnings'),
          ),
          _DrawerMenuItem(
            Icons.support_agent,
            isSomali ? 'Taageero' : 'Support',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ContactScreen()));
            },
          ),
          _DrawerMenuItem(Icons.person, isSomali ? 'Profile' : 'Profile', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.admin:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            isSomali ? 'Dashboard' : 'Dashboard',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.admin_panel_settings,
            isSomali ? 'Isticmaalayaasha & Doorka' : 'Users & Roles',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const UsersRolesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.shopping_basket,
            isSomali ? 'Suuqa' : 'Marketplace',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopProduceScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            isSomali ? 'Qiimayaasha' : 'Prices',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.forum,
            isSomali ? 'Mawduuca/Bulshada' : 'Content/Community',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CommunityScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            isSomali ? 'Amarada' : 'Orders',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.local_shipping,
            isSomali ? 'Saadka' : 'Logistics',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LogisticsScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.payment,
            isSomali ? 'Lacag-bixinta' : 'Payments',
            navigator(isSomali ? 'Lacag-bixinta' : 'Payments'),
          ),
          _DrawerMenuItem(
            Icons.report_problem,
            isSomali ? 'Khilaafaadka' : 'Disputes',
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const DisputesScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            isSomali ? 'Warbixinno' : 'Reports',
            navigator(isSomali ? 'Warbixinno' : 'Reports'),
          ),
          _DrawerMenuItem(
            Icons.settings,
            isSomali ? 'Dejinta' : 'Settings',
            navigator(isSomali ? 'Dejinta' : 'Settings'),
          ),
        ];
      case UserRole.finance:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            isSomali ? 'Dashboard' : 'Dashboard',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FinanceDashboardScreen(),
                ),
              );
            },
          ),
          _DrawerMenuItem(Icons.receipt, isSomali ? 'Bixinta' : 'Invoices', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const InvoicesScreen()));
          }),
          _DrawerMenuItem(
            Icons.account_balance,
            isSomali ? 'Bixinta Iibsadaha' : 'Buyer Payments',
            navigator(isSomali ? 'Bixinta Iibsadaha' : 'Buyer Payments'),
          ),
          _DrawerMenuItem(
            Icons.account_balance_wallet,
            isSomali ? 'Lacag Bixinta Iibiyaha' : 'Seller Payouts',
            navigator(isSomali ? 'Lacag Bixinta Iibiyaha' : 'Seller Payouts'),
          ),
          _DrawerMenuItem(
            Icons.monetization_on,
            isSomali ? 'Kharashka/Ganacsiga' : 'Fees/Commission',
            navigator(isSomali ? 'Kharashka/Ganacsiga' : 'Fees/Commission'),
          ),
          _DrawerMenuItem(
            Icons.refresh,
            isSomali ? 'Lacag Celin' : 'Refunds',
            navigator(isSomali ? 'Lacag Celin' : 'Refunds'),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            isSomali ? 'Warbixinno' : 'Reports',
            navigator(isSomali ? 'Warbixinno' : 'Reports'),
          ),
        ];
      case UserRole.hub:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            isSomali ? 'Dashboard' : 'Dashboard',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const HubDashboardScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.download,
            isSomali ? 'Qaado' : 'Incoming Pickups',
            navigator(isSomali ? 'Qaado' : 'Incoming Pickups'),
          ),
          _DrawerMenuItem(
            Icons.inventory,
            isSomali ? 'Kala-Saarista/Qaadista' : 'Sorting/Packaging',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SortingPackagingScreen(),
                ),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.storage,
            isSomali ? 'Kaydka/Boostada' : 'Stock/Loads',
            navigator(isSomali ? 'Kaydka/Boostada' : 'Stock/Loads'),
          ),
          _DrawerMenuItem(Icons.send, isSomali ? 'Dirida' : 'Dispatch', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const DispatchScreen()));
          }),
          _DrawerMenuItem(
            Icons.report_problem,
            isSomali ? 'Arrimaha' : 'Issues',
            navigator(isSomali ? 'Arrimaha' : 'Issues'),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            isSomali ? 'Warbixinno' : 'Reports',
            navigator(isSomali ? 'Warbixinno' : 'Reports'),
          ),
        ];
      case UserRole.partner:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            isSomali ? 'Dashboard' : 'Dashboard',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PartnerDashboardScreen(),
                ),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.emoji_events,
            isSomali ? 'Saameynta' : 'Impact',
            navigator(isSomali ? 'Saameynta' : 'Impact'),
          ),
          _DrawerMenuItem(
            Icons.map,
            isSomali ? 'Gobollada' : 'Regions',
            navigator(isSomali ? 'Gobollada' : 'Regions'),
          ),
          _DrawerMenuItem(
            Icons.group,
            isSomali ? 'Beeralayda' : 'Farmers',
            navigator(isSomali ? 'Beeralayda' : 'Farmers'),
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            isSomali ? 'Iibka' : 'Sales',
            navigator(isSomali ? 'Iibka' : 'Sales'),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            isSomali ? 'Warbixinno' : 'Reports',
            navigator(isSomali ? 'Warbixinno' : 'Reports'),
          ),
          _DrawerMenuItem(
            Icons.download,
            isSomali ? 'Soo-dejinta' : 'Downloads',
            navigator(isSomali ? 'Soo-dejinta' : 'Downloads'),
          ),
        ];
      case UserRole.expert:
        return [
          _DrawerMenuItem(Icons.home, isSomali ? 'Guriga' : 'Home', () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.question_answer,
            isSomali ? 'Su\'aalaha' : 'Questions',
            navigator(isSomali ? 'Su\'aalaha' : 'Questions'),
          ),
          _DrawerMenuItem(
            Icons.post_add,
            isSomali ? 'La-talin Ku qaado' : 'Post Advisory',
            navigator(isSomali ? 'La-talin Ku qaado' : 'Post Advisory'),
          ),
          _DrawerMenuItem(
            Icons.cloud,
            isSomali ? 'Digniino Cimilada' : 'Weather Alerts',
            navigator(isSomali ? 'Digniino Cimilada' : 'Weather Alerts'),
          ),
          _DrawerMenuItem(
            Icons.menu_book,
            isSomali ? 'Khayraadka' : 'Resources',
            navigator(isSomali ? 'Khayraadka' : 'Resources'),
          ),
          _DrawerMenuItem(
            Icons.message,
            isSomali ? 'Farriimaha' : 'Messages',
            navigator(isSomali ? 'Farriimaha' : 'Messages'),
          ),
          _DrawerMenuItem(Icons.person, isSomali ? 'Profile' : 'Profile', () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.unknown:
      default:
        return [
          _DrawerMenuItem(Icons.home, isSomali ? 'Guriga' : 'Home', () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const RoleSelectionScreen(),
              ),
            );
          }),
          _DrawerMenuItem(
            Icons.info,
            isSomali ? 'Nagu Saabsan' : 'About Us',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.help_center,
            isSomali ? 'Sidee Ayuu U Shaqeyaa' : 'How It Works',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HowItWorksScreen(),
                ),
              );
            },
          ),
        ];
    }
  }
}

class _DrawerMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _DrawerMenuItem(this.icon, this.title, this.onTap);
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
