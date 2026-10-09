import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import 'item_details_screen.dart';

class ItemsListScreen extends StatefulWidget {
  final String category;
  const ItemsListScreen({super.key, required this.category});

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Men', 'Women', 'Kids'];

  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Winter Jacket',
      'price': 'Rs. 1,500',
      'condition': 'Good condition',
      'conditionColor': AppColors.goodCondition,
      'distance': '2 km away',
      'icon': Icons.checkroom_rounded,
      'iconColor': const Color(0xFF2C3E50),
      'saved': false,
    },
    {
      'name': 'Sweatshirt',
      'price': 'Rs. 800',
      'condition': 'Good condition',
      'conditionColor': AppColors.goodCondition,
      'distance': '3 km away',
      'icon': Icons.checkroom_rounded,
      'iconColor': Color(0xFFE74C3C),
      'saved': false,
    },
    {
      'name': 'Jeans',
      'price': 'Rs. 1,000',
      'condition': 'Good condition',
      'conditionColor': AppColors.goodCondition,
      'distance': '4 km away',
      'icon': Icons.dry_cleaning_rounded,
      'iconColor': Color(0xFF2980B9),
      'saved': false,
    },
    {
      'name': 'T-shirt',
      'price': 'Rs. 400',
      'condition': 'Fair condition',
      'conditionColor': AppColors.fairCondition,
      'distance': '5 km away',
      'icon': Icons.dry_cleaning_rounded,
      'iconColor': Color(0xFF1ABC9C),
      'saved': true,
    },
    {
      'name': 'Formal Shirt',
      'price': 'Rs. 700',
      'condition': 'Good condition',
      'conditionColor': AppColors.goodCondition,
      'distance': '1 km away',
      'icon': Icons.checkroom_rounded,
      'iconColor': Color(0xFF8E44AD),
      'saved': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildFilterTabs(),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                itemCount: _items.length,
                itemBuilder: (context, index) =>
                    _buildItemCard(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: AppColors.textDark),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            widget.category,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.search_rounded,
                color: AppColors.primary, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: List.generate(_filters.length, (i) {
          final bool selected = _selectedFilter == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Text(
                _filters[i],
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.textMid,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, int index) {
    final item = _items[index];
    bool isSaved = item['saved'] as bool;

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
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Item image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['iconColor'] as Color,
                  size: 40,
                ),
              ),
              const SizedBox(width: 14),
              // Item info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['price'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (item['conditionColor'] as Color)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['condition'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: item['conditionColor'] as Color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on_rounded,
                            size: 12, color: AppColors.textLight),
                        Text(
                          item['distance'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Actions
              Column(
                children: [
                  Icon(
                    isSaved
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isSaved ? AppColors.accent : AppColors.textLight,
                    size: 22,
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: AppColors.textLight),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
