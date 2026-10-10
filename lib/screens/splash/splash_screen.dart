import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.95, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    // Transition to Onboarding Screen after 3.2 seconds
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder: (context, anim, secondaryAnimation, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 650),
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
    const Color creamBg = Color(0xFFF7F7EE);
    const Color forestGreen = Color(0xFF145C32);

    return Scaffold(
      backgroundColor: creamBg,
      body: Stack(
        children: [
          // Corner botanical leaf sprigs
          const Positioned.fill(
            child: CustomPaint(
              painter: _BotanicalCornerLeavesPainter(),
            ),
          ),

          // Main Screen Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _fadeAnimation,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 16),

                          // Top: Logo + Brand Name + Tagline
                          Column(
                            children: [
                              // Circular Logo Badge
                              Container(
                                width: 104,
                                height: 104,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: forestGreen.withValues(alpha: 0.15),
                                      blurRadius: 18,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/reuseit_logo.jpg',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xFF1D6B3C),
                                      child: const Icon(
                                        Icons.recycling_rounded,
                                        size: 58,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),

                              // App Name "ReuseIt"
                              Text(
                                'ReuseIt',
                                style: GoogleFonts.nunito(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: forestGreen,
                                  letterSpacing: 0.4,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Subtitle "Give items a second life 🍃"
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Give items a second life',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF2C553C),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.eco_rounded,
                                    size: 18,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Center: Cardboard Box Illustration
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 320,
                              maxHeight: 320,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                                  blurRadius: 30,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.asset(
                                'assets/images/box_illustration.jpg',
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) =>
                                    _buildFallbackBox(),
                              ),
                            ),
                          ),

                          // Bottom: "Buy • Sell • Reuse" + Progress Pill Indicator
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Column(
                              children: [
                                // Buy • Sell • Reuse
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildActionText('Buy', forestGreen),
                                    _buildDot(forestGreen),
                                    _buildActionText('Sell', forestGreen),
                                    _buildDot(forestGreen),
                                    _buildActionText('Reuse', forestGreen),
                                  ],
                                ),
                                const SizedBox(height: 22),

                                // Progress Indicator Pill
                                Container(
                                  width: 90,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD6E8D8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: (0.35 +
                                              0.65 * _progressAnimation.value)
                                          .clamp(0.0, 1.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: forestGreen,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                          );
                        },
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
  }

  Widget _buildActionText(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildFallbackBox() {
    return Container(
      width: 260,
      height: 240,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Icon(
          Icons.inventory_2_rounded,
          size: 100,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

/// Custom painter to draw delicate botanical watercolor-style leaves in the 4 corners
class _BotanicalCornerLeavesPainter extends CustomPainter {
  const _BotanicalCornerLeavesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final leafPaintLight = Paint()
      ..color = const Color(0xFFB5D4B6).withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final leafPaintDark = Paint()
      ..color = const Color(0xFF8CAE8F).withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;

    final stemPaint = Paint()
      ..color = const Color(0xFF7B9F7E).withValues(alpha: 0.35)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    // Top-left leaves
    _drawLeafBranch(
      canvas,
      start: const Offset(-10, -10),
      end: const Offset(90, 100),
      stemPaint: stemPaint,
      leafPaint1: leafPaintLight,
      leafPaint2: leafPaintDark,
    );
    _drawLeafBranch(
      canvas,
      start: const Offset(20, -15),
      end: const Offset(120, 50),
      stemPaint: stemPaint,
      leafPaint1: leafPaintDark,
      leafPaint2: leafPaintLight,
    );

    // Top-right leaves
    _drawLeafBranch(
      canvas,
      start: Offset(size.width + 10, -10),
      end: Offset(size.width - 90, 100),
      stemPaint: stemPaint,
      leafPaint1: leafPaintDark,
      leafPaint2: leafPaintLight,
    );
    _drawLeafBranch(
      canvas,
      start: Offset(size.width - 20, -15),
      end: Offset(size.width - 120, 50),
      stemPaint: stemPaint,
      leafPaint1: leafPaintLight,
      leafPaint2: leafPaintDark,
    );

    // Bottom-left leaves
    _drawLeafBranch(
      canvas,
      start: Offset(-10, size.height + 10),
      end: Offset(80, size.height - 90),
      stemPaint: stemPaint,
      leafPaint1: leafPaintDark,
      leafPaint2: leafPaintLight,
    );
    _drawLeafBranch(
      canvas,
      start: Offset(30, size.height + 15),
      end: Offset(110, size.height - 40),
      stemPaint: stemPaint,
      leafPaint1: leafPaintLight,
      leafPaint2: leafPaintDark,
    );

    // Bottom-right leaves
    _drawLeafBranch(
      canvas,
      start: Offset(size.width + 10, size.height + 10),
      end: Offset(size.width - 80, size.height - 90),
      stemPaint: stemPaint,
      leafPaint1: leafPaintLight,
      leafPaint2: leafPaintDark,
    );
    _drawLeafBranch(
      canvas,
      start: Offset(size.width - 30, size.height + 15),
      end: Offset(size.width - 110, size.height - 40),
      stemPaint: stemPaint,
      leafPaint1: leafPaintDark,
      leafPaint2: leafPaintLight,
    );
  }

  void _drawLeafBranch(
    Canvas canvas, {
    required Offset start,
    required Offset end,
    required Paint stemPaint,
    required Paint leafPaint1,
    required Paint leafPaint2,
  }) {
    // Stem path
    final path = Path();
    path.moveTo(start.dx, start.dy);
    final ctrl = Offset(
      (start.dx + end.dx) / 2 + 15,
      (start.dy + end.dy) / 2 - 10,
    );
    path.quadraticBezierTo(ctrl.dx, ctrl.dy, end.dx, end.dy);
    canvas.drawPath(path, stemPaint);

    // Draw individual leaves along stem
    for (int i = 1; i <= 4; i++) {
      final t = i / 4.5;
      final pos = Offset(
        (1 - t) * (1 - t) * start.dx + 2 * (1 - t) * t * ctrl.dx + t * t * end.dx,
        (1 - t) * (1 - t) * start.dy + 2 * (1 - t) * t * ctrl.dy + t * t * end.dy,
      );

      final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);
      final side = (i % 2 == 0) ? 1 : -1;
      final leafAngle = angle + side * 0.65;

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(leafAngle);

      final leafPath = Path();
      leafPath.moveTo(0, 0);
      leafPath.quadraticBezierTo(10, -7, 22, 0);
      leafPath.quadraticBezierTo(10, 7, 0, 0);

      canvas.drawPath(leafPath, i.isEven ? leafPaint1 : leafPaint2);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
