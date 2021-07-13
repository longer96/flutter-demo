import 'package:flutter/material.dart';
import 'package:project/widget/my_app_bar.dart';
import 'flow_menu.dart';

/// 半圆菜单
class Bottom5Page extends StatefulWidget {
  @override
  _Bottom5PageState createState() => _Bottom5PageState();
}

class _Bottom5PageState extends State<Bottom5Page> {
  /// 菜单的icon
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.markunread_outlined,
    Icons.notifications,
    Icons.settings,
    Icons.update_sharp,
  ];

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '半圆展开菜单'),
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
    return Positioned(
      left: 0,
      right: 0,
      bottom: MediaQuery.of(context).padding.bottom,
      child: FlowMenu(
        tabIconsList: menuItems,
        changeIndex: (index) => _onClickBottomBar(index),
      ),
    );
  }

  void _onClickBottomBar(int index) {
    if (!mounted) return;

    debugPrint('longer   点击了 >>> $index');
    setState(() => pageIndex = index);
  }
}
