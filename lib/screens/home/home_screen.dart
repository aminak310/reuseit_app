import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../categories/categories_screen.dart';
import '../items/items_list_screen.dart';
import '../items/item_details_screen.dart';
import '../add_item/add_item_screen.dart';
import '../saved/saved_items_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    _HomeBody(),
    CategoriesScreen(),
    SizedBox(), // Placeholder for center FAB
    SavedItemsScreen(),
    ProfileScreen(),
  ];

  void _onNavTap(int index) {
    if (index == 2) return; // FAB is handled separately
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    const Color creamBg = Color(0xFFF7F7EE);

    return Scaffold(
      backgroundColor: creamBg,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildFAB() {
    const Color forestGreen = Color(0xFF145C32);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddItemScreen()),
        );
      },
      child: Container(
        width: 56,
        height: 56,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: forestGreen,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: forestGreen.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        padding: EdgeInsets.zero,
        notchMargin: 6,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', 0),
              _navItem(Icons.grid_view_rounded, 'Categories', 1),
              const SizedBox(width: 52), // Space for FAB
              _navItem(Icons.favorite_border_rounded, 'Saved', 3),
              _navItem(Icons.person_outline_rounded, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    const Color forestGreen = Color(0xFF145C32);
    const Color inactiveColor = Color(0xFF8CAE99);

    return GestureDetector(
      onTap: () => _onNavTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected && icon == Icons.favorite_border_rounded
                ? Icons.favorite_rounded
                : (isSelected && icon == Icons.person_outline_rounded
                    ? Icons.person_rounded
                    : icon),
            size: 24,
            color: isSelected ? forestGreen : inactiveColor,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? forestGreen : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  // Popular items with real photos matching screenshot
  final List<Map<String, dynamic>> _popularItems = [
    {
      'name': 'Backpack',
      'price': 'Rs. 1,200',
      'condition': 'Good condition',
      'distance': '2 km away',
      'image': 'assets/images/backpack.jpg',
      'saved': false,
    },
    {
      'name': 'Textbook',
      'price': 'Rs. 600',
      'condition': 'Good condition',
      'distance': '1 km away',
      'image': 'assets/images/textbook.jpg',
      'saved': true,
    },
    {
      'name': 'Headphones',
      'price': 'Rs. 800',
      'condition': 'Fair condition',
      'distance': '3 km away',
      'icon': Icons.headphones_rounded,
      'iconColor': const Color(0xFF8E44AD),
      'saved': false,
    },
  ];

  final List<Map<String, dynamic>> _categories = const [
    {
      'name': 'Books',
      'icon': Icons.menu_book_rounded,
      'iconColor': Color(0xFF1F7A4C),
      'bgColor': Color(0xFFE8F5EE),
    },
    {
      'name': 'Clothes',
      'icon': Icons.checkroom_rounded,
      'iconColor': Color(0xFFE8933A),
      'bgColor': Color(0xFFFFF4E8),
    },
    {
      'name': 'Electronics',
      'icon': Icons.computer_rounded,
      'iconColor': Color(0xFF4A89DC),
      'bgColor': Color(0xFFEBF3FC),
    },
    {
      'name': 'Home & Living',
      'icon': Icons.home_rounded,
      'iconColor': Color(0xFFF1A83B),
      'bgColor': Color(0xFFFFF8EC),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildSearchBar(context),
            const SizedBox(height: 18),
            _buildBanner(context),
            const SizedBox(height: 24),
            _buildCategoriesSection(context),
            const SizedBox(height: 24),
            _buildPopularSection(context),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ReuseIt',
                style: GoogleFonts.nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: forestGreen,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    'Give items a second life',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C553C),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.eco_rounded,
                    size: 15,
                    color: Color(0xFF2E7D32),
                  ),
                ],
              ),
            ],
          ),
          // Notification Bell
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: forestGreen,
                    size: 24,
                  ),
                  Positioned(
                    top: 10,
                    right: 11,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF145C32),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for items...',
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xFF8CAE99),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16, right: 10),
              child: Icon(
                Icons.search_rounded,
                color: Color(0xFF7E9F88),
                size: 22,
              ),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 48, minHeight: 48),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 155,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1E7D4F),
              Color(0xFF32A065),
              Color(0xFF4DBB7E),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E7D4F).withValues(alpha: 0.28),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              // Subtle background circle glow
              Positioned(
                right: -20,
                bottom: -20,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
              ),

              // Content row
              Row(
                children: [
                  // Left: Text content
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 18, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Less Waste',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'More Value',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.eco_rounded,
                                size: 18,
                                color: Color(0xFFD4EED8),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Buy, sell and reuse\npre-loved items. 🍃',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    height: 1.35,
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right: Earth in hands illustration
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/onboarding_earth.jpg',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Icon(
                              Icons.public_rounded,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: forestGreen,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoriesScreen(),
                    ),
                  );
                },
                child: Text(
                  'See all',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF4E785C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _categories.map((cat) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemsListScreen(category: cat['name']),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            cat['icon'] as IconData,
                            size: 32,
                            color: cat['iconColor'] as Color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat['name'] as String,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: forestGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularSection(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Items',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: forestGreen,
                ),
              ),
              Text(
                'See all',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF4E785C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 205,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _popularItems.length,
            itemBuilder: (context, i) {
              final item = _popularItems[i];
              final bool isSaved = item['saved'] as bool? ?? false;
              final String? imagePath = item['image'] as String?;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ItemDetailsScreen(item: item),
                    ),
                  );
                },
                child: Container(
                  width: 165,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image with favorite button
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 115,
                              width: double.infinity,
                              color: const Color(0xFFF0F5F2),
                              child: imagePath != null
                                  ? Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Center(
                                        child: Icon(
                                          item['icon'] as IconData? ??
                                              Icons.inventory_2_rounded,
                                          size: 48,
                                          color: forestGreen,
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Icon(
                                        item['icon'] as IconData? ??
                                            Icons.inventory_2_rounded,
                                        size: 48,
                                        color: item['iconColor'] as Color? ??
                                            forestGreen,
                                      ),
                                    ),
                            ),
                            // Heart button in top right
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    item['saved'] = !isSaved;
                                  });
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isSaved
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    size: 16,
                                    color: isSaved
                                        ? const Color(0xFFE54B4B)
                                        : const Color(0xFF7E9F88),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Item Details (Name, Price, Location badge)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['name'] as String,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: forestGreen,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.eco_rounded,
                                  size: 12,
                                  color: Color(0xFF32A065),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item['price'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2C553C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
