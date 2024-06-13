import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

enum MBombType { leftOut, rightOut }

class MBombWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MBombType type;
  const MBombWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MBombWidget> createState() => _MBombWidgetState();
}

class _MBombWidgetState extends State<MBombWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Alignment> _transformOriginAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _blurAnimation;

  @override
  void didUpdateWidget(covariant MBombWidget oldWidget) {
    if (oldWidget.type != widget.type) {
      _buildAnimation();
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _buildAnimation();
    widget.onController(_controller);
  }

  _buildAnimation() {
    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: .0), weight: 50),
    ]).animate(_controller);

    _rotateAnimation = widget.type == MBombType.rightOut
        ? TweenSequence([
            TweenSequenceItem(
                tween: Tween(begin: .0, end: 160.0.toRadians()), weight: 50),
            TweenSequenceItem(
                tween: ConstantTween(160.0.toRadians()), weight: 50),
          ]).animate(_controller)
        : TweenSequence([
            TweenSequenceItem(
                tween: Tween(begin: .0, end: -160.0.toRadians()), weight: 50),
            TweenSequenceItem(
                tween: ConstantTween(-160.0.toRadians()), weight: 50),
          ]).animate(_controller);

    _transformOriginAnimation = widget.type == MBombType.rightOut
        ? TweenSequence([
            TweenSequenceItem(
                tween: Tween(
                    begin: const FractionalOffset(0.5, 0.5),
                    end: const FractionalOffset(2.0, 0.5)),
                weight: 30),
            TweenSequenceItem(
                tween: ConstantTween(const FractionalOffset(2.0, 0.5)),
                weight: 70),
          ]).animate(_controller)
        : TweenSequence([
            TweenSequenceItem(
                tween: Tween(
                    begin: const FractionalOffset(0.5, 0.5),
                    end: const FractionalOffset(-1.0, 0.5)),
                weight: 30),
            TweenSequenceItem(
                tween: ConstantTween(const FractionalOffset(-1.0, 0.5)),
                weight: 70),
          ]).animate(_controller);

    _blurAnimation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: .0, end: 20.0), weight: 50),
    ]).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform(
            transform: Matrix4.identity()..rotateZ(_rotateAnimation.value),
            alignment: _transformOriginAnimation.value,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: _blurAnimation.value,
                sigmaY: _blurAnimation.value,
              ),
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
