import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Animated background widget with floating geometric shapes.
///
/// Creates a dynamic background with multiple animated shapes including:
/// - Floating circles with subtle movement
/// - Rotating geometric elements
/// - Gradient overlays for depth
/// - Smooth continuous animations
class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _rotationController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Floating animation for subtle movement
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Rotation animation for geometric elements
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // Start animations
    _floatingController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.05),
            theme.colorScheme.surface,
            theme.colorScheme.surfaceContainer.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background shapes with explicit sizing
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _floatingAnimation,
                _rotationAnimation,
              ]),
              builder: (context, child) {
                return CustomPaint(
                  painter: BackgroundShapesPainter(
                    floatingValue: _floatingAnimation.value,
                    rotationValue: _rotationAnimation.value,
                    primaryColor: theme.colorScheme.primary,
                    secondaryColor: theme.colorScheme.secondary,
                    screenSize: size,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),
          // Content overlay
          widget.child,
        ],
      ),
    );
  }
}

/// Custom painter that draws animated geometric shapes in the background.
class BackgroundShapesPainter extends CustomPainter {
  final double floatingValue;
  final double rotationValue;
  final Color primaryColor;
  final Color secondaryColor;
  final Size screenSize;

  BackgroundShapesPainter({
    required this.floatingValue,
    required this.rotationValue,
    required this.primaryColor,
    required this.secondaryColor,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create paints for different shape styles with more visible opacity
    final circlePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = secondaryColor.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final gradientPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              primaryColor.withValues(alpha: 0.2),
              primaryColor.withValues(alpha: 0.05),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.3, size.height * 0.2),
              radius: 150,
            ),
          );

    // Floating offset based on animation
    final floatingOffset = math.sin(floatingValue * 2 * math.pi) * 20;

    // Draw large background circles with floating animation
    canvas.drawCircle(
      Offset(
        size.width * 0.15 + floatingOffset,
        size.height * 0.1 + floatingOffset * 0.5,
      ),
      80,
      circlePaint,
    );

    canvas.drawCircle(
      Offset(
        size.width * 0.85 - floatingOffset,
        size.height * 0.3 + floatingOffset,
      ),
      60,
      gradientPaint,
    );

    canvas.drawCircle(
      Offset(
        size.width * 0.1 + floatingOffset * 0.7,
        size.height * 0.7 - floatingOffset,
      ),
      45,
      circlePaint,
    );

    canvas.drawCircle(
      Offset(
        size.width * 0.9 - floatingOffset * 0.8,
        size.height * 0.8 + floatingOffset * 0.3,
      ),
      70,
      Paint()
        ..color = secondaryColor.withValues(alpha: 0.12)
        ..style = PaintingStyle.fill,
    );

    // Draw rotating geometric shapes
    canvas.save();
    canvas.translate(size.width * 0.8, size.height * 0.15);
    canvas.rotate(rotationValue);
    _drawTriangle(canvas, strokePaint, 40);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width * 0.2, size.height * 0.6);
    canvas.rotate(-rotationValue * 0.7);
    _drawSquare(canvas, strokePaint, 35);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width * 0.9, size.height * 0.9);
    canvas.rotate(rotationValue * 0.5);
    _drawHexagon(canvas, strokePaint, 25);
    canvas.restore();

    // Add additional filled geometric shapes for more visibility
    final filledShapePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(size.width * 0.1, size.height * 0.3);
    canvas.rotate(rotationValue * 0.3);
    _drawTriangle(canvas, filledShapePaint, 25);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width * 0.7, size.height * 0.15);
    canvas.rotate(-rotationValue * 0.4);
    _drawSquare(canvas, filledShapePaint, 20);
    canvas.restore();

    // Draw floating dots
    final dotPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final dots = [
      Offset(size.width * 0.3, size.height * 0.4 + floatingOffset),
      Offset(size.width * 0.7, size.height * 0.6 - floatingOffset),
      Offset(size.width * 0.5, size.height * 0.2 + floatingOffset * 0.5),
      Offset(size.width * 0.1, size.height * 0.5 - floatingOffset * 0.7),
      Offset(size.width * 0.95, size.height * 0.4 + floatingOffset * 0.3),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 6, dotPaint);
    }

    // Draw curved lines
    final linePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.2 + floatingOffset,
      size.width * 0.6,
      size.height * 0.35,
    );
    canvas.drawPath(path, linePaint);

    final path2 = Path();
    path2.moveTo(size.width * 0.4, size.height);
    path2.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.8 - floatingOffset,
      size.width,
      size.height * 0.7,
    );
    canvas.drawPath(path2, linePaint);
  }

  void _drawTriangle(Canvas canvas, Paint paint, double size) {
    final path = Path();
    path.moveTo(0, -size);
    path.lineTo(-size * 0.866, size * 0.5);
    path.lineTo(size * 0.866, size * 0.5);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSquare(Canvas canvas, Paint paint, double size) {
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: size, height: size),
      paint,
    );
  }

  void _drawHexagon(Canvas canvas, Paint paint, double size) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi) / 3;
      final x = size * math.cos(angle);
      final y = size * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundShapesPainter oldDelegate) {
    return oldDelegate.floatingValue != floatingValue ||
        oldDelegate.rotationValue != rotationValue;
  }
}
