import 'dart:math';
import 'package:flutter/material.dart';

class BottomAppBar5 extends StatefulWidget {
  final Function(int index) changeIndex;
  final Function onClickMenu;
  final List<IconData> tabIconsList;
  final Animation<double> animation;
  final Animation<double> menuAnimation;

  const BottomAppBar5({
    Key? key,
    required this.tabIconsList,
    required this.changeIndex,
    required this.onClickMenu,
    required this.animation,
    required this.menuAnimation,
  }) : super(key: key);

  @override
  _BottomAppBar5State createState() => _BottomAppBar5State();
}

class _BottomAppBar5State extends State<BottomAppBar5> {
  /// menuBtnSize 尺寸
  final double menuBtnSize = 52.0;

  /// icon 尺寸
  final double iconSize = 46.0;

  /// 最后选择icon
  IconData lastTapped = Icons.home;

  /// 菜单高度
  final menuHeight = 220.0;

  // 生成Flow的数据
  Widget _buildFlowChildren(int index, IconData icon) {
    return Container(
      alignment: Alignment.center,
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue[400],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
        child: Icon(icon, color: Colors.white),
        onPressed: () => _onClickMenuIcon(index, icon),
      ),
    );
  }

  void _onClickMenuIcon(int index, IconData icon) {
    // 过滤重复选中
    if (lastTapped == icon) return;

    setState(() => lastTapped = icon);

    // 回传消息
    widget.changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: menuHeight,
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// 弹出的菜单
          Positioned.fill(
            child: Flow(
              clipBehavior: Clip.none,
              delegate: FlowAnimatedCircle(widget.animation),
              children: widget.tabIconsList
                  .asMap()
                  .keys
                  .map((index) =>
                      _buildFlowChildren(index, widget.tabIconsList[index]))
                  .toList(),
            ),
          ),

          /// 菜单按钮
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RawMaterialButton(
                fillColor: Colors.blue[600],
                shape: const CircleBorder(),
                constraints:
                    BoxConstraints.tight(Size(menuBtnSize, menuBtnSize)),
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: widget.menuAnimation,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: () => widget.onClickMenu(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlowAnimatedCircle extends FlowDelegate {
  final Animation<double> animation;

  /// icon 尺寸
  final double iconSize = 48.0;

  /// 菜单左右边距
  final paddingHorizontal = 8.0;

  FlowAnimatedCircle(this.animation) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    // debugPrint('longer   context.size >>> ${context.size}');

    // 等于0，也就是收起来的时候不绘制
    final progress = animation.value;
    if (progress == 0) return;

    final xRadius = context.size.width / 2 - paddingHorizontal;
    final yRadius = context.size.height - iconSize;

    // 开始(0,0)在父组件的中心
    double x = 0;
    double y = 0;

    final total = context.childCount + 1;

    for (int i = 0; i < context.childCount; i++) {
      x = progress * cos(pi * (total - i - 1) / total) * xRadius;
      y = progress * sin(pi * (total - i - 1) / total) * yRadius;

      // 使用Matrix定位每个子组件
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          x,
          -y + (context.size.height / 2) - (iconSize / 2),
          0,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(FlowAnimatedCircle oldDelegate) => false;
}
