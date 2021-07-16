import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.name = 'name',
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  bool isSelected;
  int index;
  String name;

  /// icon 动画
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      name: '首页',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      name: '朋友',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: '消息',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: '我',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
