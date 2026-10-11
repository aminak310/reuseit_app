import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/user_service.dart';
import '../auth/login_screen.dart';
import '../saved/saved_items_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Counters for profile stats
  final int _listingsCount = 5;
  final int _savedCount = 3;
  final int _ordersCount = 12;

  // Toggle states for settings
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;

  void _showMyListingsSheet() {
    const Color forestGreen = Color(0xFF145C32);
    final List<Map<String, String>> myListings = [
      {
        'title': 'Winter Jacket',
        'price': 'Rs. 1,500',
        'status': 'Active',
        'views': '24 views',
      },
      {
        'title': 'Denim Jeans',
        'price': 'Rs. 1,000',
        'status': 'Active',
        'views': '18 views',
      },
      {
        'title': 'Cotton Sweatshirt',
        'price': 'Rs. 800',
        'status': 'Active',
        'views': '42 views',
      },
      {
        'title': 'Sneakers (Size 42)',
        'price': 'Rs. 2,000',
        'status': 'Sold',
        'views': '65 views',
      },
      {
        'title': 'Calculus Textbook',
        'price': 'Rs. 500',
        'status': 'Sold',
        'views': '31 views',
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (_, controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
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
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Listings ($_listingsCount)',
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: forestGreen,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F5EC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '3 Active',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: forestGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: myListings.length,
                      separatorBuilder: (_, _) =>
                          const Divider(color: Color(0xFFEDF4EF)),
                      itemBuilder: (context, i) {
                        final item = myListings[i];
                        final bool isSold = item['status'] == 'Sold';
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2EFE9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: forestGreen,
                            ),
                          ),
                          title: Text(
                            item['title']!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: forestGreen,
                            ),
                          ),
                          subtitle: Text(
                            '${item['price']} • ${item['views']}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF7E9F88),
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isSold
                                  ? const Color(0xFFF5EBEA)
                                  : const Color(0xFFE5F5EC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item['status']!,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isSold
                                    ? const Color(0xFFD94D43)
                                    : forestGreen,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showMyOrdersSheet() {
    const Color forestGreen = Color(0xFF145C32);
    final List<Map<String, String>> orders = [
      {
        'item': 'Illustrated Art Textbook',
        'date': 'Yesterday',
        'price': 'Rs. 600',
        'status': 'Delivered',
      },
      {
        'title': 'Casual Denim Jacket',
        'date': 'Oct 3, 2026',
        'price': 'Rs. 1,200',
        'status': 'Delivered',
      },
      {
        'title': 'Desk Reading Lamp',
        'date': 'Sep 28, 2026',
        'price': 'Rs. 750',
        'status': 'Delivered',
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              Text(
                'My Orders ($_ordersCount items)',
                style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: forestGreen,
                ),
              ),
              const SizedBox(height: 14),
              ...orders.map((o) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7EE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F5EC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.local_shipping_outlined,
                          color: forestGreen,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              o['item'] ?? o['title']!,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: forestGreen,
                              ),
                            ),
                            Text(
                              '${o['price']} • ${o['date']}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF7E9F88),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        o['status']!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: forestGreen,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showMessagesSheet() {
    const Color forestGreen = Color(0xFF145C32);
    final List<Map<String, String>> chats = [
      {
        'name': 'Usman Tariq',
        'item': 'Winter Jacket',
        'lastMsg': 'Yes, still available! When can you pick up?',
        'time': '10:30 AM',
      },
      {
        'name': 'Hamza Ali',
        'item': 'Sweatshirt',
        'lastMsg': 'I can offer Rs. 700 for it.',
        'time': 'Yesterday',
      },
      {
        'name': 'Sara Ahmed',
        'item': 'Jeans Size 32',
        'lastMsg': 'Thanks for the quick delivery!',
        'time': 'Oct 4',
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              Text(
                'Messages (3)',
                style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: forestGreen,
                ),
              ),
              const SizedBox(height: 14),
              ...chats.map((c) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFE5F5EC),
                    child: Text(
                      c['name']![0],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: forestGreen,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        c['name']!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: forestGreen,
                        ),
                      ),
                      Text(
                        c['time']!,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF8CAE99),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '${c['item']}: ${c['lastMsg']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF4E6B56),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    UserService.logout(); Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showHelpSupportSheet() {
    const Color forestGreen = Color(0xFF145C32);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              Text(
                'Help & Support',
                style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: forestGreen,
                ),
              ),
              const SizedBox(height: 14),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.help_center_outlined,
                    color: forestGreen),
                title: Text('Frequently Asked Questions',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email_outlined, color: forestGreen),
                title: Text('Contact Support (support@reuseit.com)',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.security_outlined, color: forestGreen),
                title: Text('Safety & Trust Guidelines',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSettingsSheet() {
    const Color forestGreen = Color(0xFF145C32);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  Text(
                    'Settings',
                    style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: forestGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: forestGreen,
                    title: Text(
                      'Push Notifications',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: forestGreen,
                      ),
                    ),
                    subtitle: Text(
                      'Get alerts about messages & offers',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF7E9F88),
                      ),
                    ),
                    value: _notificationsEnabled,
                    onChanged: (val) {
                      setSheetState(() => _notificationsEnabled = val);
                      setState(() => _notificationsEnabled = val);
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: forestGreen,
                    title: Text(
                      'Location Services',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: forestGreen,
                      ),
                    ),
                    subtitle: Text(
                      'Show items nearby accurately',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF7E9F88),
                      ),
                    ),
                    value: _locationEnabled,
                    onChanged: (val) {
                      setSheetState(() => _locationEnabled = val);
                      setState(() => _locationEnabled = val);
                    },
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        UserService.logout(); Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFD94D43)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Log Out',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFD94D43),
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
      },
    );
  }

  void _showEcoImpactDialog() {
    const Color forestGreen = Color(0xFF145C32);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const Icon(Icons.eco_rounded, color: forestGreen, size: 26),
              const SizedBox(width: 8),
              Text(
                'Your Eco Impact',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: forestGreen,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'By buying and selling 12 pre-loved items on ReuseIt, you have:',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF4E6B56),
                ),
              ),
              const SizedBox(height: 14),
              _buildImpactRow(
                  '🌱', 'Saved 18.5 kg of Carbon Emissions'),
              _buildImpactRow(
                  '💧', 'Conserved 4,200 Litres of Water'),
              _buildImpactRow(
                  '📦', 'Diverted 7.8 kg of Waste from Landfills'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: forestGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Awesome!',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImpactRow(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF145C32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color creamBg = Color(0xFFF7F7EE);

    return Scaffold(
      backgroundColor: creamBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              _buildUserInfo(),
              const SizedBox(height: 22),
              _buildStatsRow(),
              const SizedBox(height: 24),
              _buildMenuItems(),
              const SizedBox(height: 24),
              _buildEcoBanner(),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    const Color forestGreen = Color(0xFF145C32);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Settings gear icon
          GestureDetector(
            onTap: _showSettingsSheet,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: const Icon(
                Icons.settings_outlined,
                size: 24,
                color: forestGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(UserModel currentUser) {
    const Color forestGreen = Color(0xFF145C32);
    final nameCtrl = TextEditingController(text: currentUser.name);
    final emailCtrl = TextEditingController(text: currentUser.email);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Edit Profile',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: forestGreen,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                style: GoogleFonts.poppins(fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle:
                      GoogleFonts.poppins(color: const Color(0xFF4E6B56)),
                  filled: true,
                  fillColor: const Color(0xFFF7F7EE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailCtrl,
                style: GoogleFonts.poppins(fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      GoogleFonts.poppins(color: const Color(0xFF4E6B56)),
                  filled: true,
                  fillColor: const Color(0xFFF7F7EE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
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
                if (nameCtrl.text.trim().isNotEmpty) {
                  UserService.updateProfile(
                    name: nameCtrl.text.trim(),
                    email: emailCtrl.text.trim(),
                  );
                  Navigator.pop(ctx);
                  UserService.logout(); Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: forestGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Save',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserInfo() {
    const Color forestGreen = Color(0xFF145C32);

    return ValueListenableBuilder<UserModel>(
      valueListenable: UserService.currentUserNotifier,
      builder: (context, user, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              // Avatar circle with dynamic Initials
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFC3E4C6), Color(0xFFA5D1AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: forestGreen.withValues(alpha: 0.14),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    user.initials,
                    style: GoogleFonts.nunito(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: forestGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // User Name & Email (from Login)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.name,
                            style: GoogleFonts.nunito(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: forestGreen,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => _showEditProfileDialog(user),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5F5EC),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              size: 14,
                              color: forestGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B8B77),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsRow() {
    const Color forestGreen = Color(0xFF145C32);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          // Listings
          Expanded(
            child: GestureDetector(
              onTap: _showMyListingsSheet,
              child: Column(
                children: [
                  Text(
                    '$_listingsCount',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: forestGreen,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Listings',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7E9F88),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Divider 1
          Container(
            width: 1,
            height: 28,
            color: const Color(0xFFD8E7DC),
          ),

          // Saved
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SavedItemsScreen(),
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    '$_savedCount',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: forestGreen,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Saved',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7E9F88),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Divider 2
          Container(
            width: 1,
            height: 28,
            color: const Color(0xFFD8E7DC),
          ),

          // Items
          Expanded(
            child: GestureDetector(
              onTap: _showMyOrdersSheet,
              child: Column(
                children: [
                  Text(
                    '$_ordersCount',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: forestGreen,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Items',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7E9F88),
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

  Widget _buildMenuItems() {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'My Listings',
        'icon': Icons.assignment_outlined,
        'action': _showMyListingsSheet,
      },
      {
        'title': 'Saved Items',
        'icon': Icons.favorite_border_rounded,
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SavedItemsScreen(),
            ),
          );
        },
      },
      {
        'title': 'My Orders',
        'icon': Icons.receipt_long_outlined,
        'action': _showMyOrdersSheet,
      },
      {
        'title': 'Messages',
        'icon': Icons.chat_bubble_outline_rounded,
        'action': _showMessagesSheet,
      },
      {
        'title': 'Help & Support',
        'icon': Icons.help_outline_rounded,
        'action': _showHelpSupportSheet,
      },
      {
        'title': 'Settings',
        'icon': Icons.settings_outlined,
        'action': _showSettingsSheet,
      },
    ];

    const Color forestGreen = Color(0xFF145C32);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: menuItems.map((item) {
          return Column(
            children: [
              InkWell(
                onTap: item['action'] as VoidCallback,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 14),
                  child: Row(
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: 22,
                        color: forestGreen,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: forestGreen,
                          ),
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
              const Divider(
                height: 1,
                thickness: 0.8,
                color: Color(0xFFE4EEE6),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEcoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _showEcoImpactDialog,
        child: Container(
          width: double.infinity,
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1E7D4F),
                Color(0xFF34A669),
                Color(0xFF4BB87B),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E7D4F).withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Circular leaf badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Small changes 🍃',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'make a big difference',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron right
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
