import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';
import '../widgets/main_drawer.dart';
import '../l10n/app_localizations.dart';
import '../l10n/app_translations.dart';
import '../services/api_service.dart';
import 'product_detail_screen.dart';

class ShopProduceScreen extends StatefulWidget {
  const ShopProduceScreen({super.key});

  @override
  State<ShopProduceScreen> createState() => _ShopProduceScreenState();
}

class _ShopProduceScreenState extends State<ShopProduceScreen> {
  final _searchController = TextEditingController();
  final List<String> _categories = [
    'All', 
    'Fresh Produce', 
    'Grains & Legumes', 
    'Livestock & Dairy', 
    'Farming Tools', 
    'Agri-Consulting', 
    'Logistics'
  ];
  final List<Map<String, dynamic>> _defaultProducts = [
    {
      'name': 'Organic Watermelon',
      'category': 'Fresh Produce',
      'grade': 'Premium',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '1.20',
      'unit': 'kg',
      'image_url': 'assets/images/watermelon.png',
      'description': 'Sweet and juicy watermelon from certified local farms.',
      'seller_name': 'Amina Hassan',
      'location': 'Hargeisa',
      'rating': 4.9,
      'reviews': 85,
      'delivery_options': 'Pickup, delivery',
    },
    {
      'name': 'Grade A Bananas',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '20kg',
      'status': 'In Stock',
      'price': '0.75',
      'unit': 'kg',
      'image_url': 'assets/images/Fresh_banana_gradeA.png',
      'description': 'Large farm bananas ready for wholesale distribution.',
      'seller_name': 'Dahabo Omar',
      'location': 'Mogadishu',
      'rating': 4.7,
      'reviews': 64,
      'delivery_options': 'Local delivery',
    },
    {
      'name': 'Fresh Beetroot',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '1.10',
      'unit': 'kg',
      'image_url': 'assets/images/betroot.png',
      'description': 'Deep red, earthy beetroots perfect for salads and juice.',
      'seller_name': 'Fatumo Ali',
      'location': 'Berbera',
      'rating': 4.8,
      'reviews': 32,
      'delivery_options': 'Pickup',
    },
    {
      'name': 'Green Cabbage',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '0.60',
      'unit': 'kg',
      'image_url': 'assets/images/cabbage.png',
      'description': 'Crisp and fresh green cabbage harvested weekly.',
      'seller_name': 'Halimo Abdi',
      'location': 'Galkayo',
      'rating': 4.6,
      'reviews': 58,
      'delivery_options': 'Local delivery',
    },
    {
      'name': 'Sweet Cantaloupe',
      'category': 'Fresh Produce',
      'grade': 'Premium',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '1.40',
      'unit': 'kg',
      'image_url': 'assets/images/cantloupe.png',
      'description': 'Fragrant and sweet cantaloupe melons.',
      'seller_name': 'Khadra Jama',
      'location': 'Baydhabo',
      'rating': 4.5,
      'reviews': 41,
      'delivery_options': 'Pickup',
    },
    {
      'name': 'Crispy Carrots',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '0.85',
      'unit': 'kg',
      'image_url': 'assets/images/carrot.png',
      'description': 'Long, sweet carrots grown in sandy soil.',
      'seller_name': 'Layla Nur',
      'location': 'Bosaso',
      'rating': 4.4,
      'reviews': 28,
      'delivery_options': 'Local delivery',
    },
    {
      'name': 'Fresh Coconuts',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '10 units',
      'status': 'In Stock',
      'price': '1.50',
      'unit': 'unit',
      'image_url': 'assets/images/cocunut.png',
      'description': 'Fresh coastal coconuts with plenty of water.',
      'seller_name': 'Mariam Warsame',
      'location': 'Kismayo',
      'rating': 4.7,
      'reviews': 52,
      'delivery_options': 'Coastal logistics',
    },
    {
      'name': 'High-Protein Cowpeas',
      'category': 'Grains & Legumes',
      'grade': 'Standard',
      'min_order': '50kg',
      'status': 'In Stock',
      'price': '2.50',
      'unit': 'kg',
      'image_url': 'assets/images/cowpeas.png',
      'description': 'Nutritious dried cowpeas for local markets.',
      'seller_name': 'Nasra Geedi',
      'location': 'Jowhar',
      'rating': 4.3,
      'reviews': 19,
      'delivery_options': 'Bulk shipping',
    },
    {
      'name': 'Organic Cucumbers',
      'category': 'Fresh Produce',
      'grade': 'Premium',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '0.90',
      'unit': 'kg',
      'image_url': 'assets/images/cucumber.png',
      'description': 'Hydrating and fresh cucumbers from greenhouse farms.',
      'seller_name': 'Sahra Farah',
      'location': 'Afgooye',
      'rating': 4.6,
      'reviews': 37,
      'delivery_options': 'Local delivery',
    },
    {
      'name': 'Fresh Coriander',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '20 bunches',
      'status': 'In Stock',
      'price': '0.40',
      'unit': 'bunch',
      'image_url': 'assets/images/fresh_corender.png',
      'description': 'Aromatic coriander leaves for traditional Somali dishes.',
      'seller_name': 'Zamzam Aden',
      'location': 'Mogadishu',
      'rating': 4.8,
      'reviews': 74,
      'delivery_options': 'Quick dispatch',
    },
    {
      'name': 'Organic Sorghum',
      'category': 'Grains & Legumes',
      'grade': 'High',
      'min_order': '100kg',
      'status': 'In Stock',
      'price': '1.80',
      'unit': 'kg',
      'image_url': 'assets/images/fresh_organic_sorghum.png',
      'description': 'Traditional sorghum grains, naturally grown.',
      'seller_name': 'Asha Mohamud',
      'location': 'Baidoa',
      'rating': 4.5,
      'reviews': 45,
      'delivery_options': 'Regional logistics',
    },
    {
      'name': 'Grapefruit',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '1.30',
      'unit': 'kg',
      'image_url': 'assets/images/grape_fruit.png',
      'description': 'Tangy and refreshing grapefruits from the Shabelle valley.',
      'seller_name': 'Faduma Ismail',
      'location': 'Janale',
      'rating': 4.4,
      'reviews': 21,
      'delivery_options': 'Riverine transport',
    },
    {
      'name': 'Green Bell Peppers',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '1.20',
      'unit': 'kg',
      'image_url': 'assets/images/green_pepper.png',
      'description': 'Thick-walled green peppers, perfect for cooking.',
      'seller_name': 'Hibaq Dualeh',
      'location': 'Hargeisa',
      'rating': 4.7,
      'reviews': 33,
      'delivery_options': 'Market delivery',
    },
    {
      'name': 'Iceberg Lettuce',
      'category': 'Fresh Produce',
      'grade': 'Premium',
      'min_order': '12 units',
      'status': 'In Stock',
      'price': '0.95',
      'unit': 'unit',
      'image_url': 'assets/images/lattuce_bagal.png',
      'description': 'Fresh and crisp lettuce for luxury markets.',
      'seller_name': 'Ifrah Ahmed',
      'location': 'Eyl',
      'rating': 4.9,
      'reviews': 12,
      'delivery_options': 'Cold chain delivery',
    },
    {
      'name': 'Somali Lemons',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '0.50',
      'unit': 'kg',
      'image_url': 'assets/images/lemon.png',
      'description': 'Small but juice-rich lemons typical of the region.',
      'seller_name': 'Jawahir Qasim',
      'location': 'Beletweyne',
      'rating': 4.6,
      'reviews': 56,
      'delivery_options': 'Daily dispatch',
    },
    {
      'name': 'Sweet Mangoes',
      'category': 'Fresh Produce',
      'grade': 'Export',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '1.70',
      'unit': 'kg',
      'image_url': 'assets/images/mangoes.png',
      'description': 'Flesh Mangos with high sugar content and rich aroma.',
      'seller_name': 'Maryan Yusuf',
      'location': 'Afgooye',
      'rating': 4.8,
      'reviews': 89,
      'delivery_options': 'Inter-city shipping',
    },
    {
      'name': 'Fresh Okra',
      'category': 'Fresh Produce',
      'grade': 'Tender',
      'min_order': '2kg',
      'status': 'In Stock',
      'price': '1.05',
      'unit': 'kg',
      'image_url': 'assets/images/okra.png',
      'description': 'Tender green okra pods, harvested daily.',
      'seller_name': 'Qaali Said',
      'location': 'Marka',
      'rating': 4.5,
      'reviews': 24,
      'delivery_options': 'Local pickup',
    },
    {
      'name': 'Ripe Papaya',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '1.25',
      'unit': 'kg',
      'image_url': 'assets/images/papaya.png',
      'description': 'Sweet and soft papayas from riverine farms.',
      'seller_name': 'Raaho Abshir',
      'location': 'Kismayo',
      'rating': 4.3,
      'reviews': 31,
      'delivery_options': 'River logistics',
    },
    {
      'name': 'Red Chilli Peppers',
      'category': 'Fresh Produce',
      'grade': 'Spicy',
      'min_order': '1kg',
      'status': 'In Stock',
      'price': '0.70',
      'unit': 'kg',
      'image_url': 'assets/images/pepper.png',
      'description': 'Hot red peppers for spice blends and sauces.',
      'seller_name': 'Safia Kahin',
      'location': 'Burao',
      'rating': 4.7,
      'reviews': 45,
      'delivery_options': 'Speedy courier',
    },
    {
      'name': 'Plum Tomatoes',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '0.90',
      'unit': 'kg',
      'image_url': 'assets/images/plum_tomato.png',
      'description': 'Oval-shaped tomatoes best for canning and cooking.',
      'seller_name': 'Ubah Guled',
      'location': 'Las Anod',
      'rating': 4.4,
      'reviews': 18,
      'delivery_options': 'Hub delivery',
    },
    {
      'name': 'Premium Sesame Seeds',
      'category': 'Grains & Legumes',
      'grade': 'Export',
      'min_order': '25kg',
      'status': 'In Stock',
      'price': '3.20',
      'unit': 'kg',
      'image_url': 'assets/images/premium_sesum_seeds.png',
      'description': 'Cleaned and sorted sesame seeds for export.',
      'seller_name': 'Waris Dirie',
      'location': 'Garbahaarey',
      'rating': 4.9,
      'reviews': 67,
      'delivery_options': 'Global shipping-ready',
    },
    {
      'name': 'Garden Salad Mix',
      'category': 'Fresh Produce',
      'grade': 'Fresh',
      'min_order': '5 packs',
      'status': 'In Stock',
      'price': '2.00',
      'unit': 'pack',
      'image_url': 'assets/images/salad.png',
      'description': 'Varied mix of fresh leafy greens.',
      'seller_name': 'Xaliimo Xasan',
      'location': 'Mogadishu',
      'rating': 4.6,
      'reviews': 29,
      'delivery_options': 'Express delivery',
    },
    {
      'name': 'Fresh Spinach',
      'category': 'Fresh Produce',
      'grade': 'Organic',
      'min_order': '10 bunches',
      'status': 'In Stock',
      'price': '1.10',
      'unit': 'bunch',
      'image_url': 'assets/images/spinch.png',
      'description': 'Vibrant green spinach leaves, iron-rich.',
      'seller_name': 'Yasmin Beileh',
      'location': 'Borama',
      'rating': 4.8,
      'reviews': 41,
      'delivery_options': 'Mountain eco-logistics',
    },
    {
      'name': 'Sweet Potatoes',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '20kg',
      'status': 'In Stock',
      'price': '0.80',
      'unit': 'kg',
      'image_url': 'assets/images/sweet_potatoes.png',
      'description': 'Fiber-rich sweet potatoes from smallholder farms.',
      'seller_name': 'Zeynab Qalib',
      'location': 'Adado',
      'rating': 4.4,
      'reviews': 25,
      'delivery_options': 'Regional transport',
    },
    {
      'name': 'Beefsteak Tomatoes',
      'category': 'Fresh Produce',
      'grade': 'Large',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '1.15',
      'unit': 'kg',
      'image_url': 'assets/images/tomato.png',
      'description': 'Large, meaty tomatoes for professional use.',
      'seller_name': 'Shukri Ali',
      'location': 'Galkayo',
      'rating': 4.7,
      'reviews': 58,
      'delivery_options': 'Inter-regional logistics',
    },
    {
      'name': 'White Pumpkin',
      'category': 'Fresh Produce',
      'grade': 'Mature',
      'min_order': '1 unit',
      'status': 'In Stock',
      'price': '1.60',
      'unit': 'kg',
      'image_url': 'assets/images/white_pumpkin.png',
      'description': 'Large white pumpkins for traditional stews.',
      'seller_name': 'Hani Nur',
      'location': 'Hobyo',
      'rating': 4.5,
      'reviews': 16,
      'delivery_options': 'Port-to-city transport',
    },
    {
      'name': 'Yellow Maize',
      'category': 'Grains & Legumes',
      'grade': 'Standard',
      'min_order': '100kg',
      'status': 'In Stock',
      'price': '0.65',
      'unit': 'kg',
      'image_url': 'assets/images/yellow_maize.png',
      'description': 'Essential staple yellow maize for milling.',
      'seller_name': 'Nimco Deeq',
      'location': 'Balad',
      'rating': 4.3,
      'reviews': 104,
      'delivery_options': 'Grain-hub shipping',
    },
    {
      'name': 'Yellow Pumpkin',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '1 unit',
      'status': 'In Stock',
      'price': '1.55',
      'unit': 'kg',
      'image_url': 'assets/images/yellow_pumpkin.png',
      'description': 'Nutritious orange-fleshed pumpkins.',
      'seller_name': 'Saado Ali',
      'location': 'Xuddur',
      'rating': 4.6,
      'reviews': 21,
      'delivery_options': 'Local hub delivery',
    },
    {
      'name': 'Assorted Fruits Basket',
      'category': 'Fresh Produce',
      'grade': 'Mixed',
      'min_order': '1 basket',
      'status': 'In Stock',
      'price': '5.50',
      'unit': 'basket',
      'image_url': 'assets/images/fruits.png',
      'description': 'A selection of mixed seasonal fruits.',
      'seller_name': 'Deeqa Ibrahim',
      'location': 'Afgooye',
      'rating': 4.9,
      'reviews': 112,
      'delivery_options': 'Gift delivery available',
    },
    {
      'name': 'Fresh Bananas (Export)',
      'category': 'Fresh Produce',
      'grade': 'A+',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '0.90',
      'unit': 'kg',
      'image_url': 'assets/images/banana.png',
      'description': 'Top grade bananas selected for international standards.',
      'seller_name': 'Hodan Abdi',
      'location': 'Mogadishu',
      'rating': 4.8,
      'reviews': 95,
      'delivery_options': 'Inter-city cold logistics',
    },
    {
      'name': 'Premium Tomatoes',
      'category': 'Fresh Produce',
      'grade': 'Select',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '1.05',
      'unit': 'kg',
      'image_url': 'assets/images/tomatoes.png',
      'description': 'Specially selected firm red tomatoes.',
      'seller_name': 'Farhia Kheyre',
      'location': 'Kismayo',
      'rating': 4.7,
      'reviews': 63,
      'delivery_options': 'Coastal logistics',
    },
    {
      'name': 'Hub Logistics Services',
      'category': 'Logistics',
      'grade': 'Professional',
      'min_order': '1 dispatch',
      'status': 'Available',
      'price': '15.00',
      'unit': 'service',
      'image_url': 'assets/images/market.png',
      'description': 'Professional sorting and packaging services for regional sellers.',
      'seller_name': 'Sumaya Warsame',
      'location': 'Berbera',
      'rating': 4.8,
      'reviews': 47,
      'delivery_options': 'Central Hub pickup',
    },
    {
      'name': 'Fresh Beetroot (Med)',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '5kg',
      'status': 'In Stock',
      'price': '0.95',
      'unit': 'kg',
      'image_url': 'assets/images/betroot.png',
      'description': 'Tender young beetroots, great for roasting.',
      'seller_name': 'Rahma Yusuf',
      'location': 'Eyl',
      'rating': 4.4,
      'reviews': 15,
      'delivery_options': 'Local Delivery',
    },
    {
      'name': 'Standard Cabbage XL',
      'category': 'Fresh Produce',
      'grade': 'Bulk',
      'min_order': '25kg',
      'status': 'In Stock',
      'price': '0.55',
      'unit': 'kg',
      'image_url': 'assets/images/cabbage.png',
      'description': 'Large size cabbages for bulk kitchens.',
      'seller_name': 'Sadiyo Ali',
      'location': 'Garowe',
      'rating': 4.2,
      'reviews': 38,
      'delivery_options': 'Kitchen delivery service',
    },
    {
      'name': 'Small Cantaloupes (Pack)',
      'category': 'Fresh Produce',
      'grade': 'Mini',
      'min_order': '4 units',
      'status': 'In Stock',
      'price': '1.20',
      'unit': 'kg',
      'image_url': 'assets/images/cantloupe.png',
      'description': 'Personal sized sweet melons.',
      'seller_name': 'Luul Hussein',
      'location': 'Hargeisa',
      'rating': 4.6,
      'reviews': 24,
      'delivery_options': 'Standard Delivery',
    },
    {
      'name': 'Carrot Sticks (Bulk)',
      'category': 'Fresh Produce',
      'grade': 'Processed',
      'min_order': '10 packs',
      'status': 'In Stock',
      'price': '1.50',
      'unit': 'pack',
      'image_url': 'assets/images/carrot.png',
      'description': 'Pre-cut fresh carrot sticks for convenience.',
      'seller_name': 'Maryama Said',
      'location': 'Bosaso',
      'rating': 4.7,
      'reviews': 31,
      'delivery_options': 'Next day delivery',
    },
    {
      'name': 'Coconut Water (Litre)',
      'category': 'Fresh Produce',
      'grade': 'Natural',
      'min_order': '10 bottles',
      'status': 'In Stock',
      'price': '2.50',
      'unit': 'bottle',
      'image_url': 'assets/images/cocunut.png',
      'description': 'Pure coconut water, no additives.',
      'seller_name': 'Fardowsa Aden',
      'location': 'Marka',
      'rating': 4.9,
      'reviews': 54,
      'delivery_options': 'Cold shipping',
    },
    {
      'name': 'Premium Cowpeas (Dry)',
      'category': 'Grains & Legumes',
      'grade': 'Select',
      'min_order': '50kg',
      'status': 'In Stock',
      'price': '2.80',
      'unit': 'kg',
      'image_url': 'assets/images/cowpeas.png',
      'description': 'Cleaned and export-ready cowpeas.',
      'seller_name': 'Muna Deeq',
      'location': 'Jowhar',
      'rating': 4.8,
      'reviews': 42,
      'delivery_options': 'Export logistics',
    },
    {
      'name': 'Salad Cucumber (Bulk)',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '25kg',
      'status': 'In Stock',
      'price': '1.10',
      'unit': 'kg',
      'image_url': 'assets/images/cucumber.png',
      'description': 'Long seedless cucumbers.',
      'seller_name': 'Nimo Ahmed',
      'location': 'Mogadishu',
      'rating': 4.5,
      'reviews': 36,
      'delivery_options': 'City market logistics',
    },
    {
      'name': 'Organic Coriander (Bulk)',
      'category': 'Fresh Produce',
      'grade': 'Organic',
      'min_order': '50 bunches',
      'status': 'In Stock',
      'price': '0.60',
      'unit': 'bunch',
      'image_url': 'assets/images/fresh_corender.png',
      'description': 'Certified organic fresh herbs.',
      'seller_name': 'Caasha Nur',
      'location': 'Berbera',
      'rating': 4.8,
      'reviews': 29,
      'delivery_options': 'Night-delivery logistics',
    },
    {
      'name': 'Sorghum Flour (Fine)',
      'category': 'Grains & Legumes',
      'grade': 'Milled',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '2.20',
      'unit': 'kg',
      'image_url': 'assets/images/fresh_organic_sorghum.png',
      'description': 'Ground organic sorghum for traditional porridge.',
      'seller_name': 'Barni Warsame',
      'location': 'Baidoa',
      'rating': 4.7,
      'reviews': 63,
      'delivery_options': 'Store delivery',
    },
    {
      'name': 'Red Grapefruit XL',
      'category': 'Fresh Produce',
      'grade': 'Jumbo',
      'min_order': '10 cases',
      'status': 'In Stock',
      'price': '1.50',
      'unit': 'kg',
      'image_url': 'assets/images/grape_fruit.png',
      'description': 'Premium red-fleshed grapefruits.',
      'seller_name': 'Ardo Ali',
      'location': 'Janale',
      'rating': 4.6,
      'reviews': 24,
      'delivery_options': 'Wholesale logistics',
    },
    {
      'name': 'Mixed Peppers (Tray)',
      'category': 'Fresh Produce',
      'grade': 'A',
      'min_order': '5 cases',
      'status': 'In Stock',
      'price': '2.40',
      'unit': 'kg',
      'image_url': 'assets/images/green_pepper.png',
      'description': 'A combination of green, red, and yellow peppers.',
      'seller_name': 'Fawzia Kheyre',
      'location': 'Hargeisa',
      'rating': 4.8,
      'reviews': 49,
      'delivery_options': 'Express Market delivery',
    },
    {
      'name': 'Local Lettuce (Home)',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '10 units',
      'status': 'In Stock',
      'price': '0.70',
      'unit': 'unit',
      'image_url': 'assets/images/lattuce_bagal.png',
      'description': 'Sustainable leafy greens from backyard farms.',
      'seller_name': 'Kaltum Ismail',
      'location': 'Garowe',
      'rating': 4.5,
      'reviews': 17,
      'delivery_options': 'Neighborhood pickup',
    },
    {
      'name': 'Lemon Juice Pure',
      'category': 'Fresh Produce',
      'grade': 'Natural',
      'min_order': '5 litres',
      'status': 'In Stock',
      'price': '3.00',
      'unit': 'litre',
      'image_url': 'assets/images/lemon.png',
      'description': '100% pure squeezed Somali lemon juice.',
      'seller_name': 'Idil Abdi',
      'location': 'Beletweyne',
      'rating': 4.8,
      'reviews': 34,
      'delivery_options': 'Fresh dispatch',
    },
    {
      'name': 'Dried Mango Slices (Bag)',
      'category': 'Fresh Produce',
      'grade': 'Export',
      'min_order': '10 packs',
      'status': 'In Stock',
      'price': '4.50',
      'unit': 'kg',
      'image_url': 'assets/images/mangoes.png',
      'description': 'Sun-dried mangoes, no added sugar.',
      'seller_name': 'Sagal Jama',
      'location': 'Afgooye',
      'rating': 4.9,
      'reviews': 76,
      'delivery_options': 'Global shipping-ready',
    },
    {
      'name': 'Standard Okra (Bulk)',
      'category': 'Fresh Produce',
      'grade': 'Standard',
      'min_order': '10kg',
      'status': 'In Stock',
      'price': '0.85',
      'unit': 'kg',
      'image_url': 'assets/images/okra.png',
      'description': 'Regular grade okra for daily consumption.',
      'seller_name': 'Shamis Omar',
      'location': 'Marka',
      'rating': 4.4,
      'reviews': 29,
      'delivery_options': 'Wait-market pickup',
    },
    {
      'name': 'Papaya Puree (Litre)',
      'category': 'Fresh Produce',
      'grade': 'Pure',
      'min_order': '20 bottles',
      'status': 'In Stock',
      'price': '2.10',
      'unit': 'bottle',
      'image_url': 'assets/images/papaya.png',
      'description': 'Smooth papaya puree for juices and desserts.',
      'seller_name': 'Kiin Farah',
      'location': 'Kismayo',
      'rating': 4.5,
      'reviews': 18,
      'delivery_options': 'Riverine cold chain',
    },
    {
      'name': 'Hot Chilli Flakes (Jar)',
      'category': 'Fresh Produce',
      'grade': 'Premium',
      'min_order': '12 jars',
      'status': 'In Stock',
      'price': '1.50',
      'unit': 'jar',
      'image_url': 'assets/images/pepper.png',
      'description': 'Dried and crushed red chillies.',
      'seller_name': 'Filsan Abshir',
      'location': 'Burao',
      'rating': 4.7,
      'reviews': 54,
      'delivery_options': 'Speedy courier',
    },
    {
      'name': 'Tomato Paste Organic',
      'category': 'Fresh Produce',
      'grade': 'House',
      'min_order': '10 jars',
      'status': 'In Stock',
      'price': '3.20',
      'unit': 'jar',
      'image_url': 'assets/images/plum_tomato.png',
      'description': 'Rich tomato paste made from plum tomatoes.',
      'seller_name': 'Rowda Guled',
      'location': 'Las Anod',
      'rating': 4.8,
      'reviews': 31,
      'delivery_options': 'Direct dispatch',
    },
    {
      'name': 'Refined Sesame Oil (Litre)',
      'category': 'Grains & Legumes',
      'grade': 'Premium',
      'min_order': '5 litres',
      'status': 'In Stock',
      'price': '6.00',
      'unit': 'litre',
      'image_url': 'assets/images/premium_sesum_seeds.png',
      'description': 'Cold-pressed pure sesame oil.',
      'seller_name': 'Sahro Said',
      'location': 'Garbahaarey',
      'rating': 4.9,
      'reviews': 45,
      'delivery_options': 'Secure shipping',
    },
    {
      'name': 'Spinach Puree (Frozen)',
      'category': 'Fresh Produce',
      'grade': 'Organic',
      'min_order': '10 packs',
      'status': 'In Stock',
      'price': '1.80',
      'unit': 'kg',
      'image_url': 'assets/images/spinch.png',
      'description': 'Blanched and pureed organic spinach.',
      'seller_name': 'Khadijo Qalib',
      'location': 'Borama',
      'rating': 4.7,
      'reviews': 29,
      'delivery_options': 'Mountain Eco-delivery',
    },
  ];

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  String _selectedCategory = 'All';
  bool _subscribed = false;

  @override
  void initState() {
    super.initState();
    _products = List<Map<String, dynamic>>.from(_defaultProducts);
    _filteredProducts = List<Map<String, dynamic>>.from(_defaultProducts);
    _loadProducts();
    _searchController.addListener(_applyFilters);
  }

  Future<void> _loadProducts() async {
    final productResponse = await ApiService().getProducts();
    setState(() {
      final liveProducts = productResponse.map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item as Map<String, dynamic>)).toList();
      _products = [..._defaultProducts, ...liveProducts];
      _applyFilters();
    });
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        final name = (product['name'] as String?)?.toLowerCase() ?? '';
        final category = (product['category'] as String?)?.toLowerCase() ?? '';
        final matchesSearch = query.isEmpty || name.contains(query) || category.contains(query);
        final matchesCategory = _selectedCategory == 'All' || category == _selectedCategory.toLowerCase();
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.shopProduce),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: translations.browseFreshProduce),
            Text(
              translations.browseProduceDesc,
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SizedBox(height: 24),
            _searchBar(translations),
            const SizedBox(height: 16),
            _categoryChips(),
            const SizedBox(height: 24),
            _alertCard(),
            const SizedBox(height: 32),
            SectionHeader(title: translations.freshArrivals),
            if (_filteredProducts.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Text('No listings match your search. Try another category or keyword.', style: TextStyle(color: AppColors.textMedium)),
                ),
              )
            else
              ..._filteredProducts.map((product) => _productItem(product, translations)).toList(),
            const SizedBox(height: 24),
            Text(
              translations.finalConfirmationNote,
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textLight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weekly market and weather alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Subscribe to receive weekly updates on crop prices, weather forecasts and delivery availability.',
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _subscribed = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Subscribed to weekly updates.')),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryGreen, minimumSize: const Size(130, 52)),
                  child: const Text('Subscribe'),
                ),
              ],
            ),
            if (_subscribed)
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text('You are receiving weekly alerts.', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(AppTranslations translations) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: translations.searchProducts,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget _categoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              selectedColor: AppColors.primaryBlue,
              labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.primaryBlue),
              backgroundColor: AppColors.lightGray,
              onSelected: (_) {
                setState(() {
                  _selectedCategory = category;
                  _applyFilters();
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _productItem(Map<String, dynamic> product, AppTranslations translations) {
    final String imageUrl = product['image_url'] as String? ?? '';
    final String status = product['status'] as String? ?? translations.inStock;
    final String grade = product['grade'] as String? ?? 'Standard';
    final String minOrder = product['min_order'] as String? ?? '1kg';
    final String rating = (product['rating']?.toString() ?? '4.8');

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              SizedBox(
                height: 140,
                width: double.infinity,
                child: imageUrl.startsWith('http')
                    ? Image.network(imageUrl, fit: BoxFit.cover)
                    : Image.asset(imageUrl, fit: BoxFit.cover),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['name'] as String? ?? 'Product', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text('Grade: $grade • Min: $minOrder', style: TextStyle(color: AppColors.textMedium)),
                          ],
                        ),
                      ),
                      StatusBadge(status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildTag(product['category'] as String? ?? 'Produce'),
                      _buildTag('$rating ⭐'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            minimumSize: const Size.fromHeight(44),
                          ),
                          child: const Text('View details'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(44),
                          side: BorderSide(color: AppColors.primaryBlue),
                        ),
                        child: const Text('Contact'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final active = status == 'In Stock' || status == AppLocalizations.of(context).translations.inStock;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? AppColors.secondaryGreen : AppColors.accent,
        borderRadius: BorderRadius.circular(AppColors.borderRadiusSmall),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
