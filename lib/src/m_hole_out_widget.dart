import 'dart:math';

import 'package:flutter/widgets.dart';

import 'magic_type.dart';

class MHoleOutWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  const MHoleOutWidget(
      {super.key,
      required this.child,
      required this.onController,
      this.duration = const Duration(milliseconds: 1000)});

  @override
  State<MHoleOutWidget> createState() => _MHoleOutWidgetState();
}

class _MHoleOutWidgetState extends State<MHoleOutWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: widget.duration, vsync: this);

  @override
  void initState() {
    super.initState();
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
            ..rotateY(_controller.value * pi)
            ..scale(1.0 - _controller.value, 1.0 - _controller.value, 1.0),
          alignment: Alignment.center,
          child: Opacity(opacity: 1.0 - _controller.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
