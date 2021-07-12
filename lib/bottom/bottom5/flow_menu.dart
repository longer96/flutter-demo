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
  // 动画变量,以及初始化和销毁
  late AnimationController _ctrlAnimationCircle;

  @override
  void initState() {
    super.initState();
    _ctrlAnimationCircle = AnimationController(
      // 初始化动画变量
      lowerBound: 0,
      upperBound: 80,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _ctrlAnimationCircle.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrlAnimationCircle.dispose();
    super.dispose();
  }

  // 生成Flow的数据
  Widget _buildFlowChildren(int index, IconData icon) {
    return Container(
      child: Icon(
        icon,
        color: Colors.primaries[index % Colors.primaries.length],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      constraints: BoxConstraints(
        minHeight: 60,
        minWidth: 0,
        maxWidth: double.infinity,
        maxHeight: 200,
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Flow(
              delegate: FlowAnimatedCircle(_ctrlAnimationCircle.value),
              children: widget.tabIconsList
                  .asMap()
                  .keys
                  .map<Widget>((int index) =>
                      _buildFlowChildren(index, widget.tabIconsList[index]))
                  .toList(),
            ),
          ),
          Positioned.fill(
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  // 点击后让动画可前行或回退
                  _ctrlAnimationCircle.status == AnimationStatus.completed
                      ? _ctrlAnimationCircle.reverse()
                      : _ctrlAnimationCircle.forward();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FlowAnimatedCircle extends FlowDelegate {
  final double radius; //绑定半径,让圆动起来
  FlowAnimatedCircle(this.radius);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (radius == 0) {
      return;
    }
    double x = 0; //开始(0,0)在父组件的中心
    double y = 0;
    for (int i = 0; i < context.childCount; i++) {
      x = radius * cos(i * pi / (context.childCount - 1)); //根据数学得出坐标
      y = radius * sin(i * pi / (context.childCount - 1)); //根据数学得出坐标
      context.paintChild(i, transform: Matrix4.translationValues(x, -y, 0));
    } //使用Matrix定位每个子组件
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
