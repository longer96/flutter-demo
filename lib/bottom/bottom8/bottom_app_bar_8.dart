import 'package:flutter/material.dart';

class BottomAppBar8 extends StatefulWidget {
  final Function(int index) changeIndex;
  final Function onClickMenu;
  final List<IconData> tabIconsList;
  final Animation<double> animation;
  final Animation<double> menuAnimation;

  const BottomAppBar8({
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

class _BottomAppBar5State extends State<BottomAppBar8> {
  /// menuBtnSize 尺寸
  final double menuBtnSize = 58.0;

  /// icon 尺寸
  final double iconSize = 46.0;

  /// 菜单宽度
  final menuWidth = 70.0;

  /// icon 间隔
  final double iconSpace = 16.0;

  // 生成Flow的数据
  Widget _buildFlowChildren(int index, IconData icon) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      child: RawMaterialButton(
        fillColor: Colors.white,
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
        child: Icon(icon, color: Colors.grey[700]),
        onPressed: () => _onClickMenuIcon(index, icon),
      ),
    );
  }

  void _onClickMenuIcon(int index, IconData icon) {
    // 回传消息
    widget.changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: double.infinity,
        alignment: Alignment.bottomRight,
        width: menuWidth,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// 弹出的菜单
            Positioned.fill(
              child: Flow(
                clipBehavior: Clip.none,
                delegate: FlowAnimatedCircle(
                  widget.animation,
                  iconSpace: iconSpace + iconSize,
                  iconSize: menuBtnSize,
                ),
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
                  fillColor: Colors.redAccent,
                  shape: const CircleBorder(),
                  constraints:
                      BoxConstraints.tight(Size(menuBtnSize, menuBtnSize)),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: widget.menuAnimation,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () => widget.onClickMenu(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlowAnimatedCircle extends FlowDelegate {
  final Animation<double> animation;

  final double iconSpace;
  final double iconSize;

  FlowAnimatedCircle(this.animation,
      {this.iconSpace = 6.0, required this.iconSize})
      : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; ++i) {
      final y = iconSpace * (i + 1) * animation.value;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          0,
          -y + context.size.height / 2 - iconSize / 2,
          0,
        ),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  @override
  bool shouldRepaint(FlowAnimatedCircle oldDelegate) => false;
}
