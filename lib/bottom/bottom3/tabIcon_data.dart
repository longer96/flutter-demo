import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.name = 'name',
    this.imagePath = Icons.error,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  IconData imagePath;
  bool isSelected;
  int index;
  String name;

  /// icon 动画
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      name: '首页',
      imagePath: Icons.home_outlined,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      name: '动态',
      imagePath: Icons.toys_outlined,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: '会员购',
      imagePath: Icons.shopping_cart_outlined,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: '我的',
      imagePath: Icons.live_tv,
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
