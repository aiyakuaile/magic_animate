import 'dart:ui';

import 'package:flutter/material.dart';

import 'magic_type.dart';

enum MVanishType {
  vanishIn,
  vanishOut,
}

class MVanishWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MVanishType type;
  final MagicControllerFn onController;
  const MVanishWidget(
      {super.key,
      required this.child,
      required this.onController,
      this.duration = const Duration(milliseconds: 1000),
      this.type = MVanishType.vanishIn});

  @override
  State<MVanishWidget> createState() => _MVanishWidgetState();
}

class _MVanishWidgetState extends State<MVanishWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void didUpdateWidget(covariant MVanishWidget oldWidget) {
    if (widget.type != oldWidget.type) {
      setState(() {
        _animation = widget.type == MVanishType.vanishIn
            ? Tween(begin: 0.0, end: 1.0).animate(_controller)
            : Tween(begin: 1.0, end: 0.0).animate(_controller);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = widget.type == MVanishType.vanishIn
        ? Tween(begin: 0.0, end: 1.0).animate(_controller)
        : Tween(begin: 1.0, end: 0.0).animate(_controller);

    widget.onController(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (1 - _animation.value),
          alignment: Alignment.center,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 90 * (1 - _animation.value),
              sigmaY: 90 * (1 - _animation.value),
            ),
            child: Opacity(opacity: _animation.value, child: child),
          ),
        );
      },
      child: widget.child,
    );
  }
}
