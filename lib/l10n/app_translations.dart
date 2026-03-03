class AppTranslations {
  final String languageCode;

  AppTranslations(this.languageCode);

  // Translation strings
  String get appTitle => languageCode == 'so' ? 'BaadiGoob AgroLink' : 'BaadiGoob AgroLink';
  
  // Navbar / Common
  String get marketPrices => languageCode == 'so' ? 'Qiimaha Suuqa' : 'Market Prices';
  String get weather => languageCode == 'so' ? 'Cimilada' : 'Weather';
  String get marketplace => languageCode == 'so' ? 'Suuqa' : 'Marketplace';
  String get community => languageCode == 'so' ? 'Bulshada' : 'Community';
  String get signInSeller => languageCode == 'so' ? 'Gal Iibiye ahaan' : 'Sign In as Seller';
  String get signInBuyer => languageCode == 'so' ? 'Gal Iibsade ahaan' : 'Sign In as Buyer';
  
  // Hero Section
  String get heroTitle => languageCode == 'so' 
    ? 'Beer, Iib & Horumari BaadiGoob' 
    : 'Buy fresh produce in bulk — delivered with confidence.';
  String get heroSubtitle => languageCode == 'so'
    ? 'Iibiyayaasha ansaxan, xaqiijinta codsiga, iyo is-wareegga is-dhigsiinta adiga iyo kooxda BaadiGoob AgroLink.'
    : 'Verified sellers, clear order confirmation, and reliable delivery coordination by the BaadiGoob AgroLink team.';
  String get startShopping => languageCode == 'so' ? 'Bilow Iibinta' : 'Start Shopping';
  String get requestQuote => languageCode == 'so' ? 'Codsiga Qiimaha' : 'Request Quote';
  
  // Trust Highlights
  String get trustHighlights => languageCode == 'so' ? 'Muujinayaanshaha Ammaanka' : 'Trust Highlights';
  String get verifiedSellers => languageCode == 'so' ? 'Iibiyayaasha ansaxan iyo baaritaanka qualityga' : 'Verified sellers and basic quality checks';
  String get bulkOrdering => languageCode == 'so' ? 'Iibka bulk + jeegyada noocyo badan (maalinle/Usbuucle)' : 'Bulk ordering + repeat schedules (daily/weekly)';
  String get deliveryCoordination => languageCode == 'so' ? 'Is-wareegga uruurinta iyo gaadiidka' : 'Aggregation and delivery coordination';
  String get orderUpdates => languageCode == 'so' ? 'Cusbooneysiinta xaaladda codsiga (Appka + WhatsApp)' : 'Order status updates (In-app + WhatsApp)';
  
  // Impact Section
  String get ourImpact => languageCode == 'so' ? 'Saamaynteena' : 'Our Impact';
  String get impactDescription => languageCode == 'so'
    ? 'BaadiGoob AgroLink wuxuu kordhiyaa dakhliga haweenka beeraha, wuxuu hagaajiyaa qiimaha adal,na yaraynayaa khasaaraha ka dib goosashada adiga iyo kooxda.'
    : 'BaadiGoob AgroLink increases income for women farmers, improves fair pricing, and reduces post-harvest losses through coordinated delivery routines.';
  
  // How It Works
  String get howItWorks => languageCode == 'so' ? 'Sidee Ayuu U Shaqeyaa' : 'How It Works';
  String get step1 => languageCode == 'so' ? 'Ka eeg oo dooro alaab' : 'Browse & choose products';
  String get step2 => languageCode == 'so' ? 'Codsigid ama codsiga qiimaha' : 'Place an order or Request Quote';
  String get step3 => languageCode == 'so' ? 'Waxaan u xaqiijinaynaa oo is-wareegnaa bsupply' : 'We confirm & coordinate supply';
  String get step4 => languageCode == 'so' ? 'Gaadiidka waxaa loo samaynayaa cusbooneysiin' : 'Delivery arranged with updates';
  String get viewDetailedGuide => languageCode == 'so' ? 'Arag Hagidda Faahfaahintan' : 'View Detailed Guide';
  
  // CTA Section
  String get readyToJoin => languageCode == 'so' ? 'Ma diyaar u tahay inaad ku biirto?' : 'Ready to join?';
  String get getStarted => languageCode == 'so' ? 'Bilow / Doonto' : 'Get Started / Register';
  
  // Market Prices Section
  String get livePrices => languageCode == 'so' ? 'Qiimaha Tooska ah' : 'Live Prices';
  String get todaysMarketPrices => languageCode == 'so' ? 'Qiimaha Suuqa Maanta' : 'Today\'s Market Prices';
  String get marketPricesDesc => languageCode == 'so' 
    ? 'Is barbar dhig qiimaha beeraha suuqyada waaweyn ee Soomaaliya si aad u hesho heshiiska ugu fiican.'
    : 'Compare crop prices across Somalia\'s major markets to get the best deal for your harvest.';
  
  // Weather Section
  String get weatherUpdates => languageCode == 'so' ? 'Warbixinta Cimilada' : 'Weather Updates';
  String get weatherAdvisory => languageCode == 'so' ? 'Talo-bixinta Cimilada' : 'Weather Advisory';
  String get weatherDesc => languageCode == 'so' 
    ? 'Qorshe goosashada iyo gaadiidka oo leh saadaasha cimilada saxda ah ee gobolkaaga.'
    : 'Plan your harvest and transport with accurate weather forecasts for your region.';
  String get currentWeather => languageCode == 'so' ? 'Cimilada Hadda — Gobolka Muqdisho' : 'Current Weather — Mogadishu Region';
  String get idealForHarvesting => languageCode == 'so' ? 'Qorrax — Ku haboon goosashada' : 'Sunny — Ideal for harvesting';
  String get humidity => languageCode == 'so' ? 'qoyaan' : 'humidity';
  String get wind => languageCode == 'so' ? 'dabayl' : 'wind';
  String get uvIndex => languageCode == 'so' ? 'Heerka UV: Sare' : 'UV Index: High';
  String get farmingAdvisory => languageCode == 'so' ? 'Talo Beereed:' : 'Farming Advisory:';
  String get farmingAdvisoryText => languageCode == 'so'
    ? 'Xaaladda aad u fiican goosashada iyo gaadiidka beeraha 3-da maalmood ee soo socda. Ka fiirso shaqada dibedda Khamiista sababo la xiriira roobka fudud ee la filayo.'
    : 'Excellent conditions for harvesting and transporting crops over the next 3 days. Consider delaying outdoor work on Thursday due to expected light rainfall.';
  String get today => languageCode == 'so' ? 'Maanta' : 'Today';
  String get tomorrow => languageCode == 'so' ? 'Berri' : 'Tomorrow';
  
  // Marketplace Section
  String get buySell => languageCode == 'so' ? 'Iib & Gado' : 'Buy & Sell';
  String get freshFromFarm => languageCode == 'so' ? 'Cusub Beerta ka yimid' : 'Fresh from the Farm';
  String get marketplaceDesc => languageCode == 'so'
    ? 'Daawad liiskii beeraha haweenka la xaqiijiyay ee Soomaaliya. Si toos ah u iibso — dhexdhexaad la\'aan.'
    : 'Browse produce listings from verified female farmers across Somalia. Buy directly — no middlemen.';
  String get order => languageCode == 'so' ? 'Dalbo' : 'Order';
  String get viewAllListings => languageCode == 'so' ? 'Arag Dhammaan Liiska' : 'View All Listings';
  String get available => languageCode == 'so' ? 'la heli karo' : 'available';
  
  // Community Section
  String get learnConnect => languageCode == 'so' ? 'Baro & Ku Xidh' : 'Learn & Connect';
  String get communityLearning => languageCode == 'so' ? 'Bulshada & Barashada' : 'Community & Learning';
  String get communityDesc => languageCode == 'so'
    ? 'Kor u qaad aqoontaada oo ku xidh shabakad taageero leh oo beeraley iyo khubuuro ah.'
    : 'Grow your knowledge and connect with a supportive network of farmers and experts.';
  String get communityForum => languageCode == 'so' ? 'Madasha Bulshada' : 'Community Forum';
  String get communityForumDesc => languageCode == 'so'
    ? 'Su\'aalo weydii, khibrado la wadaag, oo ka jawaab hel beeraleyda kale iyo khuburada beeraha.'
    : 'Ask questions, share experiences, and get answers from fellow farmers and agricultural experts.';
  String get videoTutorials => languageCode == 'so' ? 'Muuqaalada Tababarka' : 'Video Tutorials';
  String get videoTutorialsDesc => languageCode == 'so'
    ? 'Daawo tababarrada beeraha oo tillaabo tillaabo ah oo ku saabsan farsamooyinka, daryeelka dhulka, iyo maaraynta beeraha.'
    : 'Watch step-by-step farming tutorials on improved techniques, soil care, and crop management.';
  String get farmingTips => languageCode == 'so' ? 'Talooyin Beereed' : 'Farming Tips';
  String get farmingTipsDesc => languageCode == 'so'
    ? 'Hel tilmaamaha xilliga, noocyada beeraha la hagaajiyay, iyo dhaqamada ugu wanaagsan gobolkaaga.'
    : 'Access seasonal guides, improved crop varieties, and best practices for your region.';
  String get expertNetwork => languageCode == 'so' ? 'Shabakadda Khuburada' : 'Expert Network';
  String get expertNetworkDesc => languageCode == 'so'
    ? 'La xiriir khuburada beeraha ee kaa caawin kara xallinta dhibaatooyinka iyo hagaajinta wax soo saarka.'
    : 'Connect with agricultural specialists who can help you solve problems and improve yields.';
  String get joinCommunity => languageCode == 'so' ? 'Ku Biir Bulshada' : 'Join the Community';
  
  // Testimonials Section
  String get satisfiedClients => languageCode == 'so' ? 'Macaamiisha Ku Qanacsanayd' : 'Satisfied Clients';
  String get whatFarmersSay => languageCode == 'so' ? 'Maxay Beeraleydeenu Yidhaahdaan' : 'What Our Farmers Say';
  String get testimonialsDesc => languageCode == 'so'
    ? 'Ka maqal haweenka nolol maalmeedkooda ku bedelaya BaadiGoob AgroLink.'
    : 'Hear from the women who are transforming their livelihoods with BaadiGoob AgroLink.';
  
  // Footer Section
  String get footerDesc => languageCode == 'so'
    ? 'Awood siinta beeraha haweenka Soomaaliyeed oo leh gelitaanka suuqa, warbixinta cimilada, iibsadayaasha, iyo bulsho taageero leh.'
    : 'Empowering Somali female farmers with market access, weather insights, buyers, and a supportive community.';
  String get features => languageCode == 'so' ? 'Astaamaha' : 'Features';
  String get resources => languageCode == 'so' ? 'Kheyraadka' : 'Resources';
  String get seedOrdering => languageCode == 'so' ? 'Dalashada Abuurka' : 'Seed Ordering';
  String get governmentSchemes => languageCode == 'so' ? 'Mashruucyada Dawladda' : 'Government Schemes';
  String get contact => languageCode == 'so' ? 'La Xiriir' : 'Contact';
  String get footerCopy => languageCode == 'so'
    ? '© 2026 BaadiGoob AgroLink. Dhammaan xuquuqda way xidhanyihiin. Awood siinta beeraleyda, hal goosasho mar.'
    : '© 2026 BaadiGoob AgroLink. All rights reserved. Empowering farmers, one harvest at a time.';
  
  // Additional common strings
  String get language => languageCode == 'so' ? 'Afka' : 'Language';
  String get english => languageCode == 'so' ? 'Ingiriisi' : 'English';
  String get somali => languageCode == 'so' ? 'Soomaali' : 'Somali';
  String get changeLanguage => languageCode == 'so' ? 'Bedel Afka' : 'Change Language';
}
