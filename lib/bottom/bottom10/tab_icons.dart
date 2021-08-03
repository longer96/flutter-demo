import 'package:flutter/material.dart';
import 'package:project/bottom/bottom10/tabIcon_data.dart';

class TabIcons extends StatefulWidget {
  const TabIcons({
    Key? key,
    required this.tabIconData,
    required this.removeAllSelect,
    required this.rect,
    required this.normalIconSize,
    required this.iconMarginTop,
    required this.isChecked,
  }) : super(key: key);

  final TabIconData tabIconData;
  final Function removeAllSelect;
  final Rect rect;
  final double normalIconSize;

  // icon 距离顶部
  final double iconMarginTop;

  // 是否选中
  final bool isChecked;

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController?.reset();
    widget.tabIconData.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: widget.rect,
      child: InkWell(
        onTap: () {
          // 去重点击
          if (!widget.isChecked) {
            setAnimation();
            widget.removeAllSelect();
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(widget.tabIconData.title,
                  style: TextStyle(fontSize: 12)),
            ),

            /// 图标
            Positioned(
              left: 0,
              right: 0,
              top: widget.iconMarginTop,
              child: Center(
                child: IgnorePointer(
                  ignoring: true,
                  child: Container(
                    width: widget.normalIconSize,
                    height: widget.normalIconSize,
                    // color: Colors.red.withOpacity(0.1),
                    child: RotationTransition(
                      turns: Tween<double>(begin: -0.12, end: 0.0).animate(
                          CurvedAnimation(
                              parent: widget.tabIconData.animationController!,
                              curve: const Interval(0.75, 1.0,
                                  curve: Curves.easeInCubic))),
                      child: RotationTransition(
                        turns: Tween<double>(begin: 0.12, end: -0.12).animate(
                            CurvedAnimation(
                                parent: widget.tabIconData.animationController!,
                                curve: const Interval(0.25, 0.75,
                                    curve: Curves.easeInCubic))),
                        child: RotationTransition(
                          turns: Tween<double>(begin: 0.0, end: 0.12).animate(
                              CurvedAnimation(
                                  parent:
                                      widget.tabIconData.animationController!,
                                  curve: const Interval(0, 0.25,
                                      curve: Curves.easeInCubic))),
                          child: Icon(
                            widget.tabIconData.iconData,
                            color: Colors.grey[700],
                            // size: constraints.biggest.width,
                            size: widget.normalIconSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
