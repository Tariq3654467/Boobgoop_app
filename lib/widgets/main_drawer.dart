import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../screens/landing_screen.dart';
import '../screens/placeholder_screen.dart';
import '../theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../l10n/app_translations.dart';
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
    final appState = Provider.of<AppState>(context);
    return Consumer<AppLocalizations>(
      builder: (context, localizations, child) {
        final isSomali = localizations.isSomali;
        final appTranslations = localizations.translations;
        final role = appState.currentRole;
        final isLoggedIn = appState.isLoggedIn;
        final currentUser = appState.currentUser;

        final roleLabel = _roleLabel(role, appTranslations);
        final menuItems = _menuItemsForRole(role, context, appTranslations);

        return Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: AppColors.primaryBlue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo/logo.png', width: 200),
                      const SizedBox(height: 12),
                      if (isLoggedIn && currentUser != null) ...[
                        Text(
                          '${currentUser['first_name'] ?? ''} ${currentUser['last_name'] ?? ''}'.trim(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currentUser['email'] ?? '',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      Text(
                        roleLabel.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          fontSize: 12,
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
                const SizedBox(height: 20),
                _DrawerTile(
                  icon: Icons.swap_horiz,
                  title: appTranslations.switchRole,
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
                      color: AppColors.primaryBlue.withOpacity(0.3),
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
                        appTranslations.language,
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
                if (isLoggedIn)
                  _DrawerTile(
                    icon: Icons.logout,
                    title: appTranslations.logout,
                    onTap: () async {
                      await appState.logout();
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LandingScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  String _roleLabel(UserRole role, AppTranslations translations) {
    switch (role) {
      case UserRole.buyer:
        return translations.roleBuyer;
      case UserRole.seller:
        return translations.roleSeller;
      case UserRole.opsAgent:
        return translations.roleOps;
      case UserRole.driver:
        return translations.roleDriver;
      case UserRole.admin:
        return translations.roleAdmin;
      case UserRole.finance:
        return translations.roleFinance;
      case UserRole.hub:
        return translations.roleHub;
      case UserRole.partner:
        return translations.rolePartner;
      case UserRole.expert:
        return translations.roleExpert;
      case UserRole.unknown:
      default:
        return translations.roleChoose;
    }
  }

  List<_DrawerMenuItem> _menuItemsForRole(
    UserRole role,
    BuildContext context,
    AppTranslations translations,
  ) {
    final navigator = (String title) => () {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => StubScreen(title: title)));
    };

    switch (role) {
      case UserRole.buyer:
        return [
          _DrawerMenuItem(Icons.home, translations.home, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.show_chart,
            translations.marketPricesTitle,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.shopping_basket,
            translations.marketplace,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopProduceScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            translations.orders,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(Icons.cloud, translations.weatherTitle, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const WeatherScreen()));
          }),
          _DrawerMenuItem(Icons.forum, translations.communityTitle, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const CommunityScreen()));
          }),
          _DrawerMenuItem(
            Icons.support_agent,
            translations.support,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ContactScreen()));
            },
          ),
          _DrawerMenuItem(Icons.person, translations.profile, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.seller:
        return [
          _DrawerMenuItem(Icons.home, translations.home, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.add_box,
            translations.addProduce,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddProduceScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.list_alt,
            translations.myListings,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MyListingsScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            translations.orders,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            translations.marketPricesTitle,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(Icons.cloud, translations.weatherTitle, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const WeatherScreen()));
          }),
          _DrawerMenuItem(Icons.forum, translations.communityTitle, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const CommunityScreen()));
          }),
          _DrawerMenuItem(
            Icons.support_agent,
            translations.support,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ContactScreen()));
            },
          ),
          _DrawerMenuItem(Icons.person, translations.profile, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.opsAgent:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            translations.dashboard,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OpsDashboardScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            translations.orders,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.group,
            translations.farmers,
            navigator(translations.farmers),
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            translations.marketPricesTitle,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.local_shipping,
            translations.logistics,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LogisticsScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.report_problem,
            translations.issues,
            navigator(translations.issues),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            translations.reports,
            navigator(translations.reports),
          ),
        ];
      case UserRole.driver:
        return [
          _DrawerMenuItem(Icons.home, translations.home, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.map,
            translations.myTrips,
            navigator(translations.myTrips),
          ),
          _DrawerMenuItem(
            Icons.download,
            translations.pickups,
            navigator(translations.pickups),
          ),
          _DrawerMenuItem(
            Icons.delivery_dining,
            translations.deliveries,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DeliveriesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt,
            translations.pod,
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
            translations.earnings,
            navigator(translations.earnings),
          ),
          _DrawerMenuItem(
            Icons.support_agent,
            translations.support,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ContactScreen()));
            },
          ),
          _DrawerMenuItem(Icons.person, translations.profile, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.admin:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            translations.dashboard,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.admin_panel_settings,
            translations.usersRoles,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const UsersRolesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.shopping_basket,
            translations.marketplace,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopProduceScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            translations.marketPricesTitle,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.forum,
            translations.contentCommunity,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CommunityScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.receipt_long,
            translations.orders,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.local_shipping,
            translations.logistics,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LogisticsScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.payment,
            translations.payments,
            navigator(translations.payments),
          ),
          _DrawerMenuItem(
            Icons.report_problem,
            translations.disputes,
            () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const DisputesScreen()));
            },
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            translations.reports,
            navigator(translations.reports),
          ),
          _DrawerMenuItem(
            Icons.settings,
            translations.settings,
            navigator(translations.settings),
          ),
        ];
      case UserRole.finance:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            translations.dashboard,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FinanceDashboardScreen(),
                ),
              );
            },
          ),
          _DrawerMenuItem(Icons.receipt, translations.invoices, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const InvoicesScreen()));
          }),
          _DrawerMenuItem(
            Icons.account_balance,
            translations.buyerPayments,
            navigator(translations.buyerPayments),
          ),
          _DrawerMenuItem(
            Icons.account_balance_wallet,
            translations.sellerPayouts,
            navigator(translations.sellerPayouts),
          ),
          _DrawerMenuItem(
            Icons.monetization_on,
            translations.feesCommission,
            navigator(translations.feesCommission),
          ),
          _DrawerMenuItem(
            Icons.refresh,
            translations.refunds,
            navigator(translations.refunds),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            translations.reports,
            navigator(translations.reports),
          ),
        ];
      case UserRole.hub:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            translations.dashboard,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const HubDashboardScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.download,
            translations.incomingPickups,
            navigator(translations.incomingPickups),
          ),
          _DrawerMenuItem(
            Icons.inventory,
            translations.sortingPackaging,
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
            translations.stockLoads,
            navigator(translations.stockLoads),
          ),
          _DrawerMenuItem(Icons.send, translations.dispatch, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const DispatchScreen()));
          }),
          _DrawerMenuItem(
            Icons.report_problem,
            translations.issues,
            navigator(translations.issues),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            translations.reports,
            navigator(translations.reports),
          ),
        ];
      case UserRole.partner:
        return [
          _DrawerMenuItem(
            Icons.dashboard,
            translations.dashboard,
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
            translations.impact,
            navigator(translations.impact),
          ),
          _DrawerMenuItem(
            Icons.map,
            translations.regions,
            navigator(translations.regions),
          ),
          _DrawerMenuItem(
            Icons.group,
            translations.farmers,
            navigator(translations.farmers),
          ),
          _DrawerMenuItem(
            Icons.show_chart,
            translations.sales,
            navigator(translations.sales),
          ),
          _DrawerMenuItem(
            Icons.bar_chart,
            translations.reports,
            navigator(translations.reports),
          ),
          _DrawerMenuItem(
            Icons.download,
            translations.downloads,
            navigator(translations.downloads),
          ),
        ];
      case UserRole.expert:
        return [
          _DrawerMenuItem(Icons.home, translations.home, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LandingScreen()),
            );
          }),
          _DrawerMenuItem(
            Icons.question_answer,
            translations.questions,
            navigator(translations.questions),
          ),
          _DrawerMenuItem(
            Icons.post_add,
            translations.postAdvisory,
            navigator(translations.postAdvisory),
          ),
          _DrawerMenuItem(
            Icons.cloud,
            translations.weatherAlerts,
            navigator(translations.weatherAlerts),
          ),
          _DrawerMenuItem(
            Icons.menu_book,
            translations.resources,
            navigator(translations.resources),
          ),
          _DrawerMenuItem(
            Icons.message,
            translations.messages,
            navigator(translations.messages),
          ),
          _DrawerMenuItem(Icons.person, translations.profile, () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
        ];
      case UserRole.unknown:
      default:
        return [
          _DrawerMenuItem(Icons.home, translations.home, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const RoleSelectionScreen(),
              ),
            );
          }),
          _DrawerMenuItem(
            Icons.info,
            translations.aboutUs,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          _DrawerMenuItem(
            Icons.help_center,
            translations.howItWorks,
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
