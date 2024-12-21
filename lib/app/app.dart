import 'dart:developer';
import 'package:code_mine/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'data/list_data.dart';
import 'data/model/app_models.dart';
import 'package/code_viewer.dart';
import 'package/expansion_widget.dart';

// import 'package:highlight/languages/dart.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';

class AdminScreen extends StatefulWidget {
  final String selectedTab;
  final GoRouterState goRouterState;

  const AdminScreen(
      {required this.selectedTab, super.key, required this.goRouterState});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  double _scale = 1.0;
  int index = 0;
  bool showMenu = false;
  List<ScreenModel> screenModelList = [];

  @override
  void initState() {
    screenModelList = List.generate(8, (index) => ScreenModel());
    final initialIndex = templateTypes.indexOf(widget.selectedTab);

    _tabController = TabController(
      length: categorizedData.keys.length,
      vsync: this,
      initialIndex: initialIndex >= 0 ? initialIndex : 0,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        updatePath(menuIndex: index, tabIndex: _tabController.index);
        selectedCategory = 'All';
      }
    });
    final subCategory = widget.goRouterState.pathParameters['tab4'];
    final tabParam = widget.goRouterState.pathParameters['tab3'];

    print(subCategory?.capitalize());
    selectedCategory = subCategory ?? "";
    final int tabIndex = tabParam != null
        ? templateTypes.indexWhere((tab) =>
            tab.toLowerCase().replaceAll(' ', '-') == tabParam.toLowerCase())
        : -1;
    // int categorizes = categorizedData[categorizedData.keys.toList()[_tabController.index]];
    var data = categorizedData.values
        .toList()[tabIndex]
        .indexOf(subCategory?.capitalize() ?? "");
    double position = data * 50;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
        position,
        // duration: const Duration(milliseconds: 500),
        // curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  void setTabs(GoRouterState? path) {
    if (path == null) return;

    // Extract the parameters from the route state
    final menuParam = path.pathParameters['tab2'];
    final tabParam = path.pathParameters['tab3'];
    final subCategory = path.pathParameters['tab4'];

    // Determine the index of the menu
    final int menuIndex = menuParam != null
        ? topMenus.indexWhere((element) =>
            element.name.toLowerCase().replaceAll(' ', '-') ==
            menuParam.toLowerCase())
        : -1;

    // Determine the index of the tab
    final int tabIndex = tabParam != null
        ? templateTypes.indexWhere((tab) =>
            tab.toLowerCase().replaceAll(' ', '-') == tabParam.toLowerCase())
        : -1;

    // If valid indices are found, update state
    if (menuIndex >= 0 && tabIndex >= 0) {
      setState(() {
        index = menuIndex; // Update the side menu index
        for (var e in topMenus) {
          e.isSelected = false;
        }
        topMenus[index].isSelected = true;
        _tabController.animateTo(tabIndex); // Update the TabController index
        selectedCategory = subCategory ?? "";
      });
    } else {
      // Handle invalid parameters or fallback logic
      log('Invalid menu or tab parameters: menu=$menuParam, tab=$tabParam');
    }
  }

  void updatePath({required int menuIndex, required int tabIndex}) {
    // Validate indices
    if (menuIndex < 0 ||
        menuIndex >= topMenus.length ||
        tabIndex < 0 ||
        tabIndex >= templateTypes.length) {
      log("Invalid menu or tab index: menuIndex=$menuIndex, tabIndex=$tabIndex");
      return;
    }

    // Construct the path
    final menuName =
        topMenus[menuIndex].name.toLowerCase().replaceAll(' ', '-');
    final tabName = templateTypes[tabIndex].toLowerCase().replaceAll(' ', '-');
    final selectedCategory1 =
        selectedCategory.toLowerCase().replaceAll(' ', '-');

    // Update the URL
    GoRouter.of(context)
        .replace('/flutter/$menuName/$tabName/$selectedCategory1');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    const selectedPrimaryColor = Colors.white;
    final GoRouter router = GoRouter.of(context);
    setTabs(router.state);
    final categorize =
        categorizedData[categorizedData.keys.toList()[_tabController.index]];
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            ExpandableMenuList(
              showMenu: showMenu,
              selectedIndex: index,
              topMenus: topMenus,
              onMenuSelected: (value) => setState(() {
                index = value;
                updatePath(menuIndex: index, tabIndex: _tabController.index);
              }),
              theme: theme,
              selectedPrimaryColor: selectedPrimaryColor,
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                    child: ListView(
                      children: [
                        TabBar.secondary(
                          controller: _tabController,
                          isScrollable: true,
                          onTap: (v) {
                            // final initialIndex = tabs.indexOf(widget.selectedTab);
                            // print(widget.selectedTab);
                            // print(initialIndex);
                            // final newTab = tabs[v];
                            // GoRouter.of(context).replace('/$newTab');
                          },
                          dividerColor: Colors.transparent,
                          tabAlignment: TabAlignment.start,
                          tabs: [
                            ...categorizedData.keys.map((e) => Tab(text: e))
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            controller: _scrollController,

                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: (categorize?.length ?? 0) + 1,
                            // Add 1 for the "All" button
                            itemBuilder: (context, ind) {
                              final isSelected =
                                  selectedCategory.toLowerCase() ==
                                      (ind == 0
                                          ? 'All'.toLowerCase()
                                          : categorize![ind - 1].toLowerCase());

                              if (ind == 0) {
                                // "All" button
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedCategory = 'All';
                                        updatePath(
                                            menuIndex: index,
                                            tabIndex: _tabController.index);
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          isSelected ? Colors.white : null,
                                      side: isSelected
                                          ? const BorderSide(
                                              color: Colors.white)
                                          : null,
                                    ),
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // Other dynamic buttons
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedCategory = categorize[ind - 1];
                                      updatePath(
                                          menuIndex: index,
                                          tabIndex: _tabController.index);
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          isSelected ? Colors.white : null,
                                      side: isSelected
                                          ? const BorderSide(
                                              color: Colors.white)
                                          : null),
                                  child: Text(
                                    categorize![ind - 1],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(child: _buildContent(size)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<int> items = List<int>.generate(10, (int index) => index);

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 10,
          color: Colors.transparent,
          shadowColor: Colors.black87,
          child: child,
        );
      },
      child: child,
    );
  }

  // SliverAppBar Widget
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => setState(() => showMenu = !showMenu),
            icon: const Icon(Icons.menu),
          ),
          const SizedBox(width: 10),
          _buildSearchField(),
          Expanded(
            child: SizedBox(
              height: 60,
              child: ReorderableListView.builder(
                scrollDirection: Axis.horizontal,
                buildDefaultDragHandles: false,
                // Disable the default drag icon
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final int item = items.removeAt(oldIndex);
                    items.insert(newIndex, item);
                  });
                },
                itemCount: items.length,
                proxyDecorator: _proxyDecorator,
                header:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (BuildContext context, int index) {
                  return ReorderableDragStartListener(
                    key: ValueKey(items[index]),
                    index: index,
                    child: Stack(
                      children: [
                        // Image with padding
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 5, bottom: 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ColoredBox(
                              color: Colors.grey.shade200,
                              child: Image.asset(
                                'assets/images/app_splash.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Positioned text for item number
                        Positioned(
                          top: -8,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${items[index]}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: -5,
                        //   right: -5,
                        //   child: Container(
                        //     padding: const EdgeInsets.all(2),
                        //     decoration: const BoxDecoration(
                        //       color: Colors.white,
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child:  Icon(Icons.close,size: 14,)
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // const Spacer(),
          _buildOutlinedButton(Icons.add, () {}),
          _buildIconButton('assets/images/sidebar_icons/user.svg', () {}),
          // _buildTextButton("Login", () {}),
          // _buildTextButton("Sign up", () {}),
          // _buildIconButton('assets/images/sidebar_icons/palette.svg', () {}),
        ],
      ),
    );
  }

  // Search Field
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Search...',
            filled: true,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
        ),
      ),
    );
  }

  // Content Grid
  Widget _buildContent(Size size) {
    return IndexedStack(
      index: index,
      children: [
        _buildLoginScreens(),
        _buildAppGrid(size),
      ],
    );
  }

  // Reusable Button Widget
  Widget _buildOutlinedButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: const BorderSide(color: Colors.white, width: 1.0),
          padding: const EdgeInsets.all(16.0),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  // Reusable Icon Button Widget
  Widget _buildIconButton(String assetPath, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: const BorderSide(color: Colors.white, width: 1.0),
          padding: const EdgeInsets.all(16.0),
        ),
        child: SvgPicture.asset(
          assetPath,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

  // Reusable Text Button Widget
  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: const BorderSide(color: Colors.black, width: 1.0),
          padding: const EdgeInsets.all(16.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Login Screens Grid
  Widget _buildLoginScreens() {
    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: screenModelList.map((e) => _buildHoverCard(e)).toList(),
    );
  }

  // Hover Card Widget
  Widget _buildHoverCard(ScreenModel e) {
    return MouseRegion(
      onEnter: (_) => setState(() => e.isOvered = true),
      onExit: (_) => setState(() => e.isOvered = false),
      child: SizedBox(
        height: 500,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ColoredBox(
                color: Colors.grey.shade200,
                child: Image.asset(
                  'assets/images/app_splash.png',
                  width: 300,
                  height: 500,
                ),
              ),
            ),
            _buildHoverButtons(),
            // DelayedDisplay(
            //   delay: const Duration(milliseconds: 100),
            //   fadeIn: e.isOvered,
            //   child: _buildHoverButtons(),
            // ),
          ],
        ),
      ),
    );
  }

  // Hover Buttons
  Widget _buildHoverButtons() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: 300,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHoverButton("Add", () {}),
            _buildHoverButton("View Code", () => _showCodeDialog(context)),
          ],
        ),
      ),
    );
  }

  // Reusable Hover Button Widget
  Widget _buildHoverButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // App Grid
  Widget _buildAppGrid(Size size) {
    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: List.generate(
        6,
        (index) {
          return Column(
            children: [
              _buildAppGridItem(size),
              Text(
                "App ${index + 1}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // App Grid Item
  Widget _buildAppGridItem(Size size) {
    return MouseRegion(
      onEnter: (_) => setState(() => _scale = 1.0),
      onExit: (_) => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        child: ColoredBox(
          color: Colors.grey.shade200,
          child: Image.asset(
            'assets/images/app_splash.png',
            width: (size.width - 250) / 3,
            height: 200,
          ),
        ),
      ),
    );
  }

  // Code Dialog
  void _showCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/app_splash.png',
                  width: 350,
                  height: 500,
                ),
                SizedBox(
                  width: 600,
                  child: Theme(
                    data: ThemeData.dark(), child: const CodeViewer(),
                    // CodeTheme(
                    //   data: CodeThemeData(styles: monokaiSublimeTheme),
                    //   child: SingleChildScrollView(
                    //     child:
                    //     CodeField(
                    //       controller: CodeController(
                    //           text: '''import 'package:flutter/material.dart';''',
                    //           language: dart, readOnly: true),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ExpandableMenuList extends StatelessWidget {
  final bool showMenu;
  final int selectedIndex;
  final List<SidebarItemModel> topMenus;
  final Function(int index) onMenuSelected;
  final ThemeData theme;
  final Color selectedPrimaryColor;

  const ExpandableMenuList({
    super.key,
    required this.showMenu,
    required this.selectedIndex,
    required this.topMenus,
    required this.onMenuSelected,
    required this.theme,
    required this.selectedPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: showMenu ? 300 : 60,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildLogo(),
                ...topMenus.asMap().entries.map(
                      (entry) => _buildMenuTile(entry.key, entry.value),
                    ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  /// Builds the logo widget
  Widget _buildLogo() {
    return Image.asset('assets/images/app_splash.png', height: 80);
  }

  /// Builds the individual expandable menu tile
  Widget _buildMenuTile(int index, SidebarItemModel menuTile) {
    return ExpansionWidget(
      initiallyExpanded: menuTile.isSelected,
      duration: const Duration(milliseconds: 300),
      onExpansionChanged: (bool expanded) {
        for (var e in topMenus) {
          e.isSelected = false;
        }
        menuTile.isSelected = true;
        onMenuSelected(index);
      },
      titleBuilder: (animationValue, easeInValue, isExpanded, toggleFunction) {
        return _buildMenuTitle(menuTile, isExpanded, toggleFunction);
      },
      content: showMenu ? _buildSubMenuList(menuTile) : const SizedBox(),
    );
  }

  /// Builds the title part of the menu tile
  Widget _buildMenuTitle(SidebarItemModel menuTile, bool isExpanded,
      Function({bool animated}) toggleFunction) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 8),
      child: InkWell(
        onTap: () => toggleFunction(animated: true),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: BoxConstraints.tight(const Size.fromHeight(48)),
          alignment: AlignmentDirectional.center,
          decoration: ShapeDecoration(
            color: menuTile.isSelected ? Colors.white : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          padding: EdgeInsetsDirectional.only(
            start: showMenu ? 16 : 0,
            end: showMenu ? 8 : 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                menuTile.iconPath,
                colorFilter: ColorFilter.mode(
                  menuTile.isSelected
                      ? Colors.black
                      : theme.textTheme.bodyLarge!.color!,
                  BlendMode.srcIn,
                ),
              ),
              if (showMenu)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            menuTile.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: menuTile.isSelected
                                  ? selectedPrimaryColor
                                  : null,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_down
                              : Icons.chevron_right,
                          color:
                              menuTile.isSelected ? selectedPrimaryColor : null,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the submenu list under the expanded menu
  Widget _buildSubMenuList(SidebarItemModel menuTile) {
    return Column(
      children: menuTile.submenus
          .map(
            (submenu) => ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                submenu.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              onTap: () => debugPrint('Selected ${submenu.name}'),
            ),
          )
          .toList(),
    );
  }
}
