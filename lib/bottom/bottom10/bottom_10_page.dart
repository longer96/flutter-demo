import 'package:flutter/material.dart';
import 'package:project/bottom/bottom10/tabIcon_data.dart';
import 'package:project/widget/my_app_bar.dart';
import 'bottom_app_bar_10.dart';

/// flutter 圈圈
class Bottom10Page extends StatefulWidget {
  @override
  _Bottom10PageState createState() => _Bottom10PageState();
}

class _Bottom10PageState extends State<Bottom10Page> {
  int pageIndex = 0;

  /// 图标
  final List<TabIconData> iconList = TabIconData.tabIconsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '圆圈圈圈菜单'),
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
    // final double width = MediaQuery.of(context).size.width;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: BottomAppBar10(
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
