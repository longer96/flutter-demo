import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/widget/my_app_bar.dart';
import 'bottom_app_bar_9.dart';
import 'tabIcon_data.dart';

class Bottom9Page extends StatefulWidget {
  @override
  _Bottom9PageState createState() => _Bottom9PageState();
}

class _Bottom9PageState extends State<Bottom9Page> {
  final List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '抖音、小红书',
        backgroundColor: Color(0xff111111),
        elevation: 0,
        brightness: Brightness.dark,
        mainColor: Colors.white,
      ),
      backgroundColor: Color(0xff111111),
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
      child: BottomBar9(
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
