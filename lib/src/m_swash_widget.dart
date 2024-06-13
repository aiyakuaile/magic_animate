import 'package:flutter/material.dart';

import 'magic_type.dart';

enum MSwashType {
  swashIn,
  swashOut,
}

class MSwashWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MSwashType type;
  final MagicControllerFn onController;
  const MSwashWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MSwashWidget> createState() => _MSwashWidgetState();
}

class _MSwashWidgetState extends State<MSwashWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  _setupAnimations() {
    if (widget.type == MSwashType.swashIn) {
      _opacityAnimation = TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 80),
        TweenSequenceItem(tween: ConstantTween(1.0), weight: 20)
      ]).animate(_controller);
      _scaleAnimation = TweenSequence([
        TweenSequenceItem(tween: Tween(begin: .0, end: .9), weight: 80),
        TweenSequenceItem(tween: ConstantTween(.9), weight: 10),
        TweenSequenceItem(tween: Tween(begin: .9, end: 1.0), weight: 10)
      ]).animate(_controller);
    } else {
      _opacityAnimation = TweenSequence([
        TweenSequenceItem(tween: ConstantTween(1.0), weight: 80),
        TweenSequenceItem(tween: Tween(begin: 1.0, end: .0), weight: 20)
      ]).animate(_controller);
      _scaleAnimation = TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: .9), weight: 80),
        TweenSequenceItem(tween: Tween(begin: .9, end: .0), weight: 20)
      ]).animate(_controller);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _setupAnimations();
    widget.onController(_controller);
  }

  @override
  void didUpdateWidget(covariant MSwashWidget oldWidget) {
    if (oldWidget.type != widget.type) {
      _setupAnimations();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
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
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
