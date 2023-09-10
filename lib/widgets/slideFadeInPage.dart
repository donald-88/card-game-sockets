import 'package:flutter/material.dart';

class SlideFadeInPage extends StatefulWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const SlideFadeInPage({super.key, required this.children, required this.mainAxisAlignment, required this.crossAxisAlignment});

  @override
  _SlideFadeInPageState createState() => _SlideFadeInPageState();
}

class _SlideFadeInPageState extends State<SlideFadeInPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimations = List.generate(
      widget.children.length,
      (index) => Tween<Offset>(
        begin: const Offset(-2.0, 0.0), // Start further offscreen on the left
        end: const Offset(0.0, 0.0),    // Move to the center
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval((index + 1) / widget.children.length, 1.0,
              curve: Curves.easeInOut), // Use easeInOut for a smoother effect
        ),
      ),
    );

    _fadeAnimations = List.generate(
      widget.children.length,
      (index) => Tween<double>(
        begin: 0.0, // Fully transparent
        end: 1.0,  // Fully opaque
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval((index + 1) / widget.children.length, 1.0,
              curve: Curves.easeInOut),
        ),
      ),
    );

    // Start the animation when the page loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;

        return FadeTransition(
          opacity: _fadeAnimations[index],
          child: SlideTransition(
            position: _slideAnimations[index],
            child: child,
          ),
        );
      }).toList(),
    );
  }
}
