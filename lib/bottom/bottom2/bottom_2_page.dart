import 'package:flutter/material.dart';
import 'package:project/widget/my_app_bar.dart';

import 'bottom_app_bar_2.dart';
import 'tabIcon_data.dart';

class Bottom2Page extends StatefulWidget {
  @override
  _Bottom2PageState createState() => _Bottom2PageState();
}

class _Bottom2PageState extends State<Bottom2Page> {
  int pageIndex = 0;

  List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      name: '首页',
      imagePath: 'assets/img/home_tab/tab_1.png',
      selectedImagePath: 'assets/img/home_tab/tab_1s.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      name: '消息',
      imagePath: 'assets/img/home_tab/tab_2.png',
      selectedImagePath: 'assets/img/home_tab/tab_2s.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: '动态',
      imagePath: 'assets/img/home_tab/tab_3.png',
      selectedImagePath: 'assets/img/home_tab/tab_3s.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: '我的',
      imagePath: 'assets/img/home_tab/tab_4.png',
      selectedImagePath: 'assets/img/home_tab/tab_4s.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '山峦起伏菜单'),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          content(),
          bottomBar(),
        ],
      ),
    );
  }

  Widget content() {
    return Positioned.fill(
      child: Container(
        alignment: Alignment.center,
        child: Text(pageIndex.toString(),
            style: TextStyle(color: Colors.grey[400], fontSize: 80)),
      ),
    );
  }

  Widget bottomBar() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: BottomAppBar2(
          tabIconsList: tabIconsList,
          changeIndex: (index) => onClickBottomBar(index),
        ));
  }

  void onClickBottomBar(int index) {
    if (!mounted) return;

    setState(() => pageIndex = index);
  }
}
