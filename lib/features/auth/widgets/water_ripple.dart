import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WaterRipple extends ConsumerStatefulWidget {
  const WaterRipple({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WaterRippleState();
}

class _WaterRippleState extends ConsumerState<WaterRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startRippleAnimation(TapDownDetails details) {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _startRippleAnimation,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: WaterRipplePainter(
              animationValue: _animationController.value,
            ),
            child: child,
          );
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Ripple',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WaterRipplePainter extends CustomPainter {
  final double animationValue;

  WaterRipplePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final rippleRadius = size.width * animationValue;
    final opacity = (1.0 - animationValue).clamp(0.0, 1.0);

    final paint = Paint()
      ..color = Colors.blue.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, rippleRadius, paint);
  }

  @override
  bool shouldRepaint(WaterRipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
