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
  String get login => languageCode == 'so' ? 'Gal' : 'Login';
  String get logout => languageCode == 'so' ? 'Ka Bax' : 'Logout';
  String get profile => languageCode == 'so' ? 'Profile' : 'Profile';
  String get home => languageCode == 'so' ? 'Guriga' : 'Home';
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
  String get verifiedSellers => languageCode == 'so' ? 'Iibiyayaasha ansaxan iyo baaritaanka tayada' : 'Verified sellers and basic quality checks';
  String get bulkOrdering => languageCode == 'so' ? 'Iibka bulk + jadwalka dib-u-celinta (maalinle/usbuucli)' : 'Bulk ordering + repeat schedules (daily/weekly)';
  String get deliveryCoordination => languageCode == 'so' ? 'Iskewidda ururinta iyo keenista' : 'Aggregation and delivery coordination';
  String get orderUpdates => languageCode == 'so' ? 'Cusboonaysiinta heerka dalabka (Gudaha appka + WhatsApp)' : 'Order status updates (In-app + WhatsApp)';
  
  // Impact Section
  String get ourImpact => languageCode == 'so' ? 'Saamaynteena' : 'Our Impact';
  String get impactDescription => languageCode == 'so'
    ? 'BaadiGoob AgroLink wuxuu kordhiyaa dakhliga haweenka beeraha, wuxuu hagaajiyaa qiimaha adal,na yaraynayaa khasaaraha ka dib goosashada adiga iyo kooxda.'
    : 'BaadiGoob AgroLink increases income for women farmers, improves fair pricing, and reduces post-harvest losses through coordinated delivery routines.';
  
  // How It Works
  String get howItWorks => languageCode == 'so' ? 'Sidee Ayuu U Shaqeyaa' : 'How It Works';
  String get step1 => languageCode == 'so' ? 'Baadh & dooro alaabta' : 'Browse & choose products';
  String get step2 => languageCode == 'so' ? 'Dalbo ama Codso Qiimaha' : 'Place an order or Request Quote';
  String get step3 => languageCode == 'so' ? 'Waanu xaqiijinaynaa oo isku dubaridnaa bixinta' : 'We confirm & coordinate supply';
  String get step4 => languageCode == 'so' ? 'Keenista oo lagu habeeyey cusboonaysiin' : 'Delivery arranged with updates';
  String get viewDetailedGuide => languageCode == 'so' ? 'Eeg Hagaha Faahfaahsan' : 'View Detailed Guide';
  
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
  
  // Common UI
  String get errorLoading => languageCode == 'so' ? 'Cillad ayaa ka dhacday soo dejinta' : 'Error loading content';
  String get retry => languageCode == 'so' ? 'Ku celi' : 'Retry';
  String get noData => languageCode == 'so' ? 'Xog lama heli karo' : 'No data available';
  String get loading => languageCode == 'so' ? 'Waa la soo dejinayaa...' : 'Loading...';
  String get unknownProduct => languageCode == 'so' ? 'Alaab aan la aqoon' : 'Unknown Product';
  String get weatherForecast => languageCode == 'so' ? 'Saadaasha Hawada' : 'Weather Forecast';
  String get upcomingForecast => languageCode == 'so' ? 'Saadaasha Soo Socota' : 'Upcoming Forecast';
  String get unknownWeather => languageCode == 'so' ? 'Lama yaqaan' : 'Unknown';
  String get notImplemented => languageCode == 'so' ? 'Weli lama fulin' : 'Not implemented yet';
  String get noPosts => languageCode == 'so' ? 'Wax qoraal ah lama helin. Noqo qofka ugu horreeya ee bilaaba dood!' : 'No posts found. Be the first to start a discussion!';
  String get views => languageCode == 'so' ? 'daawasho' : 'views';
  String get noTitle => languageCode == 'so' ? 'Cinwaan la\'aan' : 'No Title';
  String get contactUs => languageCode == 'so' ? 'Nala Soo Xiriir' : 'Contact Us';
  String get getInTouch => languageCode == 'so' ? 'Nala Soo Xiriir' : 'Get in Touch';
  String get contactDescription => languageCode == 'so'
      ? 'Waxaan jeclaan lahayn inaan kaa maqalno. Haddii aad tahay iibsadaha raadinaya wax soo saarka cusub, beeralay/alaab-qeybiye xiiseynaya inuu wax ku iibiyo BaadiGoob AgroLink, ama saaxiib raba inuu nala shaqeeyo—nalasoo xiriir wakhti kasta.'
      : 'We’d love to hear from you. Whether you’re a buyer looking to source fresh produce, a farmer/supplier interested in selling through BaadiGoob AgroLink, or a partner who wants to collaborate—reach out anytime.';
  String get website => languageCode == 'so' ? 'Webusaytka' : 'Website';
  String get email => languageCode == 'so' ? 'Iimayl' : 'Email';
  String get phoneWhatsApp => languageCode == 'so' ? 'Telefoon / WhatsApp' : 'Phone / WhatsApp';
  String get callCenter => languageCode == 'so' ? 'Xarunta Wicitaanka' : 'Call Center';
  String get location => languageCode == 'so' ? 'Goobta' : 'Location';
  String get socialMedia => languageCode == 'so' ? 'Baraha Bulshada' : 'Social Media';
  String get followUs => languageCode == 'so' ? 'Nala soco oo la soco wixii ku cusub: @baadigoobonline' : 'Follow us and stay updated: @baadigoobonline';
  String get readyToPartner => languageCode == 'so' ? 'Ma diyaar u tahay inaad nala shaqeyso?' : 'Ready to partner with us?';
  String get letConnectFarmers => languageCode == 'so'
      ? 'Aynu isku xidhno beeralayda iyo suuqyada—si daah-furan oo waara'
      : 'Let’s connect farmers to markets—transparently and sustainably';
  String get aboutBaadigoob => languageCode == 'so' ? 'Ku saabsan BaadiGoob AgroLink' : 'About BaadiGoob AgroLink';
  String get aboutDescription1 => languageCode == 'so'
      ? 'BaadiGoob AgroLink waa suuq wax soo saar oo loo dhisay in lagu xoojiyo nidaamyada suuqyada Soomaaliya, gaar ahaan hagaajinta helitaanka suuqa iyo dakhliga beeralayda haweenka ah. Waxaan isku xirnaa beeralayda iyo alaab-qeybiyeyaasha la xaqiijiyay iyo iibsadayaasha dhabta ah (maqaayadaha, hoteelada, dukaamada waaweyn, kuwa wax kariya, hay\'adaha, iyo qoysaska).'
      : 'BaadiGoob AgroLink is a produce marketplace built to strengthen Somali market systems, especially by improving market access and income for women farmers. We connect verified farmers and suppliers with serious buyers (restaurants, hotels, supermarkets, caterers, institutions, and families).';
  String get aboutDescription2 => languageCode == 'so'
      ? 'Kooxdayada hawlgalku waxay taageeraan dhammaan habka dalbashada, laga bilaabo xaqiijinta helitaanka iyo qiimaha ilaa isku-dubbaridka isu-ururinta iyo keenista, si ganacsigu u noqdo mid abaabulan, hufan, oo la isku halleyn karo.'
      : 'Our operations team supports the full ordering process, from confirming availability and pricing to coordinating aggregation and delivery, so trade becomes more organised, transparent, and reliable.';
  String get ourMission => languageCode == 'so' ? 'Hadafkayaga' : 'Our Mission';
  String get missionDescription => languageCode == 'so'
      ? 'In la ballaadhiyo helitaanka suuqa ee beeralayda haweenka ah, la yareeyo qashinka, lana kordhiyo dakhliga iyada oo loo marayo suuq wax soo saar oo la aamini karo oo tiknoolajiyadu awood u siisay.'
      : 'To expand market access for women farmers, reduce waste, and increase incomes through a trusted, tech-enabled produce marketplace.';
  String get coreValues => languageCode == 'so' ? 'Qiimayaasha Muhiimka ah' : 'Core Values';
  String get trust => languageCode == 'so' ? 'Aamin' : 'Trust';
  String get coordination => languageCode == 'so' ? 'Isku-dubbaridka' : 'Coordination';
  String get fairTrade => languageCode == 'so' ? 'Ganacsi Cadaalad ah' : 'Fair Trade';
  String get reliability => languageCode == 'so' ? 'Isku-halaynta' : 'Reliability';
  String get womenEmpowerment => languageCode == 'so' ? 'Awoodsiinta Dhaqaale ee Haweenka' : 'Women’s Economic Empowerment';
  String get localGrowth => languageCode == 'so' ? 'Kicinta Maxalliga ah' : 'Local Growth';
  String get readyToPartnerLong => languageCode == 'so' ? 'Ma diyaar u tahay inaad nala shaqeyso?' : 'Ready to partner with us?';
  
  // Additional common strings
  String get language => languageCode == 'so' ? 'Afka' : 'Language';
  String get english => languageCode == 'so' ? 'Ingiriisi' : 'English';
  String get somali => languageCode == 'so' ? 'Soomaali' : 'Somali';
  String get changeLanguage => languageCode == 'so' ? 'Bedel Afka' : 'Change Language';
  String get switchRole => languageCode == 'so' ? 'Dooro Doorka' : 'Switch Role';
  String get version => languageCode == 'so' ? 'Heerka' : 'Version';
  String get user => languageCode == 'so' ? 'Isticmaalaha' : 'User';

  // Roles
  String get roleBuyer => languageCode == 'so' ? 'Iibsadaha' : 'Buyer';
  String get roleSeller => languageCode == 'so' ? 'Iibiyaha' : 'Seller';
  String get roleDriver => languageCode == 'so' ? 'Darawalka' : 'Driver';
  String get roleAdmin => languageCode == 'so' ? 'Maamulaha' : 'Admin';
  String get roleOps => languageCode == 'so' ? 'Wakiilka' : 'Ops / Agent';
  String get roleFinance => languageCode == 'so' ? 'Maaliyadda' : 'Finance';
  String get roleHub => languageCode == 'so' ? 'Xarunta' : 'Hub Staff';
  String get rolePartner => languageCode == 'so' ? 'Shuraakada' : 'Partner';
  String get roleExpert => languageCode == 'so' ? 'Khabiir' : 'Expert';
  String get roleChoose => languageCode == 'so' ? 'Dooro Doorka' : 'Choose a Role';

  // Drawer labels
  String get marketPricesTitle => languageCode == 'so' ? 'Qiimaha Suuqa' : 'Market Prices';
  String get addProduce => languageCode == 'so' ? 'Ku dar Wax-soo-saarka' : 'Add Produce';
  String get myListings => languageCode == 'so' ? 'Liiska Iibka' : 'My Listings';
  String get orders => languageCode == 'so' ? 'Dalabaadka' : 'Orders';
  String get weatherTitle => languageCode == 'so' ? 'Cimilada' : 'Weather';
  String get communityTitle => languageCode == 'so' ? 'Bulshada' : 'Community';
  String get support => languageCode == 'so' ? 'Taageero' : 'Support';
  String get dashboard => languageCode == 'so' ? 'Dashboard' : 'Dashboard';
  String get farmers => languageCode == 'so' ? 'Beeralayda' : 'Farmers';
  String get logistics => languageCode == 'so' ? 'Saadka' : 'Logistics';
  String get issues => languageCode == 'so' ? 'Arrimaha' : 'Issues';
  String get reports => languageCode == 'so' ? 'Warbixinno' : 'Reports';
  String get myTrips => languageCode == 'so' ? 'Safarradayda' : 'My Trips';
  String get pickups => languageCode == 'so' ? 'Qaadista' : 'Pickups';
  String get deliveries => languageCode == 'so' ? 'Gawaarida' : 'Deliveries';
  String get pod => languageCode == 'so' ? 'Caddaynta Gaarsiinta' : 'Proof of Delivery';
  String get earnings => languageCode == 'so' ? 'Dakhliga' : 'Earnings';
  String get usersRoles => languageCode == 'so' ? 'Isticmaalayaasha & Doorka' : 'Users & Roles';
  String get contentCommunity => languageCode == 'so' ? 'Mawduuca/Bulshada' : 'Content/Community';
  String get payments => languageCode == 'so' ? 'Lacag-bixinta' : 'Payments';
  String get disputes => languageCode == 'so' ? 'Khilaafaadka' : 'Disputes';
  String get settings => languageCode == 'so' ? 'Dejinta' : 'Settings';
  String get invoices => languageCode == 'so' ? 'Invoisyada' : 'Invoices';
  String get buyerPayments => languageCode == 'so' ? 'Lacagaha Iibsadaha' : 'Buyer Payments';
  String get sellerPayouts => languageCode == 'so' ? 'Lacagaha Iibiyaha' : 'Seller Payouts';
  String get feesCommission => languageCode == 'so' ? 'Kharashka/Dhaqaalaha' : 'Fees/Commission';
  String get refunds => languageCode == 'so' ? 'Lacag Celin' : 'Refunds';
  String get incomingPickups => languageCode == 'so' ? 'Qaadista Soo Socota' : 'Incoming Pickups';
  String get sortingPackaging => languageCode == 'so' ? 'Kala-Saarista/Qaadista' : 'Sorting/Packaging';
  String get stockLoads => languageCode == 'so' ? 'Kaydka/Boostada' : 'Stock/Loads';
  String get dispatch => languageCode == 'so' ? 'Dirista' : 'Dispatch';
  String get impact => languageCode == 'so' ? 'Saameynta' : 'Impact';
  String get regions => languageCode == 'so' ? 'Gobollada' : 'Regions';
  // How It Works
  String get howItWorks => languageCode == 'so' ? 'Sidee Ayuu U Shaqeyaa' : 'How It Works';
  String get step1 => languageCode == 'so' ? 'Baadh & dooro alaabta' : 'Browse & choose products';
  String get step2 => languageCode == 'so' ? 'Dalbo ama Codso Qiimaha' : 'Place an order or Request Quote';
  String get step3 => languageCode == 'so' ? 'Waanu xaqiijinaynaa oo isku dubaridnaa bixinta' : 'We confirm & coordinate supply';
  String get step4 => languageCode == 'so' ? 'Keenista oo lagu habeeyey cusboonaysiin' : 'Delivery arranged with updates';
  String get viewDetailedGuide => languageCode == 'so' ? 'Eeg Hagaha Faahfaahsan' : 'View Detailed Guide';
  
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
  
  // Common UI
  String get errorLoading => languageCode == 'so' ? 'Cillad ayaa ka dhacday soo dejinta' : 'Error loading content';
  String get retry => languageCode == 'so' ? 'Ku celi' : 'Retry';
  String get noData => languageCode == 'so' ? 'Xog lama heli karo' : 'No data available';
  String get loading => languageCode == 'so' ? 'Waa la soo dejinayaa...' : 'Loading...';
  String get unknownProduct => languageCode == 'so' ? 'Alaab aan la aqoon' : 'Unknown Product';
  String get weatherForecast => languageCode == 'so' ? 'Saadaasha Hawada' : 'Weather Forecast';
  String get upcomingForecast => languageCode == 'so' ? 'Saadaasha Soo Socota' : 'Upcoming Forecast';
  String get unknownWeather => languageCode == 'so' ? 'Lama yaqaan' : 'Unknown';
  String get notImplemented => languageCode == 'so' ? 'Weli lama fulin' : 'Not implemented yet';
  String get noPosts => languageCode == 'so' ? 'Wax qoraal ah lama helin. Noqo qofka ugu horreeya ee bilaaba dood!' : 'No posts found. Be the first to start a discussion!';
  String get views => languageCode == 'so' ? 'daawasho' : 'views';
  String get noTitle => languageCode == 'so' ? 'Cinwaan la\'aan' : 'No Title';
  String get contactUs => languageCode == 'so' ? 'Nala Soo Xiriir' : 'Contact Us';
  String get getInTouch => languageCode == 'so' ? 'Nala Soo Xiriir' : 'Get in Touch';
  String get contactDescription => languageCode == 'so'
      ? 'Waxaan jeclaan lahayn inaan kaa maqalno. Haddii aad tahay iibsadaha raadinaya wax soo saarka cusub, beeralay/alaab-qeybiye xiiseynaya inuu wax ku iibiyo BaadiGoob AgroLink, ama saaxiib raba inuu nala shaqeeyo—nalasoo xiriir wakhti kasta.'
      : 'We’d love to hear from you. Whether you’re a buyer looking to source fresh produce, a farmer/supplier interested in selling through BaadiGoob AgroLink, or a partner who wants to collaborate—reach out anytime.';
  String get website => languageCode == 'so' ? 'Webusaytka' : 'Website';
  String get email => languageCode == 'so' ? 'Iimayl' : 'Email';
  String get phoneWhatsApp => languageCode == 'so' ? 'Telefoon / WhatsApp' : 'Phone / WhatsApp';
  String get callCenter => languageCode == 'so' ? 'Xarunta Wicitaanka' : 'Call Center';
  String get location => languageCode == 'so' ? 'Goobta' : 'Location';
  String get socialMedia => languageCode == 'so' ? 'Baraha Bulshada' : 'Social Media';
  String get followUs => languageCode == 'so' ? 'Nala soco oo la soco wixii ku cusub: @baadigoobonline' : 'Follow us and stay updated: @baadigoobonline';
  String get readyToPartner => languageCode == 'so' ? 'Ma diyaar u tahay inaad nala shaqeyso?' : 'Ready to partner with us?';
  String get letConnectFarmers => languageCode == 'so'
      ? 'Aynu isku xidhno beeralayda iyo suuqyada—si daah-furan oo waara'
      : 'Let’s connect farmers to markets—transparently and sustainably';
  String get aboutBaadigoob => languageCode == 'so' ? 'Ku saabsan BaadiGoob AgroLink' : 'About BaadiGoob AgroLink';
  String get aboutDescription1 => languageCode == 'so'
      ? 'BaadiGoob AgroLink waa suuq wax soo saar oo loo dhisay in lagu xoojiyo nidaamyada suuqyada Soomaaliya, gaar ahaan hagaajinta helitaanka suuqa iyo dakhliga beeralayda haweenka ah. Waxaan isku xirnaa beeralayda iyo alaab-qeybiyeyaasha la xaqiijiyay iyo iibsadayaasha dhabta ah (maqaayadaha, hoteelada, dukaamada waaweyn, kuwa wax kariya, hay\'adaha, iyo qoysaska).'
      : 'BaadiGoob AgroLink is a produce marketplace built to strengthen Somali market systems, especially by improving market access and income for women farmers. We connect verified farmers and suppliers with serious buyers (restaurants, hotels, supermarkets, caterers, institutions, and families).';
  String get aboutDescription2 => languageCode == 'so'
      ? 'Kooxdayada hawlgalku waxay taageeraan dhammaan habka dalbashada, laga bilaabo xaqiijinta helitaanka iyo qiimaha ilaa isku-dubbaridka isu-ururinta iyo keenista, si ganacsigu u noqdo mid abaabulan, hufan, oo la isku halleyn karo.'
      : 'Our operations team supports the full ordering process, from confirming availability and pricing to coordinating aggregation and delivery, so trade becomes more organised, transparent, and reliable.';
  String get ourMission => languageCode == 'so' ? 'Hadafkayaga' : 'Our Mission';
  String get missionDescription => languageCode == 'so'
      ? 'In la ballaadhiyo helitaanka suuqa ee beeralayda haweenka ah, la yareeyo qashinka, lana kordhiyo dakhliga iyada oo loo maro suuq wax soo saar oo la aamini karo oo tiknoolajiyadu awood u siisay.'
      : 'To expand market access for women farmers, reduce waste, and increase incomes through a trusted, tech-enabled produce marketplace.';
  String get coreValues => languageCode == 'so' ? 'Qiimayaasha Muhiimka ah' : 'Core Values';
  String get trust => languageCode == 'so' ? 'Aamin' : 'Trust';
  String get coordination => languageCode == 'so' ? 'Isku-dubbaridka' : 'Coordination';
  String get fairTrade => languageCode == 'so' ? 'Ganacsi Cadaalad ah' : 'Fair Trade';
  String get reliability => languageCode == 'so' ? 'Isku-halaynta' : 'Reliability';
  String get womenEmpowerment => languageCode == 'so' ? 'Awoodsiinta Dhaqaale ee Haweenka' : 'Women’s Economic Empowerment';
  String get localGrowth => languageCode == 'so' ? 'Kicinta Maxalliga ah' : 'Local Growth';
  String get readyToPartnerLong => languageCode == 'so' ? 'Ma diyaar u tahay inaad nala shaqeyso?' : 'Ready to partner with us?';
  
  // Additional common strings
  String get language => languageCode == 'so' ? 'Afka' : 'Language';
  String get english => languageCode == 'so' ? 'Ingiriisi' : 'English';
  String get somali => languageCode == 'so' ? 'Soomaali' : 'Somali';
  String get changeLanguage => languageCode == 'so' ? 'Bedel Afka' : 'Change Language';
  String get switchRole => languageCode == 'so' ? 'Dooro Doorka' : 'Switch Role';
  String get version => languageCode == 'so' ? 'Heerka' : 'Version';
  String get user => languageCode == 'so' ? 'Isticmaalaha' : 'User';

  // Roles
  String get roleBuyer => languageCode == 'so' ? 'Iibsadaha' : 'Buyer';
  String get roleSeller => languageCode == 'so' ? 'Iibiyaha' : 'Seller';
  String get roleDriver => languageCode == 'so' ? 'Darawalka' : 'Driver';
  String get roleAdmin => languageCode == 'so' ? 'Maamulaha' : 'Admin';
  String get roleOps => languageCode == 'so' ? 'Wakiilka' : 'Ops / Agent';
  String get roleFinance => languageCode == 'so' ? 'Maaliyadda' : 'Finance';
  String get roleHub => languageCode == 'so' ? 'Xarunta' : 'Hub Staff';
  String get rolePartner => languageCode == 'so' ? 'Shuraakada' : 'Partner';
  String get roleExpert => languageCode == 'so' ? 'Khabiir' : 'Expert';
  String get roleChoose => languageCode == 'so' ? 'Dooro Doorka' : 'Choose a Role';

  // Drawer labels
  String get marketPricesTitle => languageCode == 'so' ? 'Qiimaha Suuqa' : 'Market Prices';
  String get addProduce => languageCode == 'so' ? 'Ku dar Wax-soo-saarka' : 'Add Produce';
  String get myListings => languageCode == 'so' ? 'Liiska Iibka' : 'My Listings';
  String get orders => languageCode == 'so' ? 'Dalabaadka' : 'Orders';
  String get weatherTitle => languageCode == 'so' ? 'Cimilada' : 'Weather';
  String get communityTitle => languageCode == 'so' ? 'Bulshada' : 'Community';
  String get support => languageCode == 'so' ? 'Taageero' : 'Support';
  String get dashboard => languageCode == 'so' ? 'Dashboard' : 'Dashboard';
  String get farmers => languageCode == 'so' ? 'Beeralayda' : 'Farmers';
  String get logistics => languageCode == 'so' ? 'Saadka' : 'Logistics';
  String get issues => languageCode == 'so' ? 'Arrimaha' : 'Issues';
  String get reports => languageCode == 'so' ? 'Warbixinno' : 'Reports';
  String get myTrips => languageCode == 'so' ? 'Safarradayda' : 'My Trips';
  String get pickups => languageCode == 'so' ? 'Qaadista' : 'Pickups';
  String get deliveries => languageCode == 'so' ? 'Gawaarida' : 'Deliveries';
  String get pod => languageCode == 'so' ? 'Caddaynta Gaarsiinta' : 'Proof of Delivery';
  String get earnings => languageCode == 'so' ? 'Dakhliga' : 'Earnings';
  String get usersRoles => languageCode == 'so' ? 'Isticmaalayaasha & Doorka' : 'Users & Roles';
  String get contentCommunity => languageCode == 'so' ? 'Mawduuca/Bulshada' : 'Content/Community';
  String get payments => languageCode == 'so' ? 'Lacag-bixinta' : 'Payments';
  String get disputes => languageCode == 'so' ? 'Khilaafaadka' : 'Disputes';
  String get settings => languageCode == 'so' ? 'Dejinta' : 'Settings';
  String get invoices => languageCode == 'so' ? 'Invoisyada' : 'Invoices';
  String get buyerPayments => languageCode == 'so' ? 'Lacagaha Iibsadaha' : 'Buyer Payments';
  String get sellerPayouts => languageCode == 'so' ? 'Lacagaha Iibiyaha' : 'Seller Payouts';
  String get feesCommission => languageCode == 'so' ? 'Kharashka/Dhaqaalaha' : 'Fees/Commission';
  String get refunds => languageCode == 'so' ? 'Lacag Celin' : 'Refunds';
  String get incomingPickups => languageCode == 'so' ? 'Qaadista Soo Socota' : 'Incoming Pickups';
  String get sortingPackaging => languageCode == 'so' ? 'Kala-Saarista/Qaadista' : 'Sorting/Packaging';
  String get stockLoads => languageCode == 'so' ? 'Kaydka/Boostada' : 'Stock/Loads';
  String get dispatch => languageCode == 'so' ? 'Dirista' : 'Dispatch';
  String get impact => languageCode == 'so' ? 'Saameynta' : 'Impact';
  String get regions => languageCode == 'so' ? 'Gobollada' : 'Regions';
  String get sales => languageCode == 'so' ? 'Iibka' : 'Sales';
  String get downloads => languageCode == 'so' ? 'Soo-dejinta' : 'Downloads';
  String get questions => languageCode == 'so' ? 'Su\'aalaha' : 'Questions';
  String get postAdvisory => languageCode == 'so' ? 'La-talin Ku qaado' : 'Post Advisory';
  String get weatherAlerts => languageCode == 'so' ? 'Digniino Cimilada' : 'Weather Alerts';
  String get messages => languageCode == 'so' ? 'Farriimaha' : 'Messages';
  String get forgotPassword => languageCode == 'so' ? 'Ma ilaaway furaha sirta ah?' : 'Forgot Password?';
  String get forgotPasswordSoon => languageCode == 'so' ? 'Habka furaha sirta ah ee la ilaaway wuxuu imaanayaa dhowaan' : 'Forgot password feature coming soon';
  String get dontHaveAccount => languageCode == 'so' ? 'Miyaadan lahayn akoon? ' : "Don't have an account? ";
  String get registerLink => languageCode == 'so' ? 'Is diwaangeli' : 'Register';
  String get welcomeBackUser => languageCode == 'so' ? 'Ku soo dhawaada mar kale' : 'Welcome back';
  String get welcomeUser => languageCode == 'so' ? 'Ku soo dhawaada' : 'Welcome';
  String get loginTitle => languageCode == 'so' ? 'Gali' : 'Login';
  String get welcomeBack => languageCode == 'so' ? 'Ku soo dhawaada' : 'Welcome Back';
  String get signInToContinue => languageCode == 'so' ? 'Gal si aad u sii wadato' : 'Sign in to continue';
  String get emailLabel => languageCode == 'so' ? 'Iimayl' : 'Email';
  String get emailHint => languageCode == 'so' ? 'your@email.com' : 'your@email.com';
  String get emailError => languageCode == 'so' ? 'Fadlan geli iimaylkaaga' : 'Please enter your email';
  String get emailInvalid => languageCode == 'so' ? 'Fadlan geli iimayl sax ah' : 'Please enter a valid email';
  String get passwordLabel => languageCode == 'so' ? 'Furaha sirta ah' : 'Password';
  String get passwordError => languageCode == 'so' ? 'Fadlan geli furahaaga sirta ah' : 'Please enter your password';
  String get passwordTooShort => languageCode == 'so' ? 'Furaha sirta ah waa inuu ahaadaa ugu yaraan 6 xaraf' : 'Password must be at least 6 characters';
  String get createAccount => languageCode == 'so' ? 'Abuur akoonkaaga' : 'Create your account';
  String get joinAs => languageCode == 'so' ? 'Ku biir sida' : 'Join as a';
  String get firstName => languageCode == 'so' ? 'Magaca hore' : 'First Name';
  String get lastName => languageCode == 'so' ? 'Magaca dambe' : 'Last Name';
  String get phoneNumber => languageCode == 'so' ? 'Lambarka Taleefanka' : 'Phone Number';
  String get confirmPassword => languageCode == 'so' ? 'Xaqiiji furaha sirta ah' : 'Confirm Password';
  String get passwordsDoNotMatch => languageCode == 'so' ? 'Furayaasha sirta ah ma isku mid ah' : 'Passwords do not match';
  String get createAccountBtn => languageCode == 'so' ? 'Abuur Akoon' : 'Create Account';
  String get termsText => languageCode == 'so' 
    ? 'Markaad abuurto akoon, waxaad ogolaatay Shuruudaha Adeegga iyo Siyaasadda Khaaska ah.' 
    : 'By creating an account, you agree to our Terms of Service and Privacy Policy.';
  String get alreadyHaveAccount => languageCode == 'so' ? 'Ma leedahay akoon hore? ' : 'Already have an account? ';

  // Role Selection
  String get joinMarketplace => languageCode == 'so' ? 'Ku biir Suuqa' : 'Join the Marketplace';
  String get roleSelectionSubtitle => languageCode == 'so' 
    ? 'Isku xidhka beeralayda haweenka Soomaaliyeed ee la xaqiijiyay iyo iibsadayaasha dhabta ah.' 
    : 'Connecting verified Somali female farmers directly to bulk buyers.';
  String get sellersLabel => languageCode == 'so' ? 'Iibiyayaasha' : 'Sellers';
  String get sellersSubtitle => languageCode == 'so' ? 'Hel iibsadayaal joogto ah iyo iibsi degdeg ah.' : 'Get consistent buyers and faster sales.';
  String get becomeSeller => languageCode == 'so' ? 'Noqo Iibiye' : 'Become a Seller';
  String get buyersLabel => languageCode == 'so' ? 'Iibsadayaasha' : 'Buyers';
  String get buyersSubtitle => languageCode == 'so' ? 'U dalbo si ka caqli badan, hoos u dhig yaraanta.' : 'Order smarter, reduce shortages.';
  String get registerAsBuyer => languageCode == 'so' ? 'Iska diwaangeli iibsade ahaan' : 'Register as a Buyer';
  String get transportersLabel => languageCode == 'so' ? 'Gaadiidleyda' : 'Transporters';
  String get transportersSubtitle => languageCode == 'so' ? 'Hel hawlaha keenista oo hel lacag safarkiiba.' : 'Receive delivery assignments and earn per trip.';
  String get registerAsDriver => languageCode == 'so' ? 'Iska diwaangeli darawal ahaan' : 'Register as Driver';
  String get fullNameLabel => languageCode == 'so' ? 'Magaca oo buuxa' : 'Full Name';
  String get enterFirstName => languageCode == 'so' ? 'Fadlan geli magacaaga hore' : 'Please enter your first name';
  String get enterLastName => languageCode == 'so' ? 'Fadlan geli magacaaga dambe' : 'Please enter your last name';
  String get enterPhoneNumber => languageCode == 'so' ? 'Fadlan geli lambarkaaga taleefanka' : 'Please enter your phone number';
  String get readOurGuide => languageCode == 'so' ? 'Sidee ayay u shaqaysaa? Akhri Hagahayaga' : 'How it works? Read our Guide';
  String get placeholderText => languageCode == 'so' 
    ? 'Kani waa bog ku meel gaadh ah. Noo fuli bogga dhabta ah markaad diyaar tahay.' 
    : 'This is a placeholder page. Implement the real screen here when ready.';
  String get underConstruction => languageCode == 'so' 
    ? 'Muuqaalkan hadda waa lagu guda jiraa dhismaha.\nDib u soo hubi cusboonaysiinta mustaqbalka.' 
    : 'This view is currently under construction.\nCheck back in a future update.';

  // Profile
  String get accountSettings => languageCode == 'so' ? 'Habaynta Akoonka' : 'Account Settings';
  String get languagePreferences => languageCode == 'so' ? 'Xulashada Luuqadda' : 'Language Preferences';
  String get privacySecurity => languageCode == 'so' ? 'Khaaska ah & Amniga' : 'Privacy & Security';

  // How It Works
  String get howItWorksFooter => languageCode == 'so' ? 'Dalbasho sahlan. Fulinta la isku dubariday. Keenista la isku halayn karo.' : 'Simple ordering. Coordinated fulfilment. Reliable delivery.';
  String get howItWorksForBuyers => languageCode == 'so' ? 'Iibsadayaasha' : 'For Buyers';
  String get buyerStep1Title => languageCode == 'so' ? 'Iibso ama Codso Qiime' : 'Shop or Request a Quote';
  String get buyerStep1Desc => languageCode == 'so' ? 'Dooro alaabta ama u dir RFQ mug weyn iyo hawlo soo noqnoqda.' : 'Choose products or send an RFQ for bulk volumes and repeat routines.';
  String get buyerStep2Title => languageCode == 'so' ? 'Xaqiijinta Amarka' : 'Order Confirmation';
  String get buyerStep2Desc => languageCode == 'so' ? 'Waxaan xaqiijineynaa helitaanka, darajada, tirada, iyo daaqada keenista ka hor intaanan dirin.' : 'We confirm availability, grade, quantity, and delivery window before dispatch.';
  String get buyerStep3Title => languageCode == 'so' ? 'Isku-dubaridka Isku-darka & Baakaynta' : 'Aggregation & Packing Coordination';
  String get buyerStep3Desc => languageCode == 'so' ? 'Kooxdayadu waxay isku dubaridaan ururinta iyo baakaynta si loo yareeyo khasaaraha iyo dib dhaca.' : 'Our team coordinates aggregation and packing to reduce spoilage and delays.';
  String get buyerStep4Title => languageCode == 'so' ? 'Keenista & Cadaynta Keenista' : 'Delivery & Proof of Delivery';
  String get buyerStep4Desc => languageCode == 'so' ? 'Hel cusboonaysiinta iyo xaqiijinta marka amarku la keeno.' : 'Receive updates and confirmation when the order is delivered.';
  String get howItWorksForSellers => languageCode == 'so' ? 'Iibiyayaasha' : 'For Sellers';
  String get sellerStep1Title => languageCode == 'so' ? 'Is diwaangeli oo la wadaag agabkaaga' : 'Register & Share Your Supply';
  String get sellerStep1Desc => languageCode == 'so' ? 'Alaabta, goobta, mugga, iyo jadwalka helitaanka.' : 'Products, location, volume, and availability schedule.';
  String get sellerStep2Title => languageCode == 'so' ? 'Xaqiijinta & Is-diiwaangelinta' : 'Verification & Onboarding';
  String get sellerStep2Desc => languageCode == 'so' ? 'Waxaan xaqiijineynaa faahfaahinta si loo dhiso kalsoonida iibsadaha.' : 'We verify details to build buyer trust.';
  String get sellerStep3Title => languageCode == 'so' ? 'Helitaanka Dalabaadka' : 'Receive Orders';
  String get sellerStep3Desc => languageCode == 'so' ? 'Tira cad, waqti cayiman, iyo tilmaamaha fulinta.' : 'Clear quantities, timing, and fulfilment instructions.';
  String get sellerStep4Title => languageCode == 'so' ? 'Ku kor si joogto ah' : 'Grow with Consistency';
  String get sellerStep4Desc => languageCode == 'so' ? 'Waxqabadka lagu kalsoonaan karo wuxuu kordhiyaa kalsoonida iibsadaha iyo dalabyada soo noqnoqda.' : 'Reliable performance increases buyer confidence and repeat orders.';
  String get whatBaadiGoobCoordinates => languageCode == 'so' ? 'Waxa BaadiGoob Isku Dubarida' : 'What BaadiGoob Coordinates';
  String get orderConfirmation => languageCode == 'so' ? 'Xaqiijinta amarka' : 'Order confirmation';
  String get aggregationPlanning => languageCode == 'so' ? 'Qorshaynta isku-darka' : 'Aggregation planning';
  String get packingCoordination => languageCode == 'so' ? 'Isku-dubbaridka baakaynta' : 'Packing coordination';
  String get deliveryScheduling => languageCode == 'so' ? 'Jadwalka keenista' : 'Delivery scheduling';
  String get customerSupport => languageCode == 'so' ? 'Taageerada macaamiisha' : 'Customer support';

  // FAQ
  String get faqTitle => languageCode == 'so' ? 'Su\'aalaha badanaa la is weydiiyo' : 'FAQ';
  String get faqQ1 => languageCode == 'so' ? 'BaadiGoob AgroLink ma shirkad keenis baa?' : 'Is BaadiGoob AgroLink a delivery company?';
  String get faqA1 => languageCode == 'so' ? 'Waxaan nahay suuq isku dubarida ururinta iyo keenista iyada oo loo marayo kooxdayada hawlgallada iyo la-hawlgalayaasha.' : 'We are a marketplace that coordinates aggregation and delivery through our operations team and partners.';
  String get faqQ2 => languageCode == 'so' ? 'Ma iibsan karaa tiro yar?' : 'Can I buy small quantities?';
  String get faqA2 => languageCode == 'so' ? 'Waxaan diirada saarnaa dalabaadka badan iyo kuwa ganacsiga. Dalabka ugu yar wuu ku kala duwan yahay alaabta.' : 'We focus on bulk and business orders. Minimum order varies by product.';
  String get faqQ3 => languageCode == 'so' ? 'Sidee qiimuhu u shaqeeyaa?' : 'How do prices work?';
  String get faqA3 => languageCode == 'so' ? 'Qiimuhu way isbedeli karaan iyadoo ku xidhan xilliga iyo agabka la hayo. Dalabkaaga waxa la xaqiijinayaa ka hor intaanan dirin.' : 'Prices can change based on season and supply. Your order is confirmed before dispatch.';
  String get faqQ4 => languageCode == 'so' ? 'Sideen u codsadaa qiimeyn guud (RFQ)?' : 'How do I request a bulk quote (RFQ)?';
  String get faqA4 => languageCode == 'so' ? 'Isticmaal "Codso Qiimeyn," la wadaag alaabta, tirada, goobta keensashada, iyo taariikhda la door bidayo—kooxdayadu waxay kuugu soo jawaabaan xulashooyin.' : 'Use “Request a Quote,” share product, quantity, delivery location, and preferred date—our team will respond with options.';
  String get faqQ5 => languageCode == 'so' ? 'Sideen ku noqdaa iibiye?' : 'How do I become a seller?';
  String get faqA5 => languageCode == 'so' ? 'Is diwaangeli, la wadaag alaabtaada iyo goobtaada, kooxdayaduna way ku xaqiijin doonaan oo kugu hagi doonaan liiska. Xusuusnow goobtani waa beeralayda haweenka.' : 'Register, share your products and location, and our team will verify and guide you through listing. Remember this platform is women farmers.';
  String get faqQ6 => languageCode == 'so' ? 'Waa maxay hababka lacag bixinta ee la taageero?' : 'What payment methods are supported?';
  String get faqA6 => languageCode == 'so' ? 'Xulashooyinku waxay ku xidhan yihiin goobta iyo nooca dalabka. Waxaad arki doontaa hababka jira marka aad lacag bixinayso ama inta lagu jiro xaqiijinta.' : 'Options depend on location and order type. You’ll see available methods at checkout or during confirmation.';
  String get faqQ7 => languageCode == 'so' ? 'Sideen ula socdaa dalabkayga?' : 'How do I track my order?';
  String get faqA7 => languageCode == 'so' ? 'Waxaad helaysaa cusboonaysiinta heerka laga bilaabo xaqiijinta ilaa keenista.' : 'You receive status updates from confirmation to delivery.';

  // Shopping & Listing
  String get shopProduce => languageCode == 'so' ? 'Iibso Dalagga' : 'Shop Produce';
  String get browseFreshProduce => languageCode == 'so' ? 'Baadh Dalagga Cusub' : 'Browse Fresh Produce';
  String get browseProduceDesc => languageCode == 'so' ? 'Ka baadh dalagga cusub alaab-qeybiyeyaasha la xaqiijiyay. Qiimaha iyo helitaanka way isbedeli karaan maalin kasta—dalbo si aad u xaqiijiso alaabta iyo jadwalka keenista.' : 'Browse fresh produce from verified suppliers. Prices and availability may change daily—place your order to confirm stock and delivery schedule.';
  String get searchProducts => languageCode == 'so' ? 'Raadi alaabta...' : 'Search products...';
  String get featuredCategories => languageCode == 'so' ? 'Qaybaha la xushay' : 'Featured Categories';
  String get freshArrivals => languageCode == 'so' ? 'Isku-dubarid Cusub' : 'Fresh Arrivals';
  String get categoryVegetables => languageCode == 'so' ? 'Khudaarta' : 'Vegetables';
  String get categoryFruits => languageCode == 'so' ? 'Miraha' : 'Fruits';
  String get categoryGrains => languageCode == 'so' ? 'Macaamiisha' : 'Grains';
  String get categoryHerbs => languageCode == 'so' ? 'Dhirta' : 'Herbs';
  String get addToCart => languageCode == 'so' ? 'Ku dar gaadhiga' : 'Add to Cart';
  String get inStock => languageCode == 'so' ? 'Wuu yaalaa' : 'In Stock';
  String get limited => languageCode == 'so' ? 'Wuu xadidan yahay' : 'Limited';
  String get finalConfirmationNote => languageCode == 'so' ? 'Fiiro gaar ah: Xaqiijinta u dambaysa (helitaanka, qiimaha, iyo wakhtiga keenista) waxa la dhamaystiraa ka hor intaan la dirin.' : 'Note: Final confirmation (availability, price, and delivery window) is completed before dispatch.';
  String get addProduce => languageCode == 'so' ? 'Ku dar Dalagga' : 'Add Produce';
  String get addProduceDesc => languageCode == 'so' ? 'Abuur liis alaab cusub si iibsadayaashu u helaan dalaggaaga.' : 'Create a new product listing so buyers can find your produce.';
  String get productName => languageCode == 'so' ? 'Magaca Alaabta' : 'Product Name';
  String get enterName => languageCode == 'so' ? 'Fadlan geli magaca alaabta' : 'Please enter a product name';
  String get descriptionOptional => languageCode == 'so' ? 'Faahfaahin (ikhtiyaari)' : 'Description (optional)';
  String get pricePerUnit => languageCode == 'so' ? 'Qiimaha unugtiiba' : 'Price per unit';
  String get availableQty => languageCode == 'so' ? 'Tirada la heli karo' : 'Available qty';
  String get minOrder => languageCode == 'so' ? 'Dalabka ugu yar' : 'Min order';
  String get gradePlaceholder => languageCode == 'so' ? 'Darajada (A/B/C)' : 'Grade (A/B/C)';
  String get regionHint => languageCode == 'so' ? 'tusaale, Banaadir' : 'e.g., Banaadir';
  String get productCreatedSuccess => languageCode == 'so' ? 'Alaabta si guul leh ayaa loo abuuray!' : 'Product created successfully!';
  String get createListing => languageCode == 'so' ? 'Abuur Liiska' : 'Create Listing';
  String get sellerLoginError => languageCode == 'so' ? 'Fadlan u gal sidii iibiye si aad ugu darto alaabta.' : 'Please log in as a seller to add products.';
  String get enterPrice => languageCode == 'so' ? 'Geli qiimaha' : 'Enter price';
  String get enterValidNumber => languageCode == 'so' ? 'Geli lambar sax ah' : 'Enter a valid number';
  String get enterQuantity => languageCode == 'so' ? 'Geli tirada' : 'Enter quantity';
  String get enterMinOrder => languageCode == 'so' ? 'Geli tirada ugu yar ee dalabka' : 'Enter min order qty';
  String get gradeLabel => languageCode == 'so' ? 'Darajada' : 'Grade';

  // Orders & Status
  String get myOrders => languageCode == 'so' ? 'Dalabaadkayga' : 'My Orders';
  String get orderHash => languageCode == 'so' ? 'Dalabka #' : 'Order #';
  String get totalAmount => languageCode == 'so' ? 'Warta Guud' : 'Total';
  String get dateLabel => languageCode == 'so' ? 'Taariikhda' : 'Date';
  String get statusCompleted => languageCode == 'so' ? 'Dhamaystiran' : 'Completed';
  String get statusDelivered => languageCode == 'so' ? 'La keenay' : 'Delivered';
  String get statusPending => languageCode == 'so' ? 'Sugid' : 'Pending';
  String get statusProcessing => languageCode == 'so' ? 'Habaynta' : 'Processing';
  String get statusInTransit => languageCode == 'so' ? 'Waddada' : 'In Transit';
  // Products
  String get productTomatoes => languageCode == 'so' ? 'Yaanyada' : 'Tomatoes';
  String get productMangoes => languageCode == 'so' ? 'Canbaha' : 'Mangoes';
  String get productPotatoes => languageCode == 'so' ? 'Baradhada' : 'Potatoes';
  String get productWatermelon => languageCode == 'so' ? 'Xabxabka' : 'Watermelon';
  String get productLemonLime => languageCode == 'so' ? 'Liinta' : 'Lemon/Lime';
  String get productBanana => languageCode == 'so' ? 'Mooska' : 'Banana';

  // Product Management
  String get deleteProduct => languageCode == 'so' ? 'Tirtir Alaabta' : 'Delete Product';
  String get deleteProductConfirm => languageCode == 'so' ? 'Ma hubtaa inaad rabto inaad tirtirto alaabtan? Ficilkan laguma soo celin karo.' : 'Are you sure you want to delete this product? This action cannot be undone.';
  String get delete => languageCode == 'so' ? 'Tirtir' : 'Delete';
  String get cancel => languageCode == 'so' ? 'Ka noqo' : 'Cancel';
  String get productDeletedSuccess => languageCode == 'so' ? 'Alaabta si guul leh ayaa loo tirtiray' : 'Product deleted successfully';
  String get noProductsYet => languageCode == 'so' ? 'Weli wax alaab ah ma jiraan' : 'No products yet';
  String get startSellingDesc => languageCode == 'so' ? 'Ku bilow iibinta adigoo ku daraya alaabtaada ugu horreysa!' : 'Start selling by adding your first product!';
  String get editProduct => languageCode == 'so' ? 'Wax ka badal Alaabta' : 'Edit Product';
  String get saveChanges => languageCode == 'so' ? 'Keydi Isbedelada' : 'Save Changes';
  String get requiredField => languageCode == 'so' ? 'Loo baahan yahay' : 'Required';

  // Logistics / Deliveries
  String get myDeliveries => languageCode == 'so' ? 'Gaadiidkayga' : 'My Deliveries';
  String get tabPending => languageCode == 'so' ? 'Sugaya' : 'Pending';
  String get tabActive => languageCode == 'so' ? 'Hadda socda' : 'Active';
  String get tabCompleted => languageCode == 'so' ? 'Dhammaaday' : 'Completed';
  String get decline => languageCode == 'so' ? 'Diid' : 'Decline';
  String get accept => languageCode == 'so' ? 'Oggolow' : 'Accept';
  String get markPickedUp => languageCode == 'so' ? 'Calaamadee in la soo qaaday' : 'Mark Picked Up';
  String get markDelivered => languageCode == 'so' ? 'Calaamadee in la geeyey' : 'Mark Delivered';
  String get proofOfDeliverySubmitted => languageCode == 'so' ? 'Caddaynta dhalmada waa la gudbiyey' : 'Proof of delivery submitted';
  String get viewProof => languageCode == 'so' ? 'Fiiri Caddaynta' : 'View Proof';
  String get pickupLabel => languageCode == 'so' ? 'Goobta laga soo qaadayo' : 'Pickup';
  String get deliveryLabel => languageCode == 'so' ? 'Goobta la gaynayo' : 'Delivery';
  String get noPendingDeliveries => languageCode == 'so' ? 'Ma jiraan gaadiid sugaya' : 'No pending deliveries';
  String get noActiveDeliveries => languageCode == 'so' ? 'Ma jiraan gaadiid hadda socda' : 'No active deliveries';
  String get noCompletedDeliveries => languageCode == 'so' ? 'Ma jiraan gaadiid dhammaaday' : 'No completed deliveries';
  String get deliveryStatusUpdated => languageCode == 'so' ? 'Xaaladda gaadiidka waa la cusboonaysiiyey' : 'Delivery status updated';

  // Filters
  String get filterCategory => languageCode == 'so' ? 'Qaybta' : 'Category';
  String get filterLocation => languageCode == 'so' ? 'Goobta' : 'Location';
  String get filterPrice => languageCode == 'so' ? 'Qiimaha' : 'Price';
  String get filterAvailability => languageCode == 'so' ? 'Helitaanka' : 'Availability';
