import 'package:flutter/material.dart';
import 'package:project/widget/my_app_bar.dart';
import 'bottom_app_bar_5.dart';

/// 半圆菜单
class Bottom5Page extends StatefulWidget {
  @override
  _Bottom5PageState createState() => _Bottom5PageState();
}

class _Bottom5PageState extends State<Bottom5Page>
    with TickerProviderStateMixin {
  /// 菜单的icon
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.markunread_outlined,
    Icons.notifications,
    Icons.settings,
    Icons.update_sharp,
  ];

  int pageIndex = 0;

  /// 子菜单是否展示
  bool isShow = false;

  /// 动画变量,以及初始化和销毁
  late AnimationController _animationController;
  late Animation<double> _animation;

  final myCurve = Cubic(0.68, 0, 0, 1.6);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: myCurve),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 内容
        Scaffold(
          appBar: MyAppBar(title: '半折扇菜单'),
          body: content(),
        ),

        /// 遮罩
        if (isShow)
          GestureDetector(
              behavior: HitTestBehavior.opaque, onTap: () => _onClickBg()),

        /// 底部导航菜单
        bottomBar(),
      ],
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
      bottom: MediaQuery.of(context).padding.bottom + 8.0,
      child: BottomAppBar5(
        animation: _animation,
        menuAnimation:
            Tween<double>(begin: 0, end: 1).animate(_animationController),
        tabIconsList: menuItems,
        changeIndex: (index) => _onClickBottomBar(index: index),
        onClickMenu: () => _onClickBottomBar(),
      ),
    );
  }

  void _onClickBottomBar({int? index}) {
    if (!mounted) return;

    debugPrint('longer   点击了 >>> $index');

    bool isShow = false;
    if (_animationController.status == AnimationStatus.completed) {
      /// 收拢
      _animationController.reverse();
      isShow = false;
    } else {
      /// 展开
      _animationController.forward();
      isShow = true;
    }

    setState(() {
      if (index != null) {
        pageIndex = index;
      }
      this.isShow = isShow;
    });
  }

  void _onClickBg() {
    debugPrint('longer   >>> 点击了遮罩');

    /// 收拢
    _animationController.reverse();

    setState(() => this.isShow = false);
  }
}
