import 'package:flutter/material.dart';
import 'package:project/widget/my_app_bar.dart';
import 'bottom_bar_3.dart';
import 'tabIcon_data.dart';

class Bottom3Page extends StatefulWidget {
  @override
  _Bottom3PageState createState() => _Bottom3PageState();
}

class _Bottom3PageState extends State<Bottom3Page> {
  final List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '底部菜单 仿B站'),
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
      child: BottomBar3(
        tabIconsList: tabIconsList,
        changeIndex: (index) => onClickBottomBar(index),
        addClick: () {
          debugPrint('点击了中间的按钮');
        },
      ),
    );
  }

  void onClickBottomBar(int index) {
    if (!mounted) return;

    setState(() => pageIndex = index);
  }
}
