import 'package:flutter/material.dart';
import 'package:project/bottom/bottom8/bottom_app_bar_8.dart';
import 'package:project/widget/my_app_bar.dart';

class Bottom8Page extends StatefulWidget {
  @override
  _Bottom8PageState createState() => _Bottom8PageState();
}

class _Bottom8PageState extends State<Bottom8Page>
    with SingleTickerProviderStateMixin {
  /// 菜单的icon
  final List<IconData> menuItems = <IconData>[
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
      duration: const Duration(milliseconds: 600),
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
            appBar: const MyAppBar(title: '向上展开菜单'),
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
    return Positioned.fill(
      bottom: MediaQuery.of(context).padding.bottom + 22,
      child: BottomAppBar8(
        animation: _animation,
        tabIconsList: menuItems,
        menuAnimation:
            Tween<double>(begin: 0, end: 1).animate(_animationController),
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
