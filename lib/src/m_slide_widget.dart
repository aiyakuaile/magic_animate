import 'package:flutter/material.dart';

import 'magic_type.dart';

enum MSlideType {
  slideDown,
  slideUp,
  slideLeft,
  slideRight,
  slideDownReturn,
  slideUpReturn,
  slideLeftReturn,
  slideRightReturn
}

class MSlideWidget extends StatefulWidget {
  final Widget child;
  final Size size;
  final Duration duration;
  final MagicControllerFn onController;
  final MSlideType type;
  const MSlideWidget(
      {super.key,
      required this.size,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MSlideWidget> createState() => _MSlideWidgetState();
}

class _MSlideWidgetState extends State<MSlideWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: widget.duration, vsync: this);

  late Animation<double> _offsetXAnimation;
  late Animation<double> _offsetYAnimation;

  @override
  void didUpdateWidget(covariant MSlideWidget oldWidget) {
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
      case MSlideType.slideDown:
        _offsetXAnimation = ConstantTween(.0).animate(_controller);
        _offsetYAnimation = Tween(begin: .0, end: 1.0).animate(_controller);
        break;
      case MSlideType.slideUp:
        _offsetXAnimation = ConstantTween(.0).animate(_controller);
        _offsetYAnimation = Tween(begin: .0, end: -1.0).animate(_controller);
        break;
      case MSlideType.slideLeft:
        _offsetYAnimation = ConstantTween(.0).animate(_controller);
        _offsetXAnimation = Tween(begin: .0, end: -1.0).animate(_controller);
        break;
      case MSlideType.slideRight:
        _offsetYAnimation = ConstantTween(.0).animate(_controller);
        _offsetXAnimation = Tween(begin: .0, end: 1.0).animate(_controller);
        break;
      case MSlideType.slideDownReturn:
        _offsetXAnimation = ConstantTween(.0).animate(_controller);
        _offsetYAnimation = Tween(begin: 1.0, end: .0).animate(_controller);
        break;
      case MSlideType.slideUpReturn:
        _offsetXAnimation = ConstantTween(.0).animate(_controller);
        _offsetYAnimation = Tween(begin: -1.0, end: .0).animate(_controller);
        break;
      case MSlideType.slideLeftReturn:
        _offsetYAnimation = ConstantTween(.0).animate(_controller);
        _offsetXAnimation = Tween(begin: -1.0, end: .0).animate(_controller);
        break;
      case MSlideType.slideRightReturn:
        _offsetYAnimation = ConstantTween(.0).animate(_controller);
        _offsetXAnimation = Tween(begin: 1.0, end: .0).animate(_controller);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(widget.size.width * _offsetXAnimation.value,
              widget.size.height * _offsetYAnimation.value),
          child: child,
        );
      },
      child: SizedBox.fromSize(
        size: widget.size,
        child: widget.child,
      ),
    );
  }
}
