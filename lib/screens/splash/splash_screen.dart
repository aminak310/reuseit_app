import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6)),
    );
    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _slideAnim = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.8, curve: Curves.easeOut)),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder: (context, anim, secondaryAnimation, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          // Decorative circles top-right
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight,
              ),
            ),
          ),
          // Decorative circles bottom-left
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight.withOpacity(0.4),
              ),
            ),
          ),
          // Leaf decorations
          Positioned(
            top: 80,
            left: 20,
            child: Icon(Icons.eco, size: 32, color: AppColors.primary.withOpacity(0.25)),
          ),
          Positioned(
            top: 160,
            right: 30,
            child: Icon(Icons.eco, size: 20, color: AppColors.primary.withOpacity(0.2)),
          ),
          Positioned(
            bottom: 180,
            right: 40,
            child: Icon(Icons.eco, size: 28, color: AppColors.primary.withOpacity(0.2)),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo container
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: ScaleTransition(
                        scale: _scaleAnim,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.recycling,
                            size: 70,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    // App Name
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: Text(
                          'ReuseIt',
                          style: GoogleFonts.poppins(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: Text(
                          'Give items a second life 🌿',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: AppColors.textMid,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Cardboard box illustration placeholder
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: ScaleTransition(
                        scale: _scaleAnim,
                        child: _buildBoxIllustration(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Buy • Sell • Reuse
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _dotLabel('Buy'),
                          _bullet(),
                          _dotLabel('Sell'),
                          _bullet(),
                          _dotLabel('Reuse'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Loading indicator
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppColors.primary,
                          backgroundColor: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ],
      ),
    );
  }

  Widget _buildBoxIllustration() {
    return SizedBox(
      width: 200,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Box body
          Positioned(
            bottom: 0,
            child: Container(
              width: 160,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE8A85A),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Box top left flap
          Positioned(
            bottom: 90,
            left: 20,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                width: 72,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4904A),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          // Box top right flap
          Positioned(
            bottom: 90,
            right: 20,
            child: Transform.rotate(
              angle: 0.15,
              child: Container(
                width: 72,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4904A),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    topLeft: Radius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          // Recycling icon on box
          Positioned(
            bottom: 20,
            child: Icon(
              Icons.recycling,
              size: 50,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          // Small icons inside box (items)
          Positioned(
            bottom: 85,
            left: 38,
            child: Icon(Icons.book, size: 22, color: AppColors.primaryLight),
          ),
          Positioned(
            bottom: 95,
            child: Icon(Icons.checkroom, size: 24, color: const Color(0xFFFFD166)),
          ),
          Positioned(
            bottom: 80,
            right: 38,
            child: Icon(Icons.lightbulb, size: 20, color: AppColors.accentYellow),
          ),
          // Leaves around box
          Positioned(
            top: 10,
            left: 10,
            child: Icon(Icons.eco, size: 28, color: AppColors.primary.withOpacity(0.6)),
          ),
          Positioned(
            top: 30,
            right: 12,
            child: Icon(Icons.eco, size: 22, color: AppColors.primary.withOpacity(0.5)),
          ),
          Positioned(
            top: 5,
            right: 50,
            child: Icon(Icons.eco, size: 18, color: AppColors.primary.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }

  Widget _dotLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _bullet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 5,
        height: 5,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryMid,
        ),
      ),
    );
  }
}
