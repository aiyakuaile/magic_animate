import 'package:flutter/material.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

enum MOpenType {
  openDownLeft,
  openDownLeftReturn,
  openDownRight,
  openDownRightReturn,
  openUpLeft,
  openUpLeftReturn,
  openUpRight,
  openUpRightReturn,
  openDownLeftOut,
  openDownRightOut,
  openUpLeftOut,
  openUpRightOut
}

class MOpenWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MOpenType type;
  const MOpenWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MOpenWidget> createState() => _MOpenWidgetState();
}

class _MOpenWidgetState extends State<MOpenWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: widget.duration, vsync: this);
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;
  late Alignment _originAlignment;

  @override
  void didUpdateWidget(covariant MOpenWidget oldWidget) {
    if (oldWidget.type != widget.type) {
      _setupAnimations();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    widget.onController(_controller);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  _setupAnimations() {
    late Tween<double> rotateTween;
    switch (widget.type) {
      case MOpenType.openDownLeft:
        rotateTween = Tween<double>(begin: .0, end: -110.0.toRadians());
        _originAlignment = FractionalOffset.bottomLeft;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openDownLeftReturn:
        rotateTween = Tween<double>(begin: -110.0.toRadians(), end: .0);
        _originAlignment = FractionalOffset.bottomLeft;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openDownRight:
        rotateTween = Tween<double>(begin: .0, end: 110.0.toRadians());
        _originAlignment = FractionalOffset.bottomRight;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openDownRightReturn:
        rotateTween = Tween<double>(begin: 110.0.toRadians(), end: .0);
        _originAlignment = FractionalOffset.bottomRight;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openUpLeft:
        rotateTween = Tween<double>(begin: .0, end: 110.0.toRadians());
        _originAlignment = FractionalOffset.topLeft;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openUpLeftReturn:
        rotateTween = Tween<double>(begin: 110.0.toRadians(), end: .0);
        _originAlignment = FractionalOffset.topLeft;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openUpRight:
        rotateTween = Tween<double>(begin: .0, end: -110.0.toRadians());
        _originAlignment = FractionalOffset.topRight;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openUpRightReturn:
        rotateTween = Tween<double>(begin: -110.0.toRadians(), end: .0);
        _originAlignment = FractionalOffset.topRight;
        _opacityAnimation = ConstantTween(1.0).animate(_controller);
        break;
      case MOpenType.openDownLeftOut:
        rotateTween = Tween<double>(begin: .0, end: -110.0.toRadians());
        _originAlignment = FractionalOffset.bottomLeft;
        _opacityAnimation =
            Tween<double>(begin: 1.0, end: .0).animate(_controller);
        break;
      case MOpenType.openDownRightOut:
        rotateTween = Tween<double>(begin: .0, end: 110.0.toRadians());
        _originAlignment = FractionalOffset.bottomRight;
        _opacityAnimation =
            Tween<double>(begin: 1.0, end: .0).animate(_controller);
        break;
      case MOpenType.openUpLeftOut:
        rotateTween = Tween<double>(begin: .0, end: 110.0.toRadians());
        _originAlignment = FractionalOffset.topLeft;
        _opacityAnimation =
            Tween<double>(begin: 1.0, end: .0).animate(_controller);
        break;
      case MOpenType.openUpRightOut:
        rotateTween = Tween<double>(begin: .0, end: -110.0.toRadians());
        _originAlignment = FractionalOffset.topRight;
        _opacityAnimation =
            Tween<double>(begin: 1.0, end: .0).animate(_controller);
        break;
    }
    _rotationAnimation = rotateTween
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: _originAlignment,
          transform: Matrix4.identity()..rotateZ(_rotationAnimation.value),
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
