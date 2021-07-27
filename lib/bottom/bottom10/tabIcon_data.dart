import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.iconData = Icons.add,
    this.index = 0,
    this.title = '',
    this.animationController,
  });

  IconData iconData;
  int index;
  String title;

  /// icon 动画
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      iconData: Icons.water_damage_outlined,
      index: 0,
      title: 'Home',
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.wallet_giftcard,
      index: 1,
      title: 'Circle',
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.add,
      index: 2,
      title: 'Release',
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.add_alert_outlined,
      index: 3,
      title: 'Notice',
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.widgets_outlined,
      index: 4,
      title: 'Center',
      animationController: null,
    ),
  ];
}
