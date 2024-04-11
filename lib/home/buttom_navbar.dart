import 'package:flutter/material.dart';
import 'package:mobile_p3l/constants.dart';
import 'package:mobile_p3l/home/screens/mo_home_screen.dart';
import 'package:mobile_p3l/home/screens/user_home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ButtomNavigation extends StatefulWidget {
  final int? index;
  const ButtomNavigation({super.key, this.index});

  @override
  State<ButtomNavigation> createState() => ButtomNavigationState();
}

class ButtomNavigationState extends State<ButtomNavigation> {
  PersistentTabController? _controller;
  String? role;

  @override
  void initState() {
    super.initState();
    getRole();
    _controller = PersistentTabController(initialIndex: widget.index ?? 0);
  }

  void getRole() async {
    String? getRole = await loadPreference('role');
    setState(() {
      role = getRole;
    });
  }

  List<Widget> userScreen() {
    return const [
      UserHomeScreen(),
      UserHomeScreen(),
      UserHomeScreen(),
    ];
  }

  List<Widget> moScreen() {
    return const [
      MOHomeScreen(),
      MOHomeScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: role == 'User' ? userScreen() : moScreen(),
      items: role == 'User' ? userNavBarsItems() : moNavBarsItems(),
      navBarStyle: NavBarStyle.style9,
      controller: _controller,
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
    );
  }

  List<PersistentBottomNavBarItem> userNavBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard),
        title: ("Home"),
        activeColorPrimary: indigo[500]!,
        inactiveColorPrimary: slate[400]!,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.explore_outlined),
        title: ("Explore"),
        activeColorPrimary: indigo[500]!,
        inactiveColorPrimary: slate[400]!,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline_outlined),
        title: ("Profile"),
        activeColorPrimary: indigo[500]!,
        inactiveColorPrimary: slate[400]!,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> moNavBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard),
        title: ("Home"),
        activeColorPrimary: indigo[500]!,
        inactiveColorPrimary: slate[400]!,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline_outlined),
        title: ("Profile"),
        activeColorPrimary: indigo[500]!,
        inactiveColorPrimary: slate[400]!,
      ),
    ];
  }
}
