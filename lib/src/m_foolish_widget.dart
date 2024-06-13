import 'package:flutter/material.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

class MFoolishWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  const MFoolishWidget(
      {super.key,
      required this.child,
      required this.onController,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MFoolishWidget> createState() => _MFoolishWidgetState();
}

class _MFoolishWidgetState extends State<MFoolishWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Alignment> _alignAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 80),
    ]).animate(_controller);

    _rotateAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 360.0, end: 0.0), weight: 20),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 80),
    ]).animate(_controller);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: 20),
      TweenSequenceItem(tween: ConstantTween(0.5), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: 20),
    ]).animate(_controller);

    _alignAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween(
              begin: const FractionalOffset(0.5, 0.5),
              end: const FractionalOffset(0.0, 1.0)),
          weight: 20),
      TweenSequenceItem(
          tween: Tween(
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(1.0, 1.0)),
          weight: 20),
      TweenSequenceItem(
          tween: Tween(
              begin: const FractionalOffset(1.0, 1.0),
              end: const FractionalOffset(0.0, 0.5)),
          weight: 20),
      TweenSequenceItem(
          tween: Tween(
              begin: const FractionalOffset(0.0, 0.5),
              end: const FractionalOffset(0.0, 0.0)),
          weight: 20),
      TweenSequenceItem(
          tween: Tween(
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.5)),
          weight: 20),
    ]).animate(_controller);

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
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(_scaleAnimation.value)
            ..rotateZ(_rotateAnimation.value.toRadians()),
          alignment: _alignAnimation.value,
          child: Opacity(opacity: _opacityAnimation.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
