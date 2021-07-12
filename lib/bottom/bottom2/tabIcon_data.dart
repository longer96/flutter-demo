import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.name = 'name',
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
    this.iconAnimationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;
  String name;

  /// 小点点动画
  AnimationController? animationController;

  /// icon 动画
  AnimationController? iconAnimationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      name: '首页',
      imagePath: 'assets/img/home_tab/tab_1.png',
      selectedImagePath: 'assets/img/home_tab/tab_1s.png',
      index: 0,
      isSelected: true,
      animationController: null,
      iconAnimationController: null,
    ),
    TabIconData(
      name: '动态',
      imagePath: 'assets/img/home_tab/tab_2.png',
      selectedImagePath: 'assets/img/home_tab/tab_2s.png',
      index: 1,
      isSelected: false,
      animationController: null,
      iconAnimationController: null,
    ),
    TabIconData(
      name: '消息',
      imagePath: 'assets/img/home_tab/tab_3.png',
      selectedImagePath: 'assets/img/home_tab/tab_3s.png',
      index: 2,
      isSelected: false,
      animationController: null,
      iconAnimationController: null,
    ),
    TabIconData(
      name: '我的',
      imagePath: 'assets/img/home_tab/tab_4.png',
      selectedImagePath: 'assets/img/home_tab/tab_4s.png',
      index: 3,
      isSelected: false,
      animationController: null,
      iconAnimationController: null,
    ),
  ];
}
