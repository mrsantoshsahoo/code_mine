class SidebarItemModel {
  final String name;
  final String iconPath;
  final List<SidebarSubmenuModel> submenus;
  final String? navigationPath;
  final bool isPage;
  bool isSelected;

  SidebarItemModel({
    required this.name,
    required this.iconPath,
    this.submenus = const [],
    this.navigationPath,
    this.isPage = false,
    this.isSelected = false,
  });
}

class SidebarSubmenuModel {
  final String name;
  final String? navigationPath;
  final bool isPage;

  SidebarSubmenuModel({
    required this.name,
    this.navigationPath,
    this.isPage = false,
  });
}

class ScreenModel {
  bool isOvered;

  ScreenModel({this.isOvered = false});
}

