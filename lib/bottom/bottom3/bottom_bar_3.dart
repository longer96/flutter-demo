import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tabIcon_data.dart';
import 'menu_clipper.dart';
import 'tab_icons.dart';

/// 底部导航参数
/// 高度：62 + 全面屏底部高度
///
/// 指示器 还有凸出高度
///
class BottomBar3 extends StatefulWidget {
  const BottomBar3({
    Key? key,
    required this.tabIconsList,
    required this.changeIndex,
    required this.addClick,
  }) : super(key: key);

  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;

  @override
  _BottomBar3State createState() => _BottomBar3State();
}

class _BottomBar3State extends State<BottomBar3> with TickerProviderStateMixin {
  /// 刚进来加载时候缩放动画
  late AnimationController animationController;

  /// 中间按钮 点击之后动画
  late AnimationController centerBtnAnimationController;
  late AnimationController centerBtnScaleAnimationController;

  /// 底部子菜单动画
  late Animation<double> animation;

  /// 底部菜单 view
  late OverlayEntry entry;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController.forward();

    centerBtnScaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    centerBtnScaleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        centerBtnScaleAnimationController.reverse();
      }
    });

    centerBtnAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100 * 2),
    );
    centerBtnAnimationController.addStatusListener((status) {
      // debugPrint('longer   >>> $status');
      if (status == AnimationStatus.dismissed) {
        if (!mounted) return;

        entry.remove();
      }
    });

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: centerBtnAnimationController, curve: Curves.fastOutSlowIn));

    entry = OverlayEntry(builder: (_) => getButtomMenu());

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    centerBtnAnimationController.dispose();
    entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: const Offset(0.0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 0.0),
        ],
      ),
      child: Column(
        children: [
          /// 5个按钮
          SizedBox(
            height: 62,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[0],
                      removeAllSelect: () {},
                      onSelect: () {
                        widget.changeIndex(0);
                        setAnimation(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[1],
                      removeAllSelect: () {},
                      onSelect: () {
                        widget.changeIndex(1);
                        setAnimation(1);
                      },
                    ),
                  ),

                  /// 中间的按钮
                  Expanded(child: centerButton()),

                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[2],
                      removeAllSelect: () {},
                      onSelect: () {
                        widget.changeIndex(2);
                        setAnimation(2);
                      },
                    ),
                  ),
                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[3],
                      removeAllSelect: () {},
                      onSelect: () {
                        widget.changeIndex(3);
                        setAnimation(3);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom / 1.6)
        ],
      ),
    );
  }

  Widget line() => Container(height: 20, width: 0.4, color: Colors.grey[400]);

  /// 底部菜单
  Widget getButtomMenu() {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          centerBtnAnimationController.reverse();
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 62.0 + MediaQuery.of(context).padding.bottom / 1.6 + 32.0,
            ),
            child: AnimatedBuilder(
              animation: centerBtnAnimationController,
              builder: (context, child) {
                return Transform(
                  // Y轴位移动画
                  transform: Matrix4.translationValues(
                      0.0, (1.0 - animation.value) * 22.0, 0.0),
                  // 透明动画
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: centerBtnAnimationController,
                          curve: Curves.fastOutSlowIn),
                    ),
                    // 缩放 动画
                    child: ScaleTransition(
                        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                          CurvedAnimation(
                              parent: centerBtnAnimationController,
                              curve: Curves.fastOutSlowIn),
                        ),
                        child: child!),
                  ),
                );
              },
              child: PhysicalShape(
                color: Colors.white,
                elevation: 6.0,
                clipper: MenuClipper(radius: 18.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    menuItem('开直播', Icons.live_tv),
                    line(),
                    menuItem('拍照', Icons.photo_camera_outlined),
                    line(),
                    menuItem('上传', Icons.cloud_upload_outlined),
                    line(),
                    menuItem('模板创作', Icons.account_tree_outlined),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///////////////////

  Widget menuItem(String title, IconData iconData) {
    return GestureDetector(
      onTap: () {
        debugPrint('点击了 >>> $title');
        centerBtnAnimationController.reverse();
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 28, color: Color(0xff2b292b)),
            const SizedBox(height: 4),
            Text(title,
                style: TextStyle(fontSize: 12, color: Color(0xff2b292b)))
          ],
        ),
      ),
    );
  }

  /// 中间的按钮
  Widget centerButton() {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 42,
        height: 42,
        // 刚进入缩放
        child: ScaleTransition(
          alignment: Alignment.center,
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController, curve: Curves.fastOutSlowIn)),
          // 点击之后缩放
          child: ScaleTransition(
            alignment: Alignment.center,
            scale: Tween<double>(begin: 1.0, end: 0.8)
                .animate(centerBtnScaleAnimationController),
            child: ClipPath.shape(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffff43a9),
                      Color(0xffff6997),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.indigo.withOpacity(0.4),
                        offset: const Offset(8.0, 16.0),
                        blurRadius: 16.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      Overlay.of(context)!.insert(entry);
                      widget.addClick();
                      // 执行旋转动画 && 缩放动画
                      centerBtnAnimationController.forward();
                      centerBtnScaleAnimationController.forward();
                    },
                    child: AnimatedBuilder(
                      animation: centerBtnAnimationController,
                      builder: (context, child) {
                        return Transform.rotate(

                            /// calc
                            /// 旋转
                            /// 四分之一 π  >>>   二π
                            angle: (math.pi / 4) +
                                math.pi * 3 / 4 * animation.value,
                            child: child);
                      },
                      child: Image.asset('assets/img/close.png',
                          width: 18, height: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setAnimation(int index) {
    /// 振动
    HapticFeedback.mediumImpact();

    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (widget.tabIconsList[index].index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}
