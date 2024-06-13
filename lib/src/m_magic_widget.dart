import 'package:flutter/material.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

class MMagicWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  const MMagicWidget(
      {super.key,
      required this.child,
      required this.onController,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MMagicWidget> createState() => _MMagicWidgetState();
}

class _MMagicWidgetState extends State<MMagicWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<Alignment> _transformOriginAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _rotateAnimation =
        Tween<double>(begin: 0.0, end: 270.0).animate(_controller);
    _transformOriginAnimation = Tween<Alignment>(
      begin: const Alignment(1.0, 3.0),
      end: const Alignment(3.0, 9.0),
    ).animate(_controller);

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
          alignment: _transformOriginAnimation.value,
          transform: Matrix4.identity()
            ..scale(_opacityAnimation.value, _opacityAnimation.value)
            ..rotateZ(_rotateAnimation.value.toRadians()),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
