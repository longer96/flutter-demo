import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tabIcon_data.dart';
import 'tab_icons.dart';

/// 底部导航参数
/// 高度：62 + 全面屏底部高度
///
/// 指示器 还有凸出高度
///
class BottomBar9 extends StatefulWidget {
  const BottomBar9({
    Key? key,
    required this.tabIconsList,
    required this.changeIndex,
    required this.addClick,
  }) : super(key: key);

  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;

  @override
  _BottomBar9State createState() => _BottomBar9State();
}

class _BottomBar9State extends State<BottomBar9> with TickerProviderStateMixin {
  final borderRadius = BorderRadius.circular(6);

  /// 刚进来加载时候缩放动画
  late AnimationController animationController;

  /// 中间按钮 点击之后动画
  late AnimationController centerBtnScaleAnimationController;

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
      } else if (status == AnimationStatus.dismissed) {
        /// 中间动画执行完毕，执行点击事件回调
        widget.addClick();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff161616),
      child: Column(
        children: [
          /// 5个按钮
          SizedBox(
            height: 62,
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

          SizedBox(height: MediaQuery.of(context).padding.bottom / 1.6)
        ],
      ),
    );
  }

  /// 中间的按钮
  Widget centerButton() {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            /// 缩放动画
            centerBtnScaleAnimationController.forward();

            /// 振动
            HapticFeedback.mediumImpact();
          },
          child: SizedBox(
            width: 40,
            height: 28,
            // 刚进入缩放
            child: ScaleTransition(
              alignment: Alignment.center,
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animationController,
                      curve: Curves.fastOutSlowIn)),
              // 点击之后缩放
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: Tween<double>(begin: 1.0, end: 1.18)
                    .animate(centerBtnScaleAnimationController),
                child: Stack(
                  children: [
                    /// 边框1
                    Container(
                      transform: Matrix4.translationValues(-2.2, 0.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        border: Border.all(
                            color: Color(0xff18a4b6).withOpacity(0.8),
                            width: 1.8),
                      ),
                    ),

                    /// 边框2
                    Container(
                      transform: Matrix4.translationValues(2.2, 0.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        border: Border.all(
                            color: Color(0xffc82440).withOpacity(0.8),
                            width: 1.8),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          border: Border.all(color: Colors.white, width: 1.8),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff162729),
                              Color(0xff1f1e22),
                              Color(0xff2a181d),
                            ],
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                          )),
                      child: Icon(Icons.add, size: 20, color: Colors.white),
                    ),
                  ],
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
