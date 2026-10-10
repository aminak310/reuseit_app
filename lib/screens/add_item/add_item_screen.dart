import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _selectedCategory;
  String? _selectedCondition;

  // Working photo picker state with pre-available assets
  final List<String> _selectedPhotos = [];

  final List<String> _sampleAvailablePhotos = [
    'assets/images/backpack.jpg',
    'assets/images/winter_jacket.jpg',
    'assets/images/textbook.jpg',
  ];

  final List<String> _categories = [
    'Books',
    'Clothes',
    'Electronics',
    'Home & Living',
    'Sports & Fitness',
    'Accessories',
    'Beauty & Health',
    'Others',
  ];

  final List<String> _conditions = [
    'Like New',
    'Good condition',
    'Fair condition',
    'Needs Repair',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addPhoto() {
    if (_selectedPhotos.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maximum 5 photos allowed!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color(0xFF145C32),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Pick from available asset images in cycle
    final String nextPhoto = _sampleAvailablePhotos[
        _selectedPhotos.length % _sampleAvailablePhotos.length];

    setState(() {
      _selectedPhotos.add(nextPhoto);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Photo added (${_selectedPhotos.length}/5) 📸',
          style: GoogleFonts.poppins(),
        ),
        duration: const Duration(milliseconds: 1200),
        backgroundColor: const Color(0xFF145C32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select a category',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: const Color(0xFFD94D43),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      if (_selectedCondition == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select condition',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: const Color(0xFFD94D43),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // Show success dialog
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5F5EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF145C32),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Item Listed Successfully!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF145C32),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your item "${_titleController.text}" is now live and visible to buyers near you.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF4E6B56),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx); // Close dialog
                      Navigator.pop(context); // Go back to Home
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF145C32),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      _buildPhotoUploadSection(),
                      const SizedBox(height: 22),

                      // Item Title
                      _buildFieldLabel('Item Title'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _titleController,
                        hint: 'e.g. Backpack, Jacket, Phone',
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter item title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Category
                      _buildFieldLabel('Category'),
                      const SizedBox(height: 8),
                      _buildDropdownField(
                        hint: 'Select category',
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (val) =>
                            setState(() => _selectedCategory = val),
                      ),
                      const SizedBox(height: 18),

                      // Condition
                      _buildFieldLabel('Condition'),
                      const SizedBox(height: 8),
                      _buildDropdownField(
                        hint: 'Select condition',
                        value: _selectedCondition,
                        items: _conditions,
                        onChanged: (val) =>
                            setState(() => _selectedCondition = val),
                      ),
                      const SizedBox(height: 18),

                      // Price (Rs.)
                      _buildFieldLabel('Price (Rs.)'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _priceController,
                        hint: 'e.g. 500',
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter price';
                          }
                          if (double.tryParse(val) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Post Item Button
                      _buildPostButton(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
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
            'Add New Item',
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: forestGreen,
              letterSpacing: 0.3,
            ),
          ),

          // Top right decorative leaf
          const Icon(
            Icons.eco_rounded,
            size: 24,
            color: Color(0xFF86B98F),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoUploadSection() {
    const Color forestGreen = Color(0xFF145C32);

    return GestureDetector(
      onTap: _addPhoto,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFB8DCC0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Camera outline icon
            const Icon(
              Icons.camera_alt_outlined,
              size: 44,
              color: forestGreen,
            ),
            const SizedBox(height: 8),

            // Heading
            Text(
              'Add Photos',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: forestGreen,
              ),
            ),
            const SizedBox(height: 3),

            // Subtitle
            Text(
              _selectedPhotos.isEmpty
                  ? 'Tap to add photos (max 5)'
                  : '${_selectedPhotos.length}/5 photos added (Tap to add more)',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7E9F88),
              ),
            ),

            // Preview thumbnails if photos are added
            if (_selectedPhotos.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _selectedPhotos.length,
                  itemBuilder: (context, i) {
                    return Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: forestGreen),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              _selectedPhotos[i],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => _removePhoto(i),
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD94D43),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF145C32),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: const Color(0xFF145C32),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF8CAE99),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF145C32),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFD94D43),
              width: 1.2,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF145C32),
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF7E9F88),
          size: 22,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF8CAE99),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF145C32),
              width: 1.5,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildPostButton() {
    const Color forestGreen = Color(0xFF145C32);

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: _submitForm,
        icon: const Icon(Icons.near_me_rounded, size: 20),
        label: Text(
          'Post Item',
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
          shadowColor: forestGreen.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
