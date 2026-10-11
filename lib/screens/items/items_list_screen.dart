import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/items_repository.dart';
import 'item_details_screen.dart';

class ItemsListScreen extends StatefulWidget {
  final String category;
  const ItemsListScreen({super.key, required this.category});

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  int _selectedFilter = 0;
  late final List<String> _filters;
  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _allItems;

  @override
  void initState() {
    super.initState();
    _filters = ItemsRepository.getFiltersForCategory(widget.category);
    _allItems = ItemsRepository.getItemsForCategory(widget.category);
  }

  List<Map<String, dynamic>> get _filteredItems {
    return _allItems.where((item) {
      final String name = (item['name'] as String).toLowerCase();
      final String desc = (item['description'] as String? ?? '').toLowerCase();
      final String query = _searchQuery.toLowerCase();

      final bool matchesSearch = _searchQuery.isEmpty ||
          name.contains(query) ||
          desc.contains(query);

      if (!matchesSearch) return false;

      if (_selectedFilter == 0) return true; // All
      final String filterTag = _filters[_selectedFilter];
      return item['tag'] == filterTag;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            if (_isSearching) _buildSearchField(),
            _buildFilterPills(),
            Expanded(
              child: _filteredItems.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(18, 6, 18, 24),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return _buildItemCard(context, _filteredItems[index]);
                      },
                    ),
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
            onTap: () => Navigator.pop(context),
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
            widget.category,
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: forestGreen,
              letterSpacing: 0.3,
            ),
          ),

          // Search button toggle
          GestureDetector(
            onTap: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: Icon(
                _isSearching ? Icons.close_rounded : Icons.search_rounded,
                size: 24,
                color: forestGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (val) {
            setState(() => _searchQuery = val);
          },
          decoration: InputDecoration(
            hintText: 'Search in ${widget.category}...',
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xFF8CAE99),
              fontSize: 13,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF7E9F88),
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPills() {
    const Color forestGreen = Color(0xFF145C32);

    return Container(
      height: 42,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: _filters.length,
        itemBuilder: (context, i) {
          final bool selected = _selectedFilter == i;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedFilter = i);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? forestGreen : Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _filters[i],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? Colors.white : const Color(0xFF2C553C),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, Map<String, dynamic> item) {
    const Color forestGreen = Color(0xFF145C32);
    final bool isSaved = item['saved'] as bool? ?? false;
    final bool isGood = item['isGood'] as bool? ?? true;
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
            // Item photo
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 90,
                height: 90,
                color: const Color(0xFFF0F5F2),
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildFallbackIcon(item),
                      )
                    : _buildFallbackIcon(item),
              ),
            ),
            const SizedBox(width: 14),

            // Item Information
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
                  const SizedBox(height: 6),

                  // Condition Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isGood
                          ? const Color(0xFFE5F5EC)
                          : const Color(0xFFFFF2E2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['condition'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isGood
                            ? const Color(0xFF2E8B57)
                            : const Color(0xFFD97A24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Distance
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 12,
                        color: Color(0xFF7E9F88),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        item['distance'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7E9F88),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Right side: Heart toggle & Arrow Chevron
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Favorite heart button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      item['saved'] = !isSaved;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          !isSaved
                              ? '${item['name']} saved to favorites! ❤️'
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
                const SizedBox(height: 38),

                // Chevron arrow
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

  Widget _buildFallbackIcon(Map<String, dynamic> item) {
    final IconData? customIcon = item['icon'] as IconData?;
    final Color? iconColor = item['iconColor'] as Color?;
    final Color? iconBg = item['iconBg'] as Color?;

    if (customIcon != null) {
      return Container(
        color: iconBg ?? const Color(0xFFF0F5F2),
        child: Center(
          child: Icon(
            customIcon,
            size: 44,
            color: iconColor ?? const Color(0xFF145C32),
          ),
        ),
      );
    }

    final String type = item['colorType'] as String? ?? '';
    switch (type) {
      case 'sweatshirt':
        return Container(
          color: const Color(0xFFFDECEB),
          child: const Center(
            child: Icon(
              Icons.checkroom_rounded,
              size: 46,
              color: Color(0xFFD94D43),
            ),
          ),
        );
      case 'jeans':
        return Container(
          color: const Color(0xFFE8F1F8),
          child: const Center(
            child: Icon(
              Icons.dry_cleaning_rounded,
              size: 46,
              color: Color(0xFF2E75B6),
            ),
          ),
        );
      case 'tshirt':
        return Container(
          color: const Color(0xFFEBEBEB),
          child: const Center(
            child: Icon(
              Icons.dry_cleaning_rounded,
              size: 46,
              color: Color(0xFF333333),
            ),
          ),
        );
      default:
        return const Center(
          child: Icon(
            Icons.inventory_2_rounded,
            size: 46,
            color: Color(0xFF145C32),
          ),
        );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFFE5F5EC),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 34,
              color: Color(0xFF145C32),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No items found',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF145C32),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try switching category filters',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF7E9F88),
            ),
          ),
        ],
      ),
    );
  }
}
