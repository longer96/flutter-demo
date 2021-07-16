import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.iconData = Icons.add,
    this.index = 0,
    this.title = '',
  });

  IconData iconData;
  int index;
  String title;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      iconData: Icons.water_damage_outlined,
      index: 0,
      title: 'Home',
    ),
    TabIconData(
      iconData: Icons.wallet_giftcard,
      index: 1,
      title: 'Circle',
    ),
    TabIconData(
      iconData: Icons.add,
      index: 2,
      title: 'Release',
    ),
    TabIconData(
      iconData: Icons.add_alert_outlined,
      index: 3,
      title: 'Notice',
    ),
    TabIconData(
      iconData: Icons.widgets_outlined,
      index: 3,
      title: 'Center',
    ),
  ];
}
