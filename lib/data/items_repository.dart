import 'package:flutter/material.dart';

class ItemsRepository {
  // Category specific filter pills
  static List<String> getFiltersForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'books':
        return ['All', 'Textbooks', 'Novels', 'Comics', 'Academic'];
      case 'clothes':
        return ['All', 'Men', 'Women', 'Kids', 'Jackets'];
      case 'electronics':
        return ['All', 'Audio', 'Computers', 'Accessories', 'Gadgets'];
      case 'home & living':
      case 'home':
        return ['All', 'Furniture', 'Decor', 'Kitchen', 'Lighting'];
      case 'sports & fitness':
      case 'sports':
        return ['All', 'Gym', 'Outdoor', 'Ball Games', 'Yoga'];
      case 'accessories':
        return ['All', 'Bags', 'Watches', 'Eyewear', 'Wallets'];
      case 'beauty & health':
      case 'beauty':
        return ['All', 'Skincare', 'Haircare', 'Wellness', 'Tools'];
      case 'others':
      default:
        return ['All', 'Stationery', 'Board Games', 'Art', 'Musical'];
    }
  }

  // All catalog items organized with proper category and tags
  static final List<Map<String, dynamic>> allCatalogItems = [
    // ==========================================
    // 📚 BOOKS
    // ==========================================
    {
      'id': 'b1',
      'name': 'Calculus & Analytic Geometry',
      'price': 'Rs. 600',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '1.0 km away',
      'category': 'Books',
      'tag': 'Textbooks',
      'image': 'assets/images/textbook.jpg',
      'saved': true,
      'description':
          'Thomas Calculus 11th Edition. Clean pages with no highlighter marks or pen scribbles. Essential for university engineering and math courses.',
      'sellerName': 'Ali Raza',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'b2',
      'name': 'To Kill a Mockingbird (Novel)',
      'price': 'Rs. 450',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.3 km away',
      'category': 'Books',
      'tag': 'Novels',
      'icon': Icons.menu_book_rounded,
      'iconColor': const Color(0xFF1B5E20),
      'iconBg': const Color(0xFFE8F5E9),
      'saved': false,
      'description':
          'Classic Harper Lee masterpiece. Paperback edition in excellent readable condition, spine intact with gently turned pages.',
      'sellerName': 'Ayesha Tariq',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'b3',
      'name': 'Halliday & Resnick Physics Vol 1',
      'price': 'Rs. 850',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '3.1 km away',
      'category': 'Books',
      'tag': 'Textbooks',
      'icon': Icons.auto_stories_rounded,
      'iconColor': const Color(0xFF0D47A1),
      'iconBg': const Color(0xFFE3F2FD),
      'saved': false,
      'description':
          'Comprehensive fundamentals of physics textbook. Hardcover edition, perfect for engineering entrance exams and university prep.',
      'sellerName': 'Zubair Ahmed',
      'sellerJoinDate': 'Member since 2022',
    },
    {
      'id': 'b4',
      'name': 'Spider-Man Marvel Comic Vol 1',
      'price': 'Rs. 350',
      'condition': 'Fair condition',
      'isGood': false,
      'distance': '4.0 km away',
      'category': 'Books',
      'tag': 'Comics',
      'icon': Icons.import_contacts_rounded,
      'iconColor': const Color(0xFFB71C1C),
      'iconBg': const Color(0xFFFFEBEE),
      'saved': false,
      'description':
          'Collector edition vintage comic book. Vibrant color print with minor crease on the front cover. Great for comic enthusiasts.',
      'sellerName': 'Bilal Khan',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'b5',
      'name': 'Introduction to Algorithms (CLRS)',
      'price': 'Rs. 1,100',
      'condition': 'Like New',
      'isGood': true,
      'distance': '1.8 km away',
      'category': 'Books',
      'tag': 'Academic',
      'icon': Icons.book_rounded,
      'iconColor': const Color(0xFF4A148C),
      'iconBg': const Color(0xFFF3E5F5),
      'saved': false,
      'description':
          'Third edition Algorithms textbook by Cormen, Leiserson, Rivest. Barely used, crisp white pages, no torn corners.',
      'sellerName': 'Usman Farooq',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'b6',
      'name': 'Atomic Habits (James Clear)',
      'price': 'Rs. 500',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.0 km away',
      'category': 'Books',
      'tag': 'Novels',
      'icon': Icons.menu_book_rounded,
      'iconColor': const Color(0xFFE65100),
      'iconBg': const Color(0xFFFFF3E0),
      'saved': false,
      'description':
          'Life-changing personal development book. Read once and kept carefully on bookshelf. Clean binding.',
      'sellerName': 'Sara Ahmed',
      'sellerJoinDate': 'Member since 2024',
    },

    // ==========================================
    // 👕 CLOTHES
    // ==========================================
    {
      'id': 'c1',
      'name': 'Dark Navy Winter Jacket',
      'price': 'Rs. 1,500',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.0 km away',
      'category': 'Clothes',
      'tag': 'Jackets',
      'image': 'assets/images/winter_jacket.jpg',
      'saved': true,
      'description':
          'Warm and stylish dark navy winter jacket. Water-resistant, hooded with multiple deep pockets. Perfect for chilly weather.',
      'sellerName': 'Usman Tariq',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'c2',
      'name': 'Fleece Sweatshirt (Red)',
      'price': 'Rs. 800',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '3.2 km away',
      'category': 'Clothes',
      'tag': 'Men',
      'icon': Icons.checkroom_rounded,
      'iconColor': const Color(0xFFC62828),
      'iconBg': const Color(0xFFFFEBEE),
      'saved': false,
      'description':
          'Comfortable red fleece hoodie sweatshirt. Clean fabric, zero tears or stains, gently worn during last winter.',
      'sellerName': 'Hamza Ali',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'c3',
      'name': 'Slim Fit Denim Jeans (Size 32)',
      'price': 'Rs. 1,000',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '4.1 km away',
      'category': 'Clothes',
      'tag': 'Women',
      'icon': Icons.dry_cleaning_rounded,
      'iconColor': const Color(0xFF1565C0),
      'iconBg': const Color(0xFFE3F2FD),
      'saved': false,
      'description':
          'Classic blue denim jeans. Durable stretch cotton blend, straight fit, very clean wash and sturdy stitching.',
      'sellerName': 'Sara Ahmed',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'c4',
      'name': 'Cotton Graphic T-shirt (Black)',
      'price': 'Rs. 400',
      'condition': 'Fair condition',
      'isGood': false,
      'distance': '5.0 km away',
      'category': 'Clothes',
      'tag': 'Kids',
      'icon': Icons.dry_cleaning_rounded,
      'iconColor': const Color(0xFF37474F),
      'iconBg': const Color(0xFFECEFF1),
      'saved': false,
      'description':
          'Casual pure cotton black crewneck t-shirt. Breathable fabric, soft feel, great for everyday casual wear.',
      'sellerName': 'Zainab Bibi',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'c5',
      'name': 'Sky Blue Formal Shirt (Size M)',
      'price': 'Rs. 700',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '1.2 km away',
      'category': 'Clothes',
      'tag': 'Men',
      'icon': Icons.checkroom_rounded,
      'iconColor': const Color(0xFF0288D1),
      'iconBg': const Color(0xFFE1F5FE),
      'saved': false,
      'description':
          'Crisp cotton formal button-up shirt in light sky blue. Worn only twice for interviews. Freshly ironed.',
      'sellerName': 'Bilal Khan',
      'sellerJoinDate': 'Member since 2022',
    },

    // ==========================================
    // 🎧 ELECTRONICS
    // ==========================================
    {
      'id': 'e1',
      'name': 'Wireless Bluetooth Headphones',
      'price': 'Rs. 800',
      'condition': 'Fair condition',
      'isGood': false,
      'distance': '3.0 km away',
      'category': 'Electronics',
      'tag': 'Audio',
      'icon': Icons.headphones_rounded,
      'iconColor': const Color(0xFF6A1B9A),
      'iconBg': const Color(0xFFF3E5F5),
      'saved': false,
      'description':
          'Deep bass wireless on-ear headphones with 20-hour battery life. Crisp sound with working mic for phone calls.',
      'sellerName': 'Hamza Malik',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'e2',
      'name': 'RGB Mechanical Gaming Keyboard',
      'price': 'Rs. 1,800',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '1.5 km away',
      'category': 'Electronics',
      'tag': 'Computers',
      'icon': Icons.keyboard_rounded,
      'iconColor': const Color(0xFF1565C0),
      'iconBg': const Color(0xFFE3F2FD),
      'saved': false,
      'description':
          'Tactile blue clicky switches, all keys fully responsive with custom RGB backlight effects and braided USB cord.',
      'sellerName': 'Ahmed Noor',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'e3',
      'name': 'Portable Bluetooth Speaker',
      'price': 'Rs. 1,200',
      'condition': 'Like New',
      'isGood': true,
      'distance': '2.2 km away',
      'category': 'Electronics',
      'tag': 'Audio',
      'icon': Icons.speaker_rounded,
      'iconColor': const Color(0xFFE65100),
      'iconBg': const Color(0xFFFFF3E0),
      'saved': false,
      'description':
          'Waterproof compact portable speaker with rich 360-degree sound. 10hr battery, USB-C fast charging.',
      'sellerName': 'Daniyal Khan',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'e4',
      'name': 'Aluminum Laptop Riser Stand',
      'price': 'Rs. 650',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '4.2 km away',
      'category': 'Electronics',
      'tag': 'Accessories',
      'icon': Icons.laptop_chromebook_rounded,
      'iconColor': const Color(0xFF455A64),
      'iconBg': const Color(0xFFCFD8DC),
      'saved': false,
      'description':
          'Ergonomic foldable aluminum alloy laptop stand. Prevents overheating and improves posture during long study sessions.',
      'sellerName': 'Zainab Tariq',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'e5',
      'name': '7-in-1 USB-C Multiport Hub',
      'price': 'Rs. 950',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.8 km away',
      'category': 'Electronics',
      'tag': 'Gadgets',
      'icon': Icons.usb_rounded,
      'iconColor': const Color(0xFF00695C),
      'iconBg': const Color(0xFFE0F2F1),
      'saved': false,
      'description':
          'Includes 4K HDMI, 3 USB 3.0 high-speed ports, SD/TF card reader slots, and 100W PD charging pass-through.',
      'sellerName': 'Fahad Ali',
      'sellerJoinDate': 'Member since 2023',
    },

    // ==========================================
    // 🏡 HOME & LIVING
    // ==========================================
    {
      'id': 'h1',
      'name': 'Modern Desk Reading Lamp',
      'price': 'Rs. 750',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '1.5 km away',
      'category': 'Home & Living',
      'tag': 'Lighting',
      'icon': Icons.light_rounded,
      'iconColor': const Color(0xFFF57F17),
      'iconBg': const Color(0xFFFFFDE7),
      'saved': false,
      'description':
          'Touch-dimmable LED reading desk lamp with 3 color temperatures (warm, cool, neutral). USB rechargeable.',
      'sellerName': 'Maryam Asif',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'h2',
      'name': 'Minimalist Ceramic Flower Vase',
      'price': 'Rs. 500',
      'condition': 'Like New',
      'isGood': true,
      'distance': '2.5 km away',
      'category': 'Home & Living',
      'tag': 'Decor',
      'icon': Icons.yard_rounded,
      'iconColor': const Color(0xFF2E7D32),
      'iconBg': const Color(0xFFE8F5E9),
      'saved': false,
      'description':
          'Nordic aesthetic matte white ceramic flower vase. Flawless glaze, perfect for study desks or living room shelves.',
      'sellerName': 'Sadia Rehman',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'h3',
      'name': 'Wooden Study Desk Organizer',
      'price': 'Rs. 850',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '3.0 km away',
      'category': 'Home & Living',
      'tag': 'Furniture',
      'icon': Icons.inventory_rounded,
      'iconColor': const Color(0xFF5D4037),
      'iconBg': const Color(0xFFEFEBE9),
      'saved': false,
      'description':
          'Multiple slots for pens, notebooks, sticky pads, and mobile phone. Solid wood construction, very clean finish.',
      'sellerName': 'Tariq Mehmood',
      'sellerJoinDate': 'Member since 2022',
    },
    {
      'id': 'h4',
      'name': 'Cozy Fleece Throw Blanket',
      'price': 'Rs. 1,100',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.8 km away',
      'category': 'Home & Living',
      'tag': 'Decor',
      'icon': Icons.bed_rounded,
      'iconColor': const Color(0xFFC2185B),
      'iconBg': const Color(0xFFFCE4EC),
      'saved': false,
      'description':
          'Super soft, lightweight flannel fleece blanket in warm camel beige. Generous single size, fresh and washed.',
      'sellerName': 'Nida Fatima',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'h5',
      'name': 'Stainless Steel Coffee French Press',
      'price': 'Rs. 900',
      'condition': 'Like New',
      'isGood': true,
      'distance': '1.8 km away',
      'category': 'Home & Living',
      'tag': 'Kitchen',
      'icon': Icons.coffee_rounded,
      'iconColor': const Color(0xFF4E342E),
      'iconBg': const Color(0xFFD7CCC8),
      'saved': false,
      'description':
          'Heat-resistant borosilicate glass with stainless steel filter. Makes 600ml of smooth, aromatic fresh coffee.',
      'sellerName': 'Kamran Shah',
      'sellerJoinDate': 'Member since 2023',
    },

    // ==========================================
    // ⚽ SPORTS & FITNESS
    // ==========================================
    {
      'id': 's1',
      'name': 'Spalding Basketball (Size 7)',
      'price': 'Rs. 900',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.0 km away',
      'category': 'Sports & Fitness',
      'tag': 'Ball Games',
      'icon': Icons.sports_basketball_rounded,
      'iconColor': const Color(0xFFE65100),
      'iconBg': const Color(0xFFFFF3E0),
      'saved': false,
      'description':
          'Official size 7 composite leather basketball. Excellent pebbled grip, maintains air pressure reliably for indoor/outdoor play.',
      'sellerName': 'Ali Raza',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 's2',
      'name': 'Rubber Hex Dumbbells (5kg x 2)',
      'price': 'Rs. 2,200',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '3.5 km away',
      'category': 'Sports & Fitness',
      'tag': 'Gym',
      'icon': Icons.fitness_center_rounded,
      'iconColor': const Color(0xFF263238),
      'iconBg': const Color(0xFFECEFF1),
      'saved': false,
      'description':
          'Pair of 5kg solid cast iron dumbbells with rubber hex heads to prevent rolling and protect home floors. Knurled steel grip.',
      'sellerName': 'Waqas Ahmed',
      'sellerJoinDate': 'Member since 2022',
    },
    {
      'id': 's3',
      'name': 'Thick Non-Slip Yoga Mat with Strap',
      'price': 'Rs. 700',
      'condition': 'Like New',
      'isGood': true,
      'distance': '1.4 km away',
      'category': 'Sports & Fitness',
      'tag': 'Yoga',
      'icon': Icons.self_improvement_rounded,
      'iconColor': const Color(0xFF6A1B9A),
      'iconBg': const Color(0xFFF3E5F5),
      'saved': false,
      'description':
          '6mm high density cushioned workout mat in deep purple. Eco-friendly TPE material with textured double-sided grip.',
      'sellerName': 'Aiman Khan',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 's4',
      'name': 'Yonex Badminton Rackets (Pair)',
      'price': 'Rs. 1,100',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.1 km away',
      'category': 'Sports & Fitness',
      'tag': 'Outdoor',
      'icon': Icons.sports_tennis_rounded,
      'iconColor': const Color(0xFF1B5E20),
      'iconBg': const Color(0xFFE8F5E9),
      'saved': false,
      'description':
          'Lightweight aluminum badminton pair with durable strings and full zip carrying cover. Fresh grip tape applied.',
      'sellerName': 'Farhan Malik',
      'sellerJoinDate': 'Member since 2023',
    },

    // ==========================================
    // 🎒 ACCESSORIES
    // ==========================================
    {
      'id': 'a1',
      'name': 'Durable College Backpack',
      'price': 'Rs. 1,200',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '2.0 km away',
      'category': 'Accessories',
      'tag': 'Bags',
      'image': 'assets/images/backpack.jpg',
      'saved': true,
      'description':
          'Stylish, spacious water-resistant backpack. Padded laptop compartment fits up to 15.6 inch laptops. Used 6 months.',
      'sellerName': 'Ayesha Khan',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'a2',
      'name': 'Vintage Leather Cardholder Wallet',
      'price': 'Rs. 650',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '1.6 km away',
      'category': 'Accessories',
      'tag': 'Wallets',
      'icon': Icons.account_balance_wallet_rounded,
      'iconColor': const Color(0xFF4E342E),
      'iconBg': const Color(0xFFD7CCC8),
      'saved': false,
      'description':
          'Genuine distressed brown leather slim bifold cardholder. Fits 6 cards with middle cash pocket.',
      'sellerName': 'Usman Ali',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'a3',
      'name': 'Stainless Steel Classic Quartz Watch',
      'price': 'Rs. 2,000',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '3.2 km away',
      'category': 'Accessories',
      'tag': 'Watches',
      'icon': Icons.watch_rounded,
      'iconColor': const Color(0xFF263238),
      'iconBg': const Color(0xFFECEFF1),
      'saved': false,
      'description':
          'Elegant silver wristwatch with dark emerald green dial. Water resistant to 30m, new battery installed.',
      'sellerName': 'Salman Khan',
      'sellerJoinDate': 'Member since 2022',
    },
    {
      'id': 'a4',
      'name': 'Polarized UV400 Aviator Sunglasses',
      'price': 'Rs. 950',
      'condition': 'Like New',
      'isGood': true,
      'distance': '2.4 km away',
      'category': 'Accessories',
      'tag': 'Eyewear',
      'icon': Icons.visibility_rounded,
      'iconColor': const Color(0xFF00695C),
      'iconBg': const Color(0xFFE0F2F1),
      'saved': false,
      'description':
          'Matte black metal frame with scratch-resistant polarized lenses. Includes microfiber cloth and hard travel case.',
      'sellerName': 'Rehan Siddiqui',
      'sellerJoinDate': 'Member since 2023',
    },

    // ==========================================
    // 💄 BEAUTY & HEALTH
    // ==========================================
    {
      'id': 'bh1',
      'name': 'LED Touch Makeup Vanity Mirror',
      'price': 'Rs. 850',
      'condition': 'Like New',
      'isGood': true,
      'distance': '2.0 km away',
      'category': 'Beauty & Health',
      'tag': 'Tools',
      'icon': Icons.wb_incandescent_rounded,
      'iconColor': const Color(0xFFAD1457),
      'iconBg': const Color(0xFFFCE4EC),
      'saved': false,
      'description':
          'Tri-fold tabletop vanity mirror with 21 daylight LEDs. 1x, 2x, and 3x magnification panels for precision.',
      'sellerName': 'Zoya Malik',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'bh2',
      'name': 'Ultrasonic Aroma Essential Oil Diffuser',
      'price': 'Rs. 1,250',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '1.5 km away',
      'category': 'Beauty & Health',
      'tag': 'Wellness',
      'icon': Icons.spa_rounded,
      'iconColor': const Color(0xFF6A1B9A),
      'iconBg': const Color(0xFFF3E5F5),
      'saved': false,
      'description':
          'Quiet 300ml cool mist humidifier with 7 soothing ambient LED light colors and auto shut-off safety.',
      'sellerName': 'Maham Khan',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'bh3',
      'name': 'Ceramic Ionic Hair Straightener Brush',
      'price': 'Rs. 1,400',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '3.0 km away',
      'category': 'Beauty & Health',
      'tag': 'Haircare',
      'icon': Icons.brush_rounded,
      'iconColor': const Color(0xFFC2185B),
      'iconBg': const Color(0xFFFCE4EC),
      'saved': false,
      'description':
          'Fast heat-up anti-scald heated comb with digital temperature control. Smooths frizzy hair within minutes.',
      'sellerName': 'Fatima Noor',
      'sellerJoinDate': 'Member since 2023',
    },

    // ==========================================
    // 🎨 OTHERS
    // ==========================================
    {
      'id': 'o1',
      'name': 'Handcrafted Wooden Chess Set (12")',
      'price': 'Rs. 950',
      'condition': 'Like New',
      'isGood': true,
      'distance': '1.8 km away',
      'category': 'Others',
      'tag': 'Board Games',
      'icon': Icons.extension_rounded,
      'iconColor': const Color(0xFF4E342E),
      'iconBg': const Color(0xFFD7CCC8),
      'saved': false,
      'description':
          'Folding wooden chess board with magnetic pieces. Felted bottoms, internal slots for storing all pieces.',
      'sellerName': 'Hamza Sheikh',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'id': 'o2',
      'name': 'Artist Watercolor Paint Kit (24 Colors)',
      'price': 'Rs. 550',
      'condition': 'Fair condition',
      'isGood': false,
      'distance': '2.5 km away',
      'category': 'Others',
      'tag': 'Art',
      'icon': Icons.palette_rounded,
      'iconColor': const Color(0xFF0277BD),
      'iconBg': const Color(0xFFE1F5FE),
      'saved': false,
      'description':
          'Richly pigmented watercolor pan set with mixing palette lid and 2 refillable water reservoir brushes.',
      'sellerName': 'Rabia Aslam',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'id': 'o3',
      'name': 'Padded Acoustic Guitar Gig Bag (41")',
      'price': 'Rs. 800',
      'condition': 'Good condition',
      'isGood': true,
      'distance': '3.5 km away',
      'category': 'Others',
      'tag': 'Musical',
      'icon': Icons.music_note_rounded,
      'iconColor': const Color(0xFF37474F),
      'iconBg': const Color(0xFFCFD8DC),
      'saved': false,
      'description':
          'Heavy-duty waterproof oxford fabric guitar bag with 10mm padding, dual backpack straps, and front sheet music pocket.',
      'sellerName': 'Zeeshan Ali',
      'sellerJoinDate': 'Member since 2022',
    },
  ];

  // Helper to fetch items matching a category name
  static List<Map<String, dynamic>> getItemsForCategory(String category) {
    final catLower = category.trim().toLowerCase();
    return allCatalogItems.where((item) {
      final itemCat = (item['category'] as String).toLowerCase();
      if (itemCat == catLower) return true;
      if (catLower == 'home' && itemCat.contains('home')) return true;
      if (catLower == 'sports' && itemCat.contains('sports')) return true;
      if (catLower == 'beauty' && itemCat.contains('beauty')) return true;
      return false;
    }).toList();
  }
}
