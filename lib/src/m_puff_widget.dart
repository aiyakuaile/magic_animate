import 'dart:ui';

import 'package:flutter/material.dart';

import 'magic_type.dart';

enum MPuffType { puffIn, puffOut }

class MPuffWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MPuffType type;
  final MagicControllerFn onController;
  const MPuffWidget(
      {super.key,
      required this.child,
      required this.onController,
      this.duration = const Duration(milliseconds: 1000),
      this.type = MPuffType.puffIn});

  @override
  State<MPuffWidget> createState() => _MPuffWidgetState();
}

class _MPuffWidgetState extends State<MPuffWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void didUpdateWidget(covariant MPuffWidget oldWidget) {
    if (widget.type != oldWidget.type) {
      setState(() {
        _animation = widget.type == MPuffType.puffIn
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
    _animation = widget.type == MPuffType.puffIn
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
              sigmaX: 2 * (1 - _animation.value),
              sigmaY: 2 * (1 - _animation.value),
            ),
            child: Opacity(opacity: _animation.value, child: child),
          ),
        );
      },
      child: widget.child,
    );
  }
}
