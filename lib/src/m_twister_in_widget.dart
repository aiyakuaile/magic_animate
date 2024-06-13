import 'package:flutter/material.dart';
import 'package:magic_animate/src/degree_extension.dart';

import 'magic_type.dart';

enum MTwisterInType { up, down }

class MTwisterInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MTwisterInType twisterInType;
  const MTwisterInWidget(
      {super.key,
      required this.child,
      required this.onController,
      this.duration = const Duration(milliseconds: 1000),
      this.twisterInType = MTwisterInType.down});

  @override
  State<MTwisterInWidget> createState() => _MTwisterInWidgetState();
}

class _MTwisterInWidgetState extends State<MTwisterInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _transformOriginAnimation;

  @override
  void didUpdateWidget(covariant MTwisterInWidget oldWidget) {
    if (oldWidget.twisterInType != widget.twisterInType) {
      setState(() {
        _transformOriginAnimation = widget.twisterInType == MTwisterInType.down
            ? Tween<Offset>(
                begin: const Offset(-1.0, 1.0),
                end: const Offset(1.0, 1.0),
              ).animate(_controller)
            : Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(-1.0, -1.0),
              ).animate(_controller);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _rotateAnimation =
        Tween<double>(begin: 360.0, end: 0.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _transformOriginAnimation = widget.twisterInType == MTwisterInType.down
        ? Tween<Offset>(
            begin: const Offset(-1.0, 1.0),
            end: const Offset(1.0, 1.0),
          ).animate(_controller)
        : Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(-1.0, -1.0),
          ).animate(_controller);

    widget.onController(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, cons) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (ctx, child) {
          return Transform(
            alignment: Alignment(_transformOriginAnimation.value.dx,
                _transformOriginAnimation.value.dy),
            transform: Matrix4.identity()
              ..scale(_scaleAnimation.value, _scaleAnimation.value)
              ..rotateZ(_rotateAnimation.value.toRadians())
              ..translate(
                  0.0,
                  widget.twisterInType == MTwisterInType.down
                      ? (-cons.maxHeight * (1.0 - _controller.value))
                      : (cons.maxHeight * (1.0 - _controller.value))),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
