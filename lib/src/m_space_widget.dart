import 'package:flutter/material.dart';

import 'magic_type.dart';

enum MSpaceType {
  spaceInUp,
  spaceInRight,
  spaceInLeft,
  spaceInDown,
  spaceOutUp,
  spaceOutRight,
  spaceOutLeft,
  spaceOutDown;

  bool get isInAnimate {
    switch (this) {
      case MSpaceType.spaceInUp:
      case MSpaceType.spaceInRight:
      case MSpaceType.spaceInLeft:
      case MSpaceType.spaceInDown:
        return true;
      case MSpaceType.spaceOutUp:
      case MSpaceType.spaceOutRight:
      case MSpaceType.spaceOutLeft:
      case MSpaceType.spaceOutDown:
        return false;
    }
  }
}

class MSpaceWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MSpaceType type;
  final MagicControllerFn onController;
  const MSpaceWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MSpaceWidget> createState() => _MSpaceWidgetState();
}

class _MSpaceWidgetState extends State<MSpaceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
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
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: _buildTransform(_controller.value),
          alignment: _getAlignment(),
          child: Opacity(
            opacity: widget.type.isInAnimate
                ? _controller.value
                : 1.0 - _controller.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  Matrix4 _buildTransform(double value) {
    switch (widget.type) {
      case MSpaceType.spaceInUp:
        return Matrix4.identity()
          ..scale(0.2 + 0.8 * value)
          ..translate(0.0, -200.0 * (1 - value));
      case MSpaceType.spaceInRight:
        return Matrix4.identity()
          ..scale(0.2 + 0.8 * value)
          ..translate(200.0 * (1 - value), 0.0);
      case MSpaceType.spaceInLeft:
        return Matrix4.identity()
          ..scale(0.2 + 0.8 * value)
          ..translate(-200.0 * (1 - value), 0.0);
      case MSpaceType.spaceInDown:
        return Matrix4.identity()
          ..scale(0.2 + 0.8 * value)
          ..translate(0.0, 200.0 * (1 - value));
      case MSpaceType.spaceOutUp:
        return Matrix4.identity()
          ..scale(1 - 0.8 * value)
          ..translate(0.0, -200.0 * value);
      case MSpaceType.spaceOutRight:
        return Matrix4.identity()
          ..scale(1 - 0.8 * value)
          ..translate(200.0 * value, 0.0);
      case MSpaceType.spaceOutLeft:
        return Matrix4.identity()
          ..scale(1 - 0.8 * value)
          ..translate(-200.0 * value, 0.0);
      case MSpaceType.spaceOutDown:
        return Matrix4.identity()
          ..scale(1 - 0.8 * value)
          ..translate(0.0, 200.0 * value);
      default:
        return Matrix4.identity();
    }
  }

  Alignment _getAlignment() {
    switch (widget.type) {
      case MSpaceType.spaceInUp:
      case MSpaceType.spaceOutUp:
        return Alignment.topCenter;
      case MSpaceType.spaceInRight:
      case MSpaceType.spaceOutRight:
        return Alignment.centerRight;
      case MSpaceType.spaceInLeft:
      case MSpaceType.spaceOutLeft:
        return Alignment.centerLeft;
      case MSpaceType.spaceInDown:
      case MSpaceType.spaceOutDown:
        return Alignment.bottomCenter;
      default:
        return Alignment.center;
    }
  }
}
