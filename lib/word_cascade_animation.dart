import 'package:flutter/material.dart';

class WordCascadeAnimation extends StatefulWidget {
  /// The text to be animated.
  final String text;
  final TextStyle? style;
  final int delay;

  /// The vertical distance the words will slide up.
  final double slideDistance;

  /// The duration of the entire animation.
  final Duration duration;

  const WordCascadeAnimation({
    super.key,
    required this.text,
    this.style,
    this.delay = 0,
    this.slideDistance = 0.7,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<WordCascadeAnimation> createState() => _WordCascadeAnimationState();
}

class _WordCascadeAnimationState extends State<WordCascadeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    // ⏱️ Start animation after the optional delay
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✂️ 1. Split the sentence into individual words
    final List<String> words = widget.text.split(' ');

    return  Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0, // Horizontal space between words
      runSpacing: -2.0, // Vertical space between lines
      children: List.generate(words.length, (index) {
        // 🧮 2. Calculate staggered timing for each word
        // As index increases, startTime increases, creating the "cascade"
        final double startTime = (index / words.length) * 0.6;
        final double endTime = startTime + 0.4;

        final animation = CurvedAnimation(
          parent: _controller,
          curve: Interval(
            startTime,
            endTime.clamp(0.0, 1.0), // Safety check
            curve: Curves.easeOut,
          ),
        );

        // ⬆️ 3. Create the slide up effect
        final slideAnimation = Tween<Offset>(
          begin: Offset(0.0, widget.slideDistance), // Start slightly below
          end: Offset.zero, // End at natural position
        ).animate(animation);

        // 📦 4. Render the word with Fade and Slide
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideAnimation,
            child: Text(
              '${words[index]} ', // Add space back after split
              style: widget.style,
            ),
          ),
        );
      }),
    );
  }
}