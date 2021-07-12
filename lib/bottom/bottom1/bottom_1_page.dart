import 'package:flutter/material.dart';
import 'package:project/bottom/bottom1/bottom_app_bar_1.dart';
import 'package:project/widget/my_app_bar.dart';

class Bottom1Page extends StatefulWidget {
  @override
  _Bottom1PageState createState() => _Bottom1PageState();
}

class _Bottom1PageState extends State<Bottom1Page> {
  /// 菜单的icon
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.markunread_outlined,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '右侧展开菜单'),
      body: Stack(
        children: [
          content(),
          bottomBar(),
        ],
      ),
    );
  }

  Widget content() {
    return Container(
      alignment: Alignment.center,
      child: Text(pageIndex.toString(),
          style: TextStyle(color: Colors.grey[400], fontSize: 80)),
    );
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
          left: 12.0,
        ),
        child: DemoFlowPopMenu(
          tabIconsList: menuItems,
          changeIndex: (index) => _onClickBottomBar(index),
        ),
      ),
    );
  }

  void _onClickBottomBar(int index) {
    if (!mounted) return;

    debugPrint('longer   点击了 >>> $index');
    setState(() => pageIndex = index);
  }
}
