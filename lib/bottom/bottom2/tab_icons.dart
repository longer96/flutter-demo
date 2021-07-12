import 'package:flutter/material.dart';

import 'tabIcon_data.dart';

class TabIcons extends StatefulWidget {
  const TabIcons({
    Key? key,
    required this.tabIconData,
    required this.removeAllSelect,
    required this.onSelect,
  }) : super(key: key);

  final TabIconData tabIconData;
  // 动画执行之后回调
  final Function removeAllSelect;
  final Function onSelect;

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  // [easeInOutBack] https://flutter.github.io/assets-for-api-docs/assets/animation/curve_ease_in_out_back.mp4
  final myCurve = Cubic(0.68, 0, 0, 1.5);

  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController?.reverse();
        }
      });

    widget.tabIconData.iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController?.forward();
    widget.tabIconData.iconAnimationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!widget.tabIconData.isSelected) {
            setAnimation();
            widget.onSelect();
          }
        },
        child: IgnorePointer(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              /// 图标
              ScaleTransition(
                alignment: Alignment.bottomCenter,
                scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                  CurvedAnimation(
                    parent: widget.tabIconData.iconAnimationController!,
                    curve: widget.tabIconData.isSelected
                        ? myCurve
                        : Curves.easeInBack,
                  ),
                ),
                child: Image.asset(widget.tabIconData.isSelected
                    ? widget.tabIconData.selectedImagePath
                    : widget.tabIconData.imagePath),
              ),
              Positioned(
                top: 4,
                left: 6,
                right: 0,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.tabIconData.animationController!,
                          curve:
                              Interval(0.2, 1.0, curve: Curves.fastOutSlowIn))),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color(0xFF2633C5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 6,
                bottom: 8,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.tabIconData.animationController!,
                          curve:
                              Interval(0.5, 0.8, curve: Curves.fastOutSlowIn))),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Color(0xFF2633C5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 8,
                bottom: 0,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.tabIconData.animationController!,
                          curve:
                              Interval(0.5, 0.6, curve: Curves.fastOutSlowIn))),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Color(0xFF2633C5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
