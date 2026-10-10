import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../items/items_list_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {
      'name': 'Books',
      'count': '120+ items',
      'type': 'books',
      'color': Color(0xFF4A89DC),
    },
    {
      'name': 'Clothes',
      'count': '85+ items',
      'type': 'clothes',
      'color': Color(0xFFF6A63B),
    },
    {
      'name': 'Electronics',
      'count': '76+ items',
      'type': 'electronics',
      'color': Color(0xFF3896A6),
    },
    {
      'name': 'Home & Living',
      'count': '54+ items',
      'type': 'home',
      'color': Color(0xFF439F57),
    },
    {
      'name': 'Sports & Fitness',
      'count': '32+ items',
      'type': 'sports',
      'color': Color(0xFF3F8A8C),
    },
    {
      'name': 'Accessories',
      'count': '48+ items',
      'type': 'accessories',
      'color': Color(0xFF6B4B3E),
    },
    {
      'name': 'Beauty & Health',
      'count': '21+ items',
      'type': 'beauty',
      'color': Color(0xFFE86C60),
    },
    {
      'name': 'Others',
      'count': '17+ items',
      'type': 'others',
      'color': Color(0xFF4F836E),
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color creamBg = Color(0xFFF7F7EE);

    return Scaffold(
      backgroundColor: creamBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 90),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.96,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(context, _categories[index]);
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

          // Title: "Categories"
          Text(
            'Categories',
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: forestGreen,
              letterSpacing: 0.3,
            ),
          ),

          // Search button
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: const Icon(
                Icons.search_rounded,
                size: 24,
                color: forestGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> cat) {
    const Color forestGreen = Color(0xFF145C32);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemsListScreen(category: cat['name'] as String),
          ),
        );
      },
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon graphic
              SizedBox(
                height: 60,
                child: Center(
                  child: _buildCategoryIcon(cat['type'] as String),
                ),
              ),
              const SizedBox(height: 10),

              // Category Name
              Text(
                cat['name'] as String,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: forestGreen,
                ),
              ),
              const SizedBox(height: 3),

              // Item Count
              Text(
                cat['count'] as String,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8CAE99),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String type) {
    switch (type) {
      case 'books':
        // Stack of colorful books (blue, yellow, red/coral)
        return SizedBox(
          width: 52,
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 2,
                child: Container(
                  width: 44,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A89DC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                child: Container(
                  width: 40,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6BB42),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                bottom: 22,
                child: Container(
                  width: 36,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9573F),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Transform.rotate(
                  angle: -0.15,
                  child: Container(
                    width: 32,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF48CFAD),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case 'clothes':
        // Orange/Yellow T-shirt
        return Container(
          width: 52,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4E6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.checkroom_rounded,
              size: 34,
              color: Color(0xFFF6A63B),
            ),
          ),
        );

      case 'electronics':
        // Blue headphones
        return Container(
          width: 52,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF5F8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.headphones_rounded,
              size: 34,
              color: Color(0xFF2C8693),
            ),
          ),
        );

      case 'home':
        // Green armchair / sofa
        return Container(
          width: 52,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFEBF6ED),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.weekend_rounded,
              size: 34,
              color: Color(0xFF389650),
            ),
          ),
        );

      case 'sports':
        // Teal/blue dumbbell
        return Container(
          width: 52,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFEBF4F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.fitness_center_rounded,
              size: 32,
              color: Color(0xFF3B8B8E),
            ),
          ),
        );

      case 'accessories':
        // Brown leather backpack/bag
        return Container(
          width: 52,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF6EFEA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.work_rounded,
              size: 32,
              color: Color(0xFF5C3C30),
            ),
          ),
        );

      case 'beauty':
        // Pink / coral cosmetics bottle
        return Container(
          width: 52,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFFDECEB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.sanitizer_rounded,
              size: 32,
              color: Color(0xFFE86C60),
            ),
          ),
        );

      case 'others':
        // Soft mint circle with 3 dots
        return Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFFE2EFE7),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.more_horiz_rounded,
              size: 28,
              color: Color(0xFF2E7D59),
            ),
          ),
        );

      default:
        return const Icon(
          Icons.category_rounded,
          size: 32,
          color: Color(0xFF145C32),
        );
    }
  }
}
