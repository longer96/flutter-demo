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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!widget.tabIconData.isSelected) {
            widget.onSelect();
          }
        },
        child: IgnorePointer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 图标
              Icon(
                widget.tabIconData.imagePath,
                size: 28,
                color: widget.tabIconData.isSelected
                    ? Color(0xfff87397)
                    : Colors.grey,
              ),

              /// 文字
              Text(
                widget.tabIconData.name,
                style: TextStyle(
                    fontSize: 12,
                    color: widget.tabIconData.isSelected
                        ? Color(0xfff87397)
                        : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
