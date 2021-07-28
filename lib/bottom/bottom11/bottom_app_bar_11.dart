import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/bottom/bottom11/tabIcon_data.dart';
import 'package:project/bottom/bottom11/tab_icons.dart';

class BottomAppBar11 extends StatefulWidget {
  const BottomAppBar11({
    Key? key,
    this.selectedPosition = 0,
    required this.selectedCallback,
    required this.iconList,
  }) : super(key: key);

  /// 选中下标
  final int selectedPosition;
  final Function(int selectedPosition) selectedCallback;
  final List<TabIconData> iconList;

  @override
  _BottomAppBar11State createState() => _BottomAppBar11State();
}

class _BottomAppBar11State extends State<BottomAppBar11>
    with TickerProviderStateMixin {
  /// BottomNavigationBar高度
  double barHeight = 56.0;

  /// 指示器尺寸
  double indicatorSize = 6.0;

  /// icon 个数
  int iconLength = 0;

  /// 选中下标
  int selectedPosition = 0;

  /// 记录上一次的选中下标
  int previousSelectedPosition = 0;

  /// 默认图标高度
  double normalIconSize = 26.0;

  double itemWidth = 0;

  late AnimationController controller;

  /// 上半段动画
  late Animation<double> animation1;

  /// 下半段动画
  late Animation<double> animation2;

  /// 指示器 要放到中间 ，边距  减少动画重复计算
  late double iconPadding;

  /// 指示器左右 距离
  double leftWidth = 0;
  double rightWidth = 0;

  @override
  void initState() {
    super.initState();
    iconLength = widget.iconList.length;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        itemWidth = context.size!.width / iconLength;
        iconPadding = (itemWidth - indicatorSize) / 2;
      });
    });

    /// 设置动画时长
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    selectedPosition = widget.selectedPosition;
    previousSelectedPosition = widget.selectedPosition;
    animation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    animation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInCubic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    /// 背景
    final background = Container(
      height: barHeight + MediaQuery.of(context).padding.bottom,
      clipBehavior: Clip.none,
      color: Colors.white,
    );

    children.add(background);

    if (itemWidth == 0) {
      return Stack(clipBehavior: Clip.none, children: children);
    }

    /// 指示器
    children.add(
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (animation1.value < 1) {
            /// 上半段动画
            if (selectedPosition > previousSelectedPosition) {
              // 点击了当前选中按钮右边的按钮

              // debugPrint('longer   上段 >>> 右');
              // 左边距不变
              leftWidth = iconPadding + previousSelectedPosition * itemWidth;

              // 右边距变长
              rightWidth = iconPadding +
                  (iconLength - previousSelectedPosition - 1) * itemWidth -
                  (selectedPosition - previousSelectedPosition) *
                      itemWidth *
                      animation1.value;
            } else {
              // 点击了当前选中按钮左边的按钮
              // debugPrint('longer   上段 >>> 左');
              // 左边距 变短
              leftWidth = iconPadding +
                  previousSelectedPosition * itemWidth -
                  (previousSelectedPosition - selectedPosition) *
                      itemWidth *
                      animation1.value;

              // 右边不变
              rightWidth = iconPadding +
                  (iconLength - previousSelectedPosition - 1) * itemWidth;
            }
          } else {
            /// 下半段动画
            if (selectedPosition > previousSelectedPosition) {
              // 点击了当前选中按钮右边的按钮
              // debugPrint('longer   下段 >>> 右');
              // 左边距变长
              leftWidth = iconPadding +
                  previousSelectedPosition * itemWidth +
                  (selectedPosition - previousSelectedPosition) *
                      itemWidth *
                      animation2.value;

              // 右边距不变
              rightWidth =
                  iconPadding + (iconLength - selectedPosition - 1) * itemWidth;
            } else {
              // 点击了当前选中按钮左边的按钮
              // debugPrint('longer   下段 >>> 左');

              // 左边距 不变
              leftWidth = iconPadding + selectedPosition * itemWidth;

              // 右边距 变大
              rightWidth = iconPadding +
                  (iconLength - previousSelectedPosition - 1) * itemWidth +
                  (previousSelectedPosition - selectedPosition) *
                      itemWidth *
                      animation2.value;
            }
          }

          // debugPrint('longer   左右边距  >>> $leftWidth  $rightWidth');
          return Positioned(
            left: leftWidth,
            right: rightWidth,
            bottom: MediaQuery.of(context).padding.bottom + 6,
            child: child!,
          );
        },
        child: Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(indicatorSize / 2)),
            color: const Color(0xfffe8be9),
          ),
        ),
      ),
    );

    for (var i = 0; i < widget.iconList.length; i++) {
      /// 图标中心点计算
      final rectBg = Rect.fromCenter(
        center: Offset(itemWidth / 2 + (i * itemWidth), barHeight / 2),
        width: itemWidth,
        height: barHeight,
      );

      /// 每个Icon 格子  && title

      children.add(TabIcons(
        tabIconData: widget.iconList[i],
        rect: rectBg,
        isChecked: selectedPosition == i,
        normalIconSize: normalIconSize,
        removeAllSelect: () => _selectedPosition(i),
      ));
    }

    return Stack(clipBehavior: Clip.none, children: children);
  }

  void _selectedPosition(int position) {
    /// 去除重复点击
    if (position == selectedPosition) return;

    /// 振动
    HapticFeedback.mediumImpact();

    previousSelectedPosition = selectedPosition;
    selectedPosition = position;

    controller.forward(from: 0.0);
    widget.selectedCallback(selectedPosition);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
