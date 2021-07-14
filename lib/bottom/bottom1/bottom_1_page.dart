import 'package:flutter/material.dart';
import 'package:project/bottom/bottom1/bottom_app_bar_1.dart';
import 'package:project/widget/my_app_bar.dart';

class Bottom1Page extends StatefulWidget {
  @override
  _Bottom1PageState createState() => _Bottom1PageState();
}

class _Bottom1PageState extends State<Bottom1Page>
    with SingleTickerProviderStateMixin {
  /// 菜单的icon
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.markunread_outlined,
    Icons.notifications,
    Icons.settings,
  ];

  int pageIndex = 0;

  /// 子菜单是否展示
  bool isShow = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      /// 动画展开、折叠时长
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
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
        IgnorePointer(
          ignoring: isShow,
          child: Scaffold(
            appBar: const MyAppBar(title: '右侧展开菜单'),
            body: content(),
          ),
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
      bottom: MediaQuery.of(context).padding.bottom,
      left: 0,
      right: 0,
      child: BottomAppBar1(
        animation: _animation,
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
