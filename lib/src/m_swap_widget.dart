import 'package:flutter/material.dart';

import 'magic_type.dart';

class MSwapWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double translateX;
  final MagicControllerFn onController;
  const MSwapWidget(
      {super.key,
      required this.child,
      required this.onController,
      this.duration = const Duration(milliseconds: 1000),
      this.translateX = 700});
  @override
  State<MSwapWidget> createState() => _MSwapWidgetState();
}

class _MSwapWidgetState extends State<MSwapWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateXAnimation;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _translateXAnimation =
        Tween<double>(begin: -widget.translateX, end: 0.0).animate(_controller);
    _alignmentAnimation = Tween<Alignment>(
            begin: const Alignment(-1.0, 1.0), end: const Alignment(1.0, 1.0))
        .animate(_controller);

    widget.onController(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(_scaleAnimation.value, _scaleAnimation.value)
            ..translate(_translateXAnimation.value, 0.0),
          alignment: _alignmentAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
