import 'package:flutter/material.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

enum MBoingType {
  inUp,
  outDown,
}

class MBoingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MBoingType type;
  const MBoingWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MBoingWidget> createState() => _MBoingWidgetState();
}

class _MBoingWidgetState extends State<MBoingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateXAnimation;
  late Animation<double> _rotateYAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Alignment> _alignAnimation;
  bool disposed = false;
  @override
  void dispose() {
    disposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MBoingWidget oldWidget) {
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
    _rotateXAnimation = widget.type == MBoingType.outDown
        ? TweenSequence<double>([
            TweenSequenceItem(tween: ConstantTween(0.0), weight: 30),
            TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 10),
            TweenSequenceItem(tween: Tween(begin: 10.0, end: 90.0), weight: 60),
          ]).animate(_controller)
        : TweenSequence<double>([
            TweenSequenceItem(
                tween: Tween(begin: -90.0, end: 50.0), weight: 50),
            TweenSequenceItem(tween: Tween(begin: 50.0, end: 0.0), weight: 50),
          ]).animate(_controller);

    _rotateYAnimation = widget.type == MBoingType.outDown
        ? TweenSequence<double>([
            TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 20),
            TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 10),
            TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 10),
            TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 60)
          ]).animate(_controller)
        : TweenSequence<double>([
            TweenSequenceItem(tween: ConstantTween(0.0), weight: 100),
          ]).animate(_controller);

    _opacityAnimation = widget.type == MBoingType.outDown
        ? TweenSequence<double>([
            TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
            TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 60),
          ]).animate(_controller)
        : TweenSequence<double>([
            TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
            TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
          ]).animate(_controller);

    _alignAnimation = widget.type == MBoingType.outDown
        ? TweenSequence<Alignment>([
            TweenSequenceItem(
                tween: ConstantTween(const FractionalOffset(1, 1)), weight: 20),
            TweenSequenceItem(
                tween: Tween(
                    begin: const FractionalOffset(1, 1),
                    end: const FractionalOffset(0, 1)),
                weight: 10),
            TweenSequenceItem(
                tween: ConstantTween(const FractionalOffset(0, 1)), weight: 10),
            TweenSequenceItem(
                tween: Tween(
                    begin: const FractionalOffset(0, 1),
                    end: const FractionalOffset(1, 1)),
                weight: 60),
          ]).animate(_controller)
        : TweenSequence<Alignment>([
            TweenSequenceItem(
                tween: ConstantTween(Alignment.topCenter), weight: 100),
          ]).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(-_rotateXAnimation.value.toRadians())
            ..rotateY(-_rotateYAnimation.value.toRadians()),
          alignment: _alignAnimation.value,
          child: Opacity(opacity: _opacityAnimation.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
