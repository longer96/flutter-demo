class TabIconData {
  TabIconData({
    this.index = 0,
    this.title = '',
  });

  int index;
  String title;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      index: 0,
      title: 'Home',
    ),
    TabIconData(
      index: 1,
      title: 'Circle',
    ),
    TabIconData(
      index: 2,
      title: 'Release',
    ),
    TabIconData(
      index: 3,
      title: 'Notice',
    ),
  ];
}
