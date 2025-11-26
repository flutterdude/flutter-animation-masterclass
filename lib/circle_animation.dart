import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key});

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation1;
  late final Animation<Offset> _slideAnimation2;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 🌊 Animation 1: Starts immediately (0.0)
    _slideAnimation1 = Tween<Offset>(
      begin: const Offset(-1.5, -0.9), // Start off-screen top-left
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // 🌊 Animation 2: Starts slightly later (0.2) for a layered effect
    _slideAnimation2 = Tween<Offset>(
      begin: const Offset(-1.5, -0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🎨 Background Layer
        SlideTransition(
          position: _slideAnimation2,
          child: Image.asset('assets/circle_1.png', fit: BoxFit.contain),
        ),
        // 🎨 Foreground Layer (renders on top)
        SlideTransition(
          position: _slideAnimation1,
          child: Image.asset('assets/circle_2.png', fit: BoxFit.contain),
        ),
      ],
    );
  }
}