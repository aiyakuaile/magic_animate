
# Magic Animate

Beautiful animations inspired on magic.css, every animation is a customizable widget.

## Features
Use Flutter to fully implement the interactive effects of the Magic.css animation library

[Preview Effects](https://aiyakuaile.github.io/magic/)


## Getting started
```dart
import 'package:magic_animate/magic_animate.dart';
```
## Supported animations
```agsl
    MBoingWidget
    MBombWidget
    MFoolishWidget
    MHole_outWidget
    MMagicWidget
    MOpenWidget
    MPerspectiveWidget
    MPuffWidget
    MRotateWidget
    MSlideWidget
    MSpaceWidget
    MSwapWidget
    MSwashWidget
    MTinWidget
    MTwisterInWidget
    MVanishWidget
```
## Use
```dart
class MXXXWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final MagicControllerFn onController;
  final MXXXType type;
  const MXXXWidget(
      {super.key,
      required this.child,
      required this.onController,
      required this.type,
      this.duration = const Duration(milliseconds: 1000)});
}
```

Each widget has an `onController` function that returns an `AnimationController`, allowing you to control the animation's state yourself using the `AnimationController`.

```dart
  MXXXWidget(
    ...
    onController: (AnimationController controller) {
      // start animation
      controller.forward();
    }
    ...
  )
```