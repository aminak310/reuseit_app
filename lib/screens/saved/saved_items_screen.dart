import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../items/item_details_screen.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _savedItems = [
    {
      'name': 'Winter Jacket',
      'price': 'Rs. 1,500',
      'condition': 'Good condition',
      'conditionColor': AppColors.goodCondition,
      'distance': '2 km away',
      'icon': Icons.checkroom_rounded,
      'iconColor': const Color(0xFF2C3E50),
      'saved': true,
    },
    {
      'name': 'Backpack',
      'price': 'Rs. 1,200',
      'condition': 'Good condition',
      'conditionColor': AppColors.goodCondition,
      'distance': '2 km away',
      'icon': Icons.backpack_rounded,
      'iconColor': Color(0xFF34495E),
      'saved': true,
    },
    {
      'name': 'Books Set',
      'price': 'Rs. 800',
      'condition': 'Good condition',
      'conditionColor': AppColors.goodCondition,
      'distance': '3 km away',
      'icon': Icons.menu_book_rounded,
      'iconColor': Color(0xFF4A90D9),
      'saved': true,
    },
    {
      'name': 'Sneakers',
      'price': 'Rs. 2,000',
      'condition': 'Fair condition',
      'conditionColor': AppColors.fairCondition,
      'distance': '4 km away',
      'icon': Icons.hiking_rounded,
      'iconColor': Color(0xFF8E44AD),
      'saved': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildItemsList(),
                _buildCollectionsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Text(
            'Saved Items',
            style: GoogleFonts.poppins(
              fontSize: 24,
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
            child: const Icon(Icons.delete_outline_rounded,
                color: AppColors.primary, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 14),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primary,
        tabs: const [
          Tab(text: 'Items'),
          Tab(text: 'Collections'),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      itemCount: _savedItems.length,
      itemBuilder: (context, index) => _buildSavedCard(context, index),
    );
  }

  Widget _buildSavedCard(BuildContext context, int index) {
    final item = _savedItems[index];
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
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['iconColor'] as Color,
                  size: 38,
                ),
              ),
              const SizedBox(width: 14),
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
                    const SizedBox(height: 3),
                    Text(
                      item['price'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: (item['conditionColor'] as Color)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(7),
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
                            size: 11, color: AppColors.textLight),
                        Text(
                          item['distance'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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

  Widget _buildCollectionsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.folder_open_rounded,
                color: AppColors.primary, size: 44),
          ),
          const SizedBox(height: 16),
          Text(
            'No collections yet',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create collections to organize\nyour saved items',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: Text('Create Collection',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
