import 'package:flutter/material.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

enum MPerspectiveType {
  perspectiveDown,
  perspectiveUp,
  perspectiveLeft,
  perspectiveRight,
  perspectiveDownReturn,
  perspectiveUpReturn,
  perspectiveLeftReturn,
  perspectiveRightReturn
}

class MPerspectiveWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MPerspectiveType type;
  const MPerspectiveWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MPerspectiveWidget> createState() => _MPerspectiveWidgetState();
}

class _MPerspectiveWidgetState extends State<MPerspectiveWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: widget.duration, vsync: this);

  late Animation<double> _rotateXAnimation;
  late Animation<double> _rotateYAnimation;
  late Alignment _originAlignment;

  @override
  void didUpdateWidget(covariant MPerspectiveWidget oldWidget) {
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
    switch (widget.type) {
      case MPerspectiveType.perspectiveDown:
        _originAlignment = const FractionalOffset(0.0, 1.0);
        _rotateXAnimation = Tween(begin: .0, end: -180.0).animate(_controller);
        _rotateYAnimation = ConstantTween(0.0).animate(_controller);
        break;
      case MPerspectiveType.perspectiveUpReturn:
        _originAlignment = const FractionalOffset(0.0, 0.0);
        _rotateXAnimation = Tween(begin: 180.0, end: .0).animate(_controller);
        _rotateYAnimation = ConstantTween(0.0).animate(_controller);
        break;
      case MPerspectiveType.perspectiveLeftReturn:
        _originAlignment = const FractionalOffset(0.0, 0.0);
        _rotateXAnimation = ConstantTween(0.0).animate(_controller);
        _rotateYAnimation = Tween(begin: -180.0, end: 0.0).animate(_controller);
        break;
      case MPerspectiveType.perspectiveRight:
        _originAlignment = const FractionalOffset(1.0, 0.0);
        _rotateYAnimation = Tween(begin: .0, end: 180.0).animate(_controller);
        _rotateXAnimation = ConstantTween(0.0).animate(_controller);
        break;
      case MPerspectiveType.perspectiveDownReturn:
        _originAlignment = const FractionalOffset(0.0, 1.0);
        _rotateXAnimation = Tween(begin: -180.0, end: 0.0).animate(_controller);
        _rotateYAnimation = ConstantTween(0.0).animate(_controller);
        break;
      case MPerspectiveType.perspectiveUp:
        _originAlignment = const FractionalOffset(0.0, 0.0);
        _rotateXAnimation = Tween(begin: .0, end: 180.0).animate(_controller);
        _rotateYAnimation = ConstantTween(0.0).animate(_controller);
        break;
      case MPerspectiveType.perspectiveLeft:
        _originAlignment = const FractionalOffset(0.0, 0.0);
        _rotateYAnimation = Tween(begin: .0, end: -180.0).animate(_controller);
        _rotateXAnimation = ConstantTween(0.0).animate(_controller);
        break;
      case MPerspectiveType.perspectiveRightReturn:
        _originAlignment = const FractionalOffset(1.0, 0.0);
        _rotateYAnimation = Tween(begin: 180.0, end: 0.0).animate(_controller);
        _rotateXAnimation = ConstantTween(0.0).animate(_controller);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, -0.003)
            ..rotateX(_rotateXAnimation.value.toRadians())
            ..rotateY(_rotateYAnimation.value.toRadians()),
          alignment: _originAlignment,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
