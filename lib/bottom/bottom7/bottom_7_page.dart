import 'package:flutter/material.dart';
import 'package:project/widget/my_app_bar.dart';
import 'bottom_app_bar_7.dart';

/// flutter 圈圈
class Bottom7Page extends StatefulWidget {
  @override
  _Bottom7PageState createState() => _Bottom7PageState();
}

class _Bottom7PageState extends State<Bottom7Page> {
  int pageIndex = 0;

  /// 图标
  final List<IconData> iconList = [
    Icons.home_outlined,
    Icons.add,
    Icons.access_alarms,
    Icons.settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '圈圈菜单'),
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
    final double width = MediaQuery.of(context).size.width;
    return Positioned(
      left: width * 0.2,
      right: width * 0.2,
      bottom: 10.0 + MediaQuery.of(context).padding.bottom,
      child: BottomAppBar7(
        iconList: iconList,
        selectedPosition: 1,
        selectedCallback: (position) => onClickBottomBar(position),
      ),
    );
  }

  void onClickBottomBar(int index) {
    if (!mounted) return;

    debugPrint('longer   点击了 >>> $index');
    setState(() => pageIndex = index);
  }
}
