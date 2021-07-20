import 'package:flutter/material.dart';
import 'package:project/bottom/bottom10/tabIcon_data.dart';

class BottomAppBar10 extends StatefulWidget {
  const BottomAppBar10({
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
  _BottomAppBar10State createState() => _BottomAppBar10State();
}

class _BottomAppBar10State extends State<BottomAppBar10>
    with TickerProviderStateMixin {
  /// BottomNavigationBar高度
  double barHeight = 56.0;

  /// 指示器高度
  double indicatorHeight = 44.0;

  // /// 选中图标颜色
  // Color selectedIconColor = Colors.blue;
  //
  // /// 默认图标颜色
  // Color normalIconColor = Colors.grey;

  /// 选中下标
  int selectedPosition = 0;

  /// 记录上一次的选中下标
  int previousSelectedPosition = 0;

  /// 选中图标高度
  double selectedIconHeight = 28.0;

  /// 默认图标高度
  double normalIconHeight = 25.0;

  double itemWidth = 0;

  late AnimationController controller;
  late Animation<double> animation;

  // TODO
  // final myCurve = Cubic(0.68, 0, 0, 1.6);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      itemWidth =
          (context.size!.width - barHeight) / (widget.iconList.length - 1);
      setState(() {});
    });

    /// 设置动画时长
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    selectedPosition = widget.selectedPosition;
    previousSelectedPosition = widget.selectedPosition;
    animation = Tween(
            begin: selectedPosition.toDouble(),
            end: selectedPosition.toDouble())
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    /// 背景
    final background = Container(
      height: barHeight + MediaQuery.of(context).padding.bottom,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: const Offset(0.0, 0.0),
              blurRadius: 1.0,
              spreadRadius: 0.0),
        ],
      ),
    );

    children.add(background);

    if (itemWidth == 0) {
      return Stack(clipBehavior: Clip.none, children: children);
    }

    /// 指示器
    children.add(
      Positioned(
        left: 6.0 + animation.value * itemWidth,
        // top: (barHeight - indicatorHeight) / 2,
        top: 0,
        child: Container(
          width: indicatorHeight,
          height: indicatorHeight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
        ),
      ),
    );

    for (var i = 0; i < widget.iconList.length; i++) {
      /// 图标中心点计算
      final rect = Rect.fromCenter(
        center: Offset(28.0 + (i * itemWidth), indicatorHeight / 2),
        width: (i == selectedPosition) ? selectedIconHeight : normalIconHeight,
        height: (i == selectedPosition) ? selectedIconHeight : normalIconHeight,
      );

      final rectBg = Rect.fromCenter(
        center: Offset(28.0 + (i * itemWidth), barHeight / 2),
        width: itemWidth - 1,
        height: barHeight,
      );

      /// 每个Icon 格子  && title
      children.add(
        Positioned.fromRect(
          rect: rectBg,
          child: InkWell(
            onTap: () => _selectedPosition(i),
            child: Container(
              alignment: Alignment.bottomCenter,
              // color: Colors.blue.shade100,
              child: Text(widget.iconList[i].title,
                  style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
      );

      /// icon
      children.add(
        AnimatedPositioned.fromRect(
          rect: rect,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              // color: Colors.red.shade100,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Icon(
                    widget.iconList[i].iconData,
                    color: Colors.grey[700],
                    size: constraints.biggest.width,
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    return Stack(clipBehavior: Clip.none, children: children);
  }

  void _selectedPosition(int position) {
    /// 去除重复点击
    if (position == selectedPosition) return;

    previousSelectedPosition = selectedPosition;
    selectedPosition = position;

    /// 执行动画
    animation = Tween(
            begin: previousSelectedPosition.toDouble(),
            end: selectedPosition.toDouble())
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    animation.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    controller.forward(from: 0.0);

    widget.selectedCallback(selectedPosition);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
