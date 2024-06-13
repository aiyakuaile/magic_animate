import 'package:flutter/material.dart';
import 'package:magic_animate/magic_animate.dart';

class MagicWrap extends StatefulWidget {
  final Widget child;
  final String type;
  const MagicWrap({super.key, required this.child, required this.type});

  @override
  State<MagicWrap> createState() => _MagicWrapState();
}

class _MagicWrapState extends State<MagicWrap> {
  late String type = widget.type;

  @override
  void didUpdateWidget(covariant MagicWrap oldWidget) {
    if (type != widget.type) {
      setState(() {
        type = widget.type;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    switch (type) {
      case '':
        child = widget.child;
        break;
      case 'MAGIC':
        child = MMagicWidget(
            child: child,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            });
        break;
      case 'TWISTERINDOWN':
      case 'TWISTERINUP':
        child = MTwisterInWidget(
            twisterInType: type == 'TWISTERINDOWN'
                ? MTwisterInType.down
                : MTwisterInType.up,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SWAP':
        child = MSwapWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'PUFFIN':
      case 'PUFFOUT':
        child = MPuffWidget(
            type: type == 'PUFFIN' ? MPuffType.puffIn : MPuffType.puffOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'VANISHIN':
      case 'VANISHOUT':
        child = MVanishWidget(
            type: type == 'VANISHIN'
                ? MVanishType.vanishIn
                : MVanishType.vanishOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEOUTUP':
        child = MSpaceWidget(
            type: MSpaceType.spaceOutUp,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEOUTRIGHT':
        child = MSpaceWidget(
            type: MSpaceType.spaceOutRight,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEOUTDOWN':
        child = MSpaceWidget(
            type: MSpaceType.spaceOutDown,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEOUTLEFT':
        child = MSpaceWidget(
            type: MSpaceType.spaceOutLeft,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEINUP':
        child = MSpaceWidget(
            type: MSpaceType.spaceInUp,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEINRIGHT':
        child = MSpaceWidget(
            type: MSpaceType.spaceInRight,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEINDOWN':
        child = MSpaceWidget(
            type: MSpaceType.spaceInDown,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SPACEINLEFT':
        child = MSpaceWidget(
            type: MSpaceType.spaceInLeft,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'BOINGINUP':
        child = MBoingWidget(
            type: MBoingType.inUp,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'BOINGOUTDOWN':
        child = MBoingWidget(
            type: MBoingType.outDown,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'BOMBRIGHTOUT':
        child = MBombWidget(
            type: MBombType.rightOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'BOMBLEFTOUT':
        child = MBombWidget(
            type: MBombType.leftOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINRIGHTOUT':
        child = MTinWidget(
            type: MTinType.tinRightOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINLEFTOUT':
        child = MTinWidget(
            type: MTinType.tinLeftOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINUPOUT':
        child = MTinWidget(
            type: MTinType.tinUpOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINDOWNOUT':
        child = MTinWidget(
            type: MTinType.tinDownOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINRIGHTIN':
        child = MTinWidget(
            type: MTinType.tinRightIn,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINLEFTIN':
        child = MTinWidget(
            type: MTinType.tinLeftIn,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINUPIN':
        child = MTinWidget(
            type: MTinType.tinUpIn,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'TINDOWNIN':
        child = MTinWidget(
            type: MTinType.tinDownIn,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SWASHOUT':
        child = MSwashWidget(
            type: MSwashType.swashOut,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'SWASHIN':
        child = MSwashWidget(
            type: MSwashType.swashIn,
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'FOOLISHIN':
        child = MFoolishWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'HOLEOUT':
        child = MHoleOutWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            child: child);
        break;
      case 'ROTATEDOWN':
        child = MRotateWidget(
          type: MRotateType.rotateDown,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'ROTATEUP':
        child = MRotateWidget(
          type: MRotateType.rotateUp,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'ROTATELEFT':
        child = MRotateWidget(
          type: MRotateType.rotateLeft,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'ROTATERIGHT':
        child = MRotateWidget(
          type: MRotateType.rotateRight,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDEDOWN':
        child = MSlideWidget(
          size: const Size(100, 100),
          type: MSlideType.slideDown,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDEUP':
        child = MSlideWidget(
          size: const Size(100, 100),
          type: MSlideType.slideUp,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDELEFT':
        child = MSlideWidget(
          size: const Size(100, 100),
          type: MSlideType.slideLeft,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDERIGHT':
        child = MSlideWidget(
          size: const Size(100, 100),
          type: MSlideType.slideRight,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDEDOWNRETURN':
        child = MSlideWidget(
          size: const Size(100, 100),
          type: MSlideType.slideDownReturn,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDEUPRETURN':
        child = MSlideWidget(
          size: const Size(100, 100),
          type: MSlideType.slideUpReturn,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDELEFTRETURN':
        child = MSlideWidget(
          size: const Size(100, 100),
          type: MSlideType.slideLeftReturn,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          child: child,
        );
        break;
      case 'SLIDERIGHTRETURN':
        child = MSlideWidget(
          type: MSlideType.slideRightReturn,
          onController: (controller) {
            controller.forward().whenCompleteOrCancel(reset);
          },
          size: const Size(100, 100),
          child: child,
        );
        break;

      case 'PERSPECTIVEDOWN':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveDown,
            child: child);
        break;
      case 'PERSPECTIVEUP':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveUp,
            child: child);
        break;
      case 'PERSPECTIVELEFT':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveLeft,
            child: child);
        break;
      case 'PERSPECTIVERIGHT':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveRight,
            child: child);
        break;
      case 'PERSPECTIVEDOWNRETURN':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveDownReturn,
            child: child);
        break;
      case 'PERSPECTIVEUPRETURN':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveUpReturn,
            child: child);
        break;
      case 'PERSPECTIVELEFTRETURN':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveLeftReturn,
            child: child);
        break;
      case 'PERSPECTIVERIGHTRETURN':
        child = MPerspectiveWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MPerspectiveType.perspectiveRightReturn,
            child: child);
        break;
      case 'OPENDOWNLEFT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openDownLeft,
            child: child);
        break;
      case 'OPENDOWNRIGHT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openDownRight,
            child: child);
        break;
      case 'OPENUPLEFT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openUpLeft,
            child: child);
        break;
      case 'OPENUPRIGHT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openUpRight,
            child: child);
        break;
      case 'OPENDOWNLEFTRETURN':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openDownLeftReturn,
            child: child);
        break;
      case 'OPENDOWNRIGHTRETURN':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openDownRightReturn,
            child: child);
        break;
      case 'OPENUPLEFTRETURN':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openUpLeftReturn,
            child: child);
        break;
      case 'OPENUPRIGHTRETURN':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openUpRightReturn,
            child: child);
        break;
      case 'OPENDOWNLEFTOUT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openDownLeftOut,
            child: child);
        break;
      case 'OPENDOWNRIGHTOUT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openDownRightOut,
            child: child);
        break;
      case 'OPENUPLEFTOUT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openUpLeftOut,
            child: child);
        break;
      case 'OPENUPRIGHTOUT':
        child = MOpenWidget(
            onController: (controller) {
              controller.forward().whenCompleteOrCancel(reset);
            },
            type: MOpenType.openUpRightOut,
            child: child);
        break;
    }
    return child;
  }

  reset() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        type = '';
      });
    });
  }
}
