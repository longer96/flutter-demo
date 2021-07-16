import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/bottom/bottom2/tab_clipper.dart';

import 'tabIcon_data.dart';
import 'tab_icons.dart';

/// 底部导航参数
/// 高度：62 + 全面屏底部高度
///
/// 指示器 还有凸出高度
///
class BottomAppBar2 extends StatefulWidget {
  const BottomAppBar2({
    Key? key,
    required this.tabIconsList,
    required this.changeIndex,
  }) : super(key: key);

  final Function(int index) changeIndex;
  final List<TabIconData> tabIconsList;

  @override
  _BottomAppBar2State createState() => _BottomAppBar2State();
}

class _BottomAppBar2State extends State<BottomAppBar2>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  /// 初始化选中的icon  1,2,3,4
  int selectIcon = 0;
  int selectIconAfter = 0;
  // [easeInOutBack] https://flutter.github.io/assets-for-api-docs/assets/animation/curve_ease_in_out_back.mp4
  final myCurve = Cubic(0.68, 0, 0, 1.3);

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        selectIcon = selectIconAfter;
      }
    });
    animationController.animateTo(1.0, duration: Duration.zero);

    WidgetsBinding.instance!.addPostFrameCallback((_) => getInitState());

    super.initState();
  }

  Future<bool> getInitState() async {
    widget.tabIconsList[selectIcon].animationController?.forward();
    widget.tabIconsList[selectIcon].iconAnimationController?.forward();
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    widget.tabIconsList.forEach((TabIconData tab) {
      tab.animationController?.dispose();
      tab.iconAnimationController?.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return PhysicalShape(
          color: Colors.white,
          elevation: 26.0,
          clipper: TabClipper(
            radius: 26.0,
            padding: const EdgeInsets.only(left: 10, right: 10),
            position: Tween<double>(
                    begin: selectIcon.toDouble(),
                    end: selectIconAfter.toDouble())
                .animate(CurvedAnimation(
                    parent: animationController, curve: myCurve))
                .value,
          ),
          child: child,
        );
      },

      /// icon 按钮
      child: Column(
        children: [
          SizedBox(
            height: 62,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[0],
                      removeAllSelect: () {
                        // setRemoveAllSelection(widget.tabIconsList[0]);
                      },
                      onSelect: () {
                        widget.changeIndex(0);
                        setAnimation(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[1],
                      removeAllSelect: () {
                        // setRemoveAllSelection(widget.tabIconsList[1]);
                      },
                      onSelect: () {
                        widget.changeIndex(1);
                        setAnimation(1);
                      },
                    ),
                  ),
                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[2],
                      removeAllSelect: () {
                        // setRemoveAllSelection(widget.tabIconsList[2]);
                      },
                      onSelect: () {
                        widget.changeIndex(2);
                        setAnimation(2);
                      },
                    ),
                  ),
                  Expanded(
                    child: TabIcons(
                      tabIconData: widget.tabIconsList[3],
                      removeAllSelect: () {
                        // setRemoveAllSelection(widget.tabIconsList[3]);
                      },
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

  void setRemoveAllSelection(TabIconData tabIconData) {}

  void setAnimation(int index) {
    /// 振动
    HapticFeedback.mediumImpact();

    /// 之前选中的icon 执行缩小动画
    widget.tabIconsList[selectIcon].iconAnimationController?.reverse();

    selectIconAfter = index;

    /// 指示器移动动画
    animationController.reset();
    animationController.forward();

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
