import 'package:flutter/material.dart';

class DemoFlowPopMenu extends StatefulWidget {
  final Function(int index) changeIndex;
  final List<IconData> tabIconsList;

  const DemoFlowPopMenu({
    Key? key,
    required this.tabIconsList,
    required this.changeIndex,
  }) : super(key: key);

  @override
  _DemoFlowPopMenuState createState() => _DemoFlowPopMenuState();
}

class _DemoFlowPopMenuState extends State<DemoFlowPopMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  /// 最后选择icon
  IconData lastTapped = Icons.home;

  /// icon 尺寸
  final double iconSize = 48.0;

  /// icon 间隔
  final double iconSpace = 6.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      /// 动画展开、折叠时长
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onClickMenuIcon(int index, IconData icon) {
    // 过滤重复选中
    if (lastTapped == icon) return;

    if (icon != Icons.menu) {
      // 回传消息
      widget.changeIndex(index);

      setState(() => lastTapped = icon);
    }
    if (_animationController.status == AnimationStatus.completed) {
      /// 收拢
      _animationController.reverse();
    } else {
      /// 展开
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0 + MediaQuery.of(context).padding.bottom,
      alignment: Alignment.centerLeft,
      child: Flow(
        delegate: FlowMenuDelegate(
          animation: animation,
          iconSpace: iconSpace,
        ),
        children: widget.tabIconsList
            .asMap()
            .keys
            .map<Widget>(
                (int index) => flowMenuItem(index, widget.tabIconsList[index]))
            .toList(),
      ),
    );
  }

  /// 生成Popmenu数据
  Widget flowMenuItem(int index, IconData icon) {
    late Widget iconBtn;
    if (icon == Icons.menu) {
      iconBtn = AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animationController,
        color: Colors.white,
        size: 26,
      );
    } else {
      iconBtn = Icon(icon, color: Colors.white, size: 26.0);
    }

    return RawMaterialButton(
      fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
      // splashColor: Colors.amber[100],
      shape: const CircleBorder(),
      constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
      child: iconBtn,
      onPressed: () => _onClickMenuIcon(index, icon),
    );
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
    final inity = 8.0;

    for (int i = 0; i < context.childCount; ++i) {
      final x =
          (context.getChildSize(i)!.width + iconSpace) * i * animation.value;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(x + initx, inity, 0),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(
      constraints.maxWidth,
      constraints.maxHeight,
    );
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) =>
      animation != oldDelegate.animation;
}
