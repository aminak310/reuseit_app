import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../items/items_list_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {
      'name': 'Books',
      'count': '120+ items',
      'icon': Icons.menu_book_rounded,
      'color': Color(0xFF4A90D9),
      'bgColor': Color(0xFFEBF4FD),
    },
    {
      'name': 'Clothes',
      'count': '85+ items',
      'icon': Icons.checkroom_rounded,
      'color': Color(0xFFE67E22),
      'bgColor': Color(0xFFFDF0E5),
    },
    {
      'name': 'Electronics',
      'count': '76+ items',
      'icon': Icons.headphones_rounded,
      'color': Color(0xFF8E44AD),
      'bgColor': Color(0xFFF4EDF8),
    },
    {
      'name': 'Home & Living',
      'count': '54+ items',
      'icon': Icons.chair_rounded,
      'color': Color(0xFF27AE60),
      'bgColor': Color(0xFFE5F5EC),
    },
    {
      'name': 'Sports & Fitness',
      'count': '32+ items',
      'icon': Icons.sports_basketball_rounded,
      'color': Color(0xFFE74C3C),
      'bgColor': Color(0xFFFDEAE9),
    },
    {
      'name': 'Accessories',
      'count': '49+ items',
      'icon': Icons.watch_rounded,
      'color': Color(0xFFD4A017),
      'bgColor': Color(0xFFFBF5E6),
    },
    {
      'name': 'Beauty & Health',
      'count': '21+ items',
      'icon': Icons.spa_rounded,
      'color': Color(0xFFE91E8C),
      'bgColor': Color(0xFFFDE8F4),
    },
    {
      'name': 'Others',
      'count': '17+ items',
      'icon': Icons.more_horiz_rounded,
      'color': Color(0xFF607D8B),
      'bgColor': Color(0xFFECEFF1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.15,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(context, _categories[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          Text(
            'Categories',
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
            child: const Icon(Icons.search_rounded,
                color: AppColors.primary, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, Map<String, dynamic> cat, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemsListScreen(category: cat['name'] as String),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200 + index * 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (cat['color'] as Color).withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ItemsListScreen(category: cat['name'] as String),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: cat['bgColor'] as Color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: cat['color'] as Color,
                      size: 28,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cat['name'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        cat['count'] as String,
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
          ),
        ),
      ),
    );
  }
}
