import 'dart:math';
import 'package:flutter/material.dart';

class FlowMenu extends StatefulWidget {
  final Function(int index) changeIndex;
  final List<IconData> tabIconsList;

  const FlowMenu({
    Key? key,
    required this.tabIconsList,
    required this.changeIndex,
  }) : super(key: key);

  @override
  _FlowMenuState createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu> with TickerProviderStateMixin {
  /// 动画变量,以及初始化和销毁
  late AnimationController _animationController;

  /// icon 尺寸
  final double iconSize = 48.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 生成Flow的数据
  Widget _buildFlowChildren(int index, IconData icon) {
    debugPrint('longer   >>> ${MediaQuery.of(context).size}');
    return Container(
      alignment: Alignment.center,
      child: RawMaterialButton(
        fillColor: Colors.blue[400],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
        child: Icon(icon, color: Colors.white),
        onPressed: () => _onClickMenuIcon(index, icon),
      ),
    );
  }

  void _onClickMenuIcon(int index, IconData icon) {
    // 过滤重复选中
    // if (lastTapped == icon) return;
    //
    // if (icon != Icons.menu) {
    //   // 回传消息
    //   widget.changeIndex(index);
    //
    //   setState(() => lastTapped = icon);
    // }
    debugPrint('longer   点击了 >>> $index');
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
      height: 220.0,
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: Stack(
        children: [
          /// 弹出的菜单
          Positioned.fill(
            child: Flow(
              delegate: FlowAnimatedCircle(
                  // Tween<double>(begin: 0.0, end: 80.0)
                  //     .animate(CurvedAnimation(
                  //         parent: _animationController,
                  //         curve: Curves.fastOutSlowIn))
                  //     .value,
                  _animationController.value),
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
                fillColor: Colors.amber[700],
                shape: const CircleBorder(),
                constraints: BoxConstraints.tight(Size(iconSize, iconSize)),
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: () {
                  setState(() {
                    // 点击后让动画可前行或回退
                    _animationController.status == AnimationStatus.completed
                        ? _animationController.reverse()
                        : _animationController.forward();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlowAnimatedCircle extends FlowDelegate {
  final double progress;

  /// 绑定半径,让圆动起来
  final Size size = Size(370, 120);

  FlowAnimatedCircle(this.progress);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (progress == 0) {
      return;
    }
    // 开始(0,0)在父组件的中心
    double x = 0;
    double y = 0;
    for (int i = 0; i < context.childCount; i++) {
      // x = progress * cos(i * pi / (context.childCount - 1)) * (size.width / 2);
      // y = progress * sin(i * pi / (context.childCount - 1)) * size.height;

      x = progress *
          cos((i + 1) * pi / (context.childCount + 1)) *
          (size.width / 2);
      y = progress * sin((i + 1) * pi / (context.childCount + 1)) * 160;

      // 使用Matrix定位每个子组件
      context.paintChild(
        i,
        transform:
            Matrix4.translationValues(x, -y + (48 / 2) + (size.height / 2), 0),
      );
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
