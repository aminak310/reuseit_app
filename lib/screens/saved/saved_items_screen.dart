import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../items/item_details_screen.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  int _selectedTabIndex = 0; // 0: Items, 1: Collections

  final List<Map<String, dynamic>> _savedItems = [
    {
      'name': 'Winter Jacket',
      'price': 'Rs. 1,500',
      'condition': 'Good condition',
      'distance': '2 km',
      'image': 'assets/images/winter_jacket.jpg',
      'saved': true,
      'category': 'Clothes',
      'description':
          'Warm and stylish dark navy winter jacket. Water-resistant, hooded with multiple pockets.',
      'sellerName': 'Usman Tariq',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'name': 'Backpack',
      'price': 'Rs. 1,200',
      'condition': 'Good condition',
      'distance': '2 km',
      'image': 'assets/images/backpack.jpg',
      'saved': true,
      'category': 'Accessories',
      'description':
          'Stylish and durable backpack. Used only for 6 months. No damage, just like new. Perfect for college or travel.',
      'sellerName': 'Ayesha Khan',
      'sellerJoinDate': 'Member since 2024',
    },
    {
      'name': 'Books Set',
      'price': 'Rs. 800',
      'condition': 'Good condition',
      'distance': '3 km',
      'image': 'assets/images/textbook.jpg',
      'saved': false,
      'category': 'Books',
      'description':
          'Collection of classic illustrated novels and textbooks in excellent condition.',
      'sellerName': 'Ali Raza',
      'sellerJoinDate': 'Member since 2023',
    },
    {
      'name': 'Sneakers',
      'price': 'Rs. 2,000',
      'condition': 'Fair condition',
      'distance': '4 km',
      'colorType': 'sneakers',
      'saved': false,
      'category': 'Shoes',
      'description':
          'Comfortable everyday athletic sneakers in size 42. Good sole grip, lightly used.',
      'sellerName': 'Bilal Khan',
      'sellerJoinDate': 'Member since 2024',
    },
  ];

  final List<Map<String, dynamic>> _collections = [
    {
      'title': 'College Essentials',
      'count': '2 items',
      'color': Color(0xFF145C32),
    },
    {
      'title': 'Winter Wardrobe',
      'count': '1 item',
      'color': Color(0xFF2C8693),
    },
  ];

  void _confirmClearAll() {
    const Color forestGreen = Color(0xFF145C32);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Clear Saved Items?',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: forestGreen,
            ),
          ),
          content: Text(
            'Are you sure you want to remove all saved items from your list?',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF4E6B56),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7E9F88),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedItems.clear();
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Saved items cleared',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: forestGreen,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD94D43),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Clear All',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCreateCollectionDialog() {
    const Color forestGreen = Color(0xFF145C32);
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'New Collection',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: forestGreen,
            ),
          ),
          content: TextField(
            controller: nameController,
            autofocus: true,
            style: GoogleFonts.poppins(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'e.g. Summer Wishlist',
              hintStyle: GoogleFonts.poppins(color: const Color(0xFF8CAE99)),
              filled: true,
              fillColor: const Color(0xFFF7F7EE),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7E9F88),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isNotEmpty) {
                  setState(() {
                    _collections.add({
                      'title': nameController.text.trim(),
                      'count': '0 items',
                      'color': forestGreen,
                    });
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Collection "${nameController.text}" created! 📁',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: forestGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: forestGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Create',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color creamBg = Color(0xFFF7F7EE);

    return Scaffold(
      backgroundColor: creamBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildTabSelector(),
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildItemsList()
                  : _buildCollectionsView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: forestGreen,
              ),
            ),
          ),

          // Title
          Text(
            'Saved Items',
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: forestGreen,
              letterSpacing: 0.3,
            ),
          ),

          // Trash icon
          GestureDetector(
            onTap: _savedItems.isNotEmpty ? _confirmClearAll : null,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: Icon(
                Icons.delete_outline_rounded,
                size: 24,
                color: _savedItems.isNotEmpty
                    ? forestGreen
                    : const Color(0xFFB5D4BE),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    const Color forestGreen = Color(0xFF145C32);

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 4, 18, 14),
      height: 46,
      child: Row(
        children: [
          // Items tab
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 0
                      ? forestGreen
                      : const Color(0xFFE6F0E9),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Center(
                  child: Text(
                    'Items',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _selectedTabIndex == 0
                          ? Colors.white
                          : forestGreen,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Collections tab
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 1
                      ? forestGreen
                      : const Color(0xFFE6F0E9),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Center(
                  child: Text(
                    'Collections',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _selectedTabIndex == 1
                          ? Colors.white
                          : forestGreen,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    const Color forestGreen = Color(0xFF145C32);

    if (_savedItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFE5F5EC),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 36,
                color: forestGreen,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'No saved items yet',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: forestGreen,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap the heart on any item to save it',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF7E9F88),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 4, 18, 90),
      itemCount: _savedItems.length,
      itemBuilder: (context, index) {
        return _buildItemCard(context, _savedItems[index]);
      },
    );
  }

  Widget _buildItemCard(BuildContext context, Map<String, dynamic> item) {
    const Color forestGreen = Color(0xFF145C32);
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
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product photo
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 86,
                height: 86,
                color: const Color(0xFFF2EFE9),
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildFallbackPhoto(item),
                      )
                    : _buildFallbackPhoto(item),
              ),
            ),
            const SizedBox(width: 14),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    item['name'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: forestGreen,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Price
                  Text(
                    item['price'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2C553C),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Location and condition line: Location pin + Good condition • 2 km
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 13,
                        color: Color(0xFF7E9F88),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${item['condition']} • ${item['distance']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7E9F88),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Right column: Heart toggle & Arrow
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      item['saved'] = !isSaved;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          !isSaved
                              ? '${item['name']} saved! ❤️'
                              : '${item['name']} removed from saved',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: forestGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      isSaved
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 22,
                      color: isSaved
                          ? const Color(0xFFE54B4B)
                          : const Color(0xFF7E9F88),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Color(0xFF8CAE99),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackPhoto(Map<String, dynamic> item) {
    return Container(
      color: const Color(0xFFEBF2EC),
      child: const Center(
        child: Icon(
          Icons.hiking_rounded,
          size: 42,
          color: Color(0xFF388E6B),
        ),
      ),
    );
  }

  Widget _buildCollectionsView() {
    const Color forestGreen = Color(0xFF145C32);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 4, 18, 90),
      children: [
        // Create Collection CTA Button
        GestureDetector(
          onTap: _showCreateCollectionDialog,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFB8DCC0),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5F5EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: forestGreen,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'Create New Collection',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: forestGreen,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Collection Cards
        ..._collections.map((col) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: (col['color'] as Color).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.folder_rounded,
                    color: col['color'] as Color,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        col['title'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: forestGreen,
                        ),
                      ),
                      Text(
                        col['count'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF7E9F88),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xFF8CAE99),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
