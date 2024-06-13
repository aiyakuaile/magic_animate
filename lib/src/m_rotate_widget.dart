import 'package:flutter/widgets.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

enum MRotateType { rotateDown, rotateLeft, rotateRight, rotateUp }

class MRotateWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MRotateType type;
  final double? translateZAxis;
  const MRotateWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000),
      this.translateZAxis});

  @override
  State<MRotateWidget> createState() => _MRotateWidgetState();
}

class _MRotateWidgetState extends State<MRotateWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: widget.duration, vsync: this);

  late Animation<double> _rotateXAnimation;
  late Animation<double> _rotateYAnimation;
  late Animation<double> _translateZAnimation;
  late Animation<Alignment> _originAnimation;

  @override
  void didUpdateWidget(covariant MRotateWidget oldWidget) {
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

  _setupAnimations() {
    switch (widget.type) {
      case MRotateType.rotateDown:
        _rotateXAnimation =
            Tween(begin: 0.0, end: -180.0.toRadians()).animate(_controller);
        _rotateYAnimation = ConstantTween(0.0).animate(_controller);
        _originAnimation = Tween(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomCenter)
            .animate(_controller);
        _translateZAnimation =
            Tween(begin: 0.0, end: widget.translateZAxis ?? 300.0)
                .animate(_controller);
        break;
      case MRotateType.rotateUp:
        _rotateXAnimation =
            Tween(begin: 0.0, end: 180.0.toRadians()).animate(_controller);
        _rotateYAnimation = ConstantTween(0.0).animate(_controller);
        _originAnimation = Tween(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.topCenter)
            .animate(_controller);
        _translateZAnimation =
            Tween(begin: 0.0, end: widget.translateZAxis ?? 100.0)
                .animate(_controller);
        break;
      case MRotateType.rotateRight:
        _rotateXAnimation = ConstantTween(0.0).animate(_controller);
        _rotateYAnimation =
            Tween(begin: 0.0, end: 180.0.toRadians()).animate(_controller);
        _originAnimation = Tween(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.topCenter)
            .animate(_controller);
        _translateZAnimation =
            Tween(begin: 0.0, end: widget.translateZAxis ?? 150.0)
                .animate(_controller);
        break;
      case MRotateType.rotateLeft:
        _rotateXAnimation = ConstantTween(0.0).animate(_controller);
        _rotateYAnimation =
            Tween(begin: 0.0, end: -180.0.toRadians()).animate(_controller);
        _originAnimation = Tween(
                begin: FractionalOffset.centerRight,
                end: FractionalOffset.centerLeft)
            .animate(_controller);
        _translateZAnimation =
            Tween(begin: 0.0, end: widget.translateZAxis ?? 300.0)
                .animate(_controller);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          late Matrix4 transform;
          if (widget.type != MRotateType.rotateRight) {
            transform = Matrix4.identity()
              ..setEntry(3, 2, -0.003)
              ..rotateX(_rotateXAnimation.value)
              ..rotateY(_rotateYAnimation.value)
              ..translate(.0, .0, _translateZAnimation.value);
          } else {
            transform = Matrix4.identity()
              ..rotateX(_rotateXAnimation.value)
              ..rotateY(_rotateYAnimation.value)
              ..translate(.0, .0, _translateZAnimation.value)
              ..setEntry(3, 2, -0.003);
          }

          return Transform(
            alignment: _originAnimation.value,
            transform: transform,
            child: Opacity(
              opacity: 1.0 - _controller.value,
              child: widget.child,
            ),
          );
        },
        child: widget.child);
  }
}
