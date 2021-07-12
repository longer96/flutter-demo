import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/safe/r_dotted_line_border.dart';

/// 验证widget
/// return
/// [true] 成功
/// [false] 失败
class DemoVerity extends StatefulWidget {
  final Function lister;

  DemoVerity({required this.lister});

  @override
  _DemoVerityState createState() => _DemoVerityState();
}

class _DemoVerityState extends State<DemoVerity> with TickerProviderStateMixin {
  /// 半径
  final double radius = 32.0;

  /// 拖动控制
  /// 左上角点坐标，布局时会自动转换为中心点
  /// 初始值
  Offset offsetCtrInit = Offset.zero;

  /// 拖动控制
  /// 左上角点坐标，布局时会自动转换为中心点
  /// 拖动会变化
  Offset offsetCtr = Offset.zero;

  /// 正确区域 中心点
  Offset offsetAwe = Offset.zero;

  late AnimationController anwerAnimationController;
  late AnimationController animationController;

  /// 错误归位动画
  late final Animation<double> moveAnimation;

  /// 答案区域缩放动画
  late final Animation<double> scaleAnimation;

  /// 两点距离
  double get distance => (offsetAwe - offsetCtr).distance;

  /// 是否滑入正确区域
  bool success = false;

  @override
  void initState() {
    super.initState();

    /// 获取屏幕宽度、高度 像素，以及flutter 对应高度
    // final x2 = window.physicalSize.width / window.devicePixelRatio / 2;
    // final y2 = window.physicalSize.height / window.devicePixelRatio / 2;

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        setState(() {
          offsetCtr = offsetCtrInit;
        });
      }
    });

    moveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Cubic(0.68, 0, 0, 1.5),
      ),
    );

    anwerAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: anwerAnimationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final size = context.size ?? Size.zero;

      final x1 = radius + Random().nextInt((size.width - radius * 2.2).toInt());
      final y1 = radius + Random().nextInt(30);

      /// 正确答案在下半部分区域
      final x2 = radius + Random().nextInt((size.width - radius * 2.6).toInt());
      final y2 = size.height * 0.7 +
          Random().nextInt((size.height * 0.3).toInt()) -
          radius * 1.2 -
          MediaQuery.of(context).padding.bottom;

      setState(() {
        offsetCtr = Offset(x1, y1);
        offsetCtrInit = offsetCtr;
        offsetAwe = Offset(x2, y2);
      });
      anwerAnimationController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    anwerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// 答案区域
          Positioned(
            top: offsetAwe.dy - radius,
            left: offsetAwe.dx - radius,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                width: radius * 2,
                height: radius * 2,
                alignment: const Alignment(0, 0),
                decoration: BoxDecoration(
                  border: RDottedLineBorder.all(
                      width: 1, color: success ? Colors.green : Colors.blue),
                  color: success
                      ? const Color(0xffe9faef)
                      : const Color(0xffe9f5fe),
                  shape: BoxShape.circle,
                ),
                child: success
                    ? const SizedBox()
                    : const Icon(Icons.add, size: 20, color: Colors.blue),
              ),
            ),
          ),

          /// 滑块
          AnimatedBuilder(
            animation: animationController,
            builder: (_, child) {
              return Positioned(
                left: offsetCtr.dx -
                    ((offsetCtr.dx - offsetCtrInit.dx) * moveAnimation.value) -
                    radius,
                top: offsetCtr.dy -
                    ((offsetCtr.dy - offsetCtrInit.dy) * moveAnimation.value) -
                    radius,
                child: child!,
              );
            },
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                /// 答案半径 * 0.9
                final rDistance = radius * 0.9;

                /// 答案区 内
                if ((distance < rDistance) && !success) {
                  success = true;
                  // 震动
                  HapticFeedback.mediumImpact();
                  anwerAnimationController.stop();
                  anwerAnimationController.animateTo(1.0,
                      duration: const Duration());
                }

                /// 答案区 外
                if ((distance >= rDistance) && success) {
                  success = false;
                  if (!anwerAnimationController.isAnimating)
                    anwerAnimationController.repeat(reverse: true);
                }

                if (!mounted) return;
                setState(() {
                  offsetCtr += Offset(details.delta.dx, details.delta.dy);
                });
              },
              onPanEnd: (DragEndDetails details) {
                // debugPrint('longer  结束拖动 是否答案内 >>> $success ');
                // 如果没有在答案内 执行返回位置的动画
                if (!success) {
                  animationController.forward();
                }
                widget.lister(success);
              },
              child: Container(
                width: radius * 2,
                height: radius * 2,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff016df3),
                  shape: BoxShape.circle,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFF616161),
                      offset: Offset(4.0, 4.0),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Image.asset('assets/img/safe_icon.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
