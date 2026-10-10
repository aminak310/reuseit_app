import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late bool _isSaved;
  int _selectedImageIndex = 0;

  late List<String> _thumbnails;

  @override
  void initState() {
    super.initState();
    _isSaved = (widget.item['saved'] as bool?) ?? false;

    final String? primaryImg = widget.item['image'] as String?;
    if (primaryImg != null) {
      _thumbnails = [
        primaryImg,
        'assets/images/backpack.jpg',
        'assets/images/winter_jacket.jpg',
        'assets/images/textbook.jpg',
      ];
    } else {
      _thumbnails = [
        'assets/images/backpack.jpg',
        'assets/images/winter_jacket.jpg',
        'assets/images/textbook.jpg',
        'assets/images/onboarding_earth.jpg',
      ];
    }
  }

  void _showContactSellerSheet(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);
    final TextEditingController messageController = TextEditingController(
      text: 'Hi ${widget.item['sellerName'] ?? 'Ayesha'}, is this still available?',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6E5DB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFE5F5EC),
                    child: Text(
                      (widget.item['sellerName'] as String? ?? 'A')[0],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: forestGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chat with ${widget.item['sellerName'] ?? 'Ayesha Khan'}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: forestGreen,
                        ),
                      ),
                      Text(
                        'Usually replies within an hour',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF7E9F88),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7EE),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2EFE7)),
                ),
                child: TextField(
                  controller: messageController,
                  maxLines: 3,
                  style: GoogleFonts.poppins(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(14),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Message sent to ${widget.item['sellerName'] ?? 'Seller'}! ✉️',
                          style: GoogleFonts.poppins(),
                        ),
                        backgroundColor: forestGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: Text(
                    'Send Message',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: forestGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color creamBg = Color(0xFFF7F7EE);

    return Scaffold(
      backgroundColor: creamBg,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImage(context),
                _buildThumbnailRow(),
                _buildDetailsSection(context),
                const SizedBox(height: 150), // Spacing for bottom buttons
              ],
            ),
          ),

          // Bottom Action Buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);
    final String currentImage = _thumbnails[_selectedImageIndex];

    return Stack(
      children: [
        // Main photo container
        Container(
          height: 330,
          width: double.infinity,
          color: const Color(0xFFF2EFE9),
          child: Image.asset(
            currentImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(
                Icons.backpack_rounded,
                size: 110,
                color: forestGreen,
              ),
            ),
          ),
        ),

        // Floating Top Back Button
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 18,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: forestGreen,
                ),
              ),
            ),
          ),
        ),

        // Floating Top Favorite Heart Button
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 18,
          child: GestureDetector(
            onTap: () {
              setState(() => _isSaved = !_isSaved);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isSaved
                        ? '${widget.item['name'] ?? 'Item'} saved to favorites! ❤️'
                        : 'Item removed from saved',
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
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _isSaved
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 20,
                  color: _isSaved
                      ? const Color(0xFFE54B4B)
                      : const Color(0xFF2C553C),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnailRow() {
    const Color forestGreen = Color(0xFF145C32);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: List.generate(_thumbnails.length, (index) {
          final bool isSelected = _selectedImageIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedImageIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 62,
              height: 62,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? forestGreen : Colors.transparent,
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  _thumbnails[index],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.inventory_2_rounded,
                    size: 28,
                    color: forestGreen,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);
    final String name = widget.item['name'] as String? ?? 'Backpack';
    final String price = widget.item['price'] as String? ?? 'Rs. 1,200';
    final String condition =
        widget.item['condition'] as String? ?? 'Good condition';
    final String distance =
        widget.item['distance'] as String? ?? '2 km away';
    final String description = widget.item['description'] as String? ??
        'Stylish and durable backpack. Used only for 6 months. No damage, just like new. Perfect for college or travel.';
    final String sellerName =
        widget.item['sellerName'] as String? ?? 'Ayesha Khan';
    final String sellerMember =
        widget.item['sellerJoinDate'] as String? ?? 'Member since 2024';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            name,
            style: GoogleFonts.nunito(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: forestGreen,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),

          // Price
          Text(
            price,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: forestGreen,
            ),
          ),
          const SizedBox(height: 12),

          // Badges: Condition + Distance
          Row(
            children: [
              // Good condition badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F5EC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  condition,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E8B57),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Distance badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 13,
                      color: Color(0xFF7E9F88),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7E9F88),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Description Header
          Text(
            'Description',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: forestGreen,
            ),
          ),
          const SizedBox(height: 8),

          // Description Text
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.55,
              color: const Color(0xFF4E6B56),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 22),

          // Seller Header
          Text(
            'Seller',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: forestGreen,
            ),
          ),
          const SizedBox(height: 12),

          // Seller Profile Card
          GestureDetector(
            onTap: () => _showContactSellerSheet(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFE5F5EC),
                    child: Text(
                      sellerName[0],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: forestGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sellerName,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: forestGreen,
                          ),
                        ),
                        Text(
                          sellerMember,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    const Color forestGreen = Color(0xFF145C32);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7EE),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Contact Seller Button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () => _showContactSellerSheet(context),
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
              label: Text(
                'Contact Seller',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: forestGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Save Item Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() => _isSaved = !_isSaved);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isSaved ? 'Item saved! ❤️' : 'Item removed from saved',
                      style: GoogleFonts.poppins(),
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
              icon: Icon(
                _isSaved
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                size: 20,
                color: _isSaved ? const Color(0xFFE54B4B) : forestGreen,
              ),
              label: Text(
                _isSaved ? 'Saved ❤️' : 'Save Item',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: forestGreen,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: forestGreen.withValues(alpha: 0.45),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
