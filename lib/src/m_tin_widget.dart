import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'magic_type.dart';

enum MTinType {
  tinDownIn,
  tinDownOut,
  tinLeftIn,
  tinLeftOut,
  tinRightIn,
  tinRightOut,
  tinUpIn,
  tinUpOut,
}

class MTinWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MTinType type;
  const MTinWidget({
    super.key,
    required this.child,
    required this.onController,
    required this.type,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<MTinWidget> createState() => _MTinWidgetState();
}

class _MTinWidgetState extends State<MTinWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void didUpdateWidget(covariant MTinWidget oldWidget) {
    if (widget.type != oldWidget.type) {
      _setupAnimations();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _setupAnimations();

    widget.onController(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(
                    _offsetAnimation.value.dx, _offsetAnimation.value.dy)
                ..scale(_scaleAnimation.value),
              child: child,
            ),
          );
        },
        child: widget.child);
  }

  void _setupAnimations() {
    switch (widget.type) {
      case MTinType.tinDownIn:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(
              tween: Tween(begin: const Offset(.0, 900.0), end: Offset.zero),
              weight: 50),
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
        ]).animate(_controller);
        break;
      case MTinType.tinDownOut:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: .0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
          TweenSequenceItem(
              tween: Tween(begin: Offset.zero, end: const Offset(.0, 900.0)),
              weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
        ]).animate(_controller);
        break;
      case MTinType.tinLeftIn:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(
              tween: Tween(begin: const Offset(-900.0, .0), end: Offset.zero),
              weight: 50),
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
        ]).animate(_controller);
        break;
      case MTinType.tinLeftOut:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: .0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
          TweenSequenceItem(
              tween: Tween(begin: Offset.zero, end: const Offset(-900.0, .0)),
              weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
        ]).animate(_controller);
        break;
      case MTinType.tinRightIn:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(
              tween: Tween(begin: const Offset(900.0, .0), end: Offset.zero),
              weight: 50),
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
        ]).animate(_controller);
        break;
      case MTinType.tinRightOut:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: .0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
          TweenSequenceItem(
              tween: Tween(begin: Offset.zero, end: const Offset(900.0, .0)),
              weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
        ]).animate(_controller);
        break;
      case MTinType.tinUpIn:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(
              tween: Tween(begin: const Offset(.0, -900.0), end: Offset.zero),
              weight: 50),
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
        ]).animate(_controller);
        break;
      case MTinType.tinUpOut:
        _opacityAnimation = TweenSequence([
          TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: .0), weight: 50),
        ]).animate(_controller);
        _offsetAnimation = TweenSequence<Offset>([
          TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 50),
          TweenSequenceItem(
              tween: Tween(begin: Offset.zero, end: const Offset(.0, -900.0)),
              weight: 50),
        ]).animate(_controller);
        _scaleAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
          TweenSequenceItem(
              tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
        ]).animate(_controller);
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
