import 'package:flutter/material.dart';

class BottomAppBar1 extends StatefulWidget {
  final Function(int index) changeIndex;
  final Function onClickMenu;
  final List<IconData> tabIconsList;
  final Animation<double> animation;

  const BottomAppBar1({
    Key? key,
    required this.tabIconsList,
    required this.changeIndex,
    required this.onClickMenu,
    required this.animation,
  }) : super(key: key);

  @override
  _BottomAppBar1State createState() => _BottomAppBar1State();
}

class _BottomAppBar1State extends State<BottomAppBar1> {
  /// 最后选择icon
  IconData lastTapped = Icons.home;

  /// icon 尺寸
  final double iconSize = 48.0;

  /// icon 间隔
  final double iconSpace = 6.0;

  @override
  Widget build(BuildContext context) {
    List<Widget> iconList = widget.tabIconsList
        .asMap()
        .keys
        .map<Widget>(
            (int index) => flowMenuItem(index, widget.tabIconsList[index]))
        .toList();

    iconList.add(menuBtn());

    return Container(
      width: double.infinity,
      height: 68.0,
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      child: Flow(
        clipBehavior: Clip.none,
        delegate: FlowMenuDelegate(
          animation: widget.animation,
          iconSpace: iconSpace + iconSize,
        ),
        children: iconList,
      ),
    );
  }

  /// 生成Popmenu数据
  Widget flowMenuItem(int index, IconData icon) {
    return RawMaterialButton(
      fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
      shape: const CircleBorder(),
      constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
      child: Icon(icon, color: Colors.white, size: 26.0),
      onPressed: () => _onClickMenuIcon(index, icon),
    );
  }

  /// 生成菜单按钮
  Widget menuBtn() {
    return RawMaterialButton(
      fillColor: Colors.blue,
      shape: const CircleBorder(),
      constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: widget.animation,
        color: Colors.white,
        size: 26,
      ),
      onPressed: () => widget.onClickMenu(),
    );
  }

  void _onClickMenuIcon(int index, IconData icon) {
    // 过滤重复选中
    if (lastTapped == icon) return;

    setState(() => lastTapped = icon);

    // 回传消息
    widget.changeIndex(index);
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({
    required this.animation,
    this.iconSpace = 6.0,
  }) : super(repaint: animation);

  final double iconSpace;
  final Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    // 起始位置
    final initx = 16.0;
    // 横向展开,y不变
    final inity = 6.0;

    if (animation.value == 0) {
      context.paintChild(
        context.childCount - 1,
        transform: Matrix4.translationValues(initx, inity, 0),
      );
      return;
    }

    for (int i = 0; i < context.childCount; ++i) {
      final x = iconSpace * i * animation.value;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(x + initx, inity, 0),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}
