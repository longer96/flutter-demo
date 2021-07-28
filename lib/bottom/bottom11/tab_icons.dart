import 'package:flutter/material.dart';
import 'package:project/bottom/bottom11/tabIcon_data.dart';

class TabIcons extends StatefulWidget {
  const TabIcons({
    Key? key,
    required this.tabIconData,
    required this.removeAllSelect,
    required this.rect,
    required this.normalIconSize,
    required this.isChecked,
  }) : super(key: key);

  final TabIconData tabIconData;
  final Function removeAllSelect;
  final Rect rect;
  final double normalIconSize;

  // 是否选中
  final bool isChecked;

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: widget.rect,
      child: InkWell(
        onTap: () {
          // 去重点击
          if (!widget.isChecked) {
            widget.removeAllSelect();
          }
        },
        child: Align(
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            curve: const Cubic(0.68, 0, 0, 4.6),
            duration: const Duration(milliseconds: 600),
            child: Text(widget.tabIconData.title),
            style: TextStyle(
              fontSize: widget.isChecked ? 17 : 16,
              color: widget.isChecked
                  ? Colors.blueAccent
                  : Colors.blueAccent.withOpacity(0.4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
