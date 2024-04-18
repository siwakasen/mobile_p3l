import 'package:flutter/material.dart';
import 'package:mobile_p3l/constants.dart';
import 'package:mobile_p3l/home/screens/mo_home_screen.dart';
import 'package:mobile_p3l/home/screens/user_home_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Dashboard extends StatefulWidget {
  final int? index;

  const Dashboard({super.key, this.index});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = ScrollController();
  int currentIndex = 0;
  String? role;
  PageController? _pageController;

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    _pageController = PageController(
      initialPage: widget.index ?? 0,
    );
    getRole();
    super.initState();
  }

  void getRole() async {
    String? getRole = await loadPreference('role');
    setState(() {
      role = getRole;
    });
  }

  List<Widget> userScreen = [
    const UserHomeScreen(),
    const MOHomeScreen(),
    const UserHomeScreen(),
  ];

  List<Widget> moScreen = [
    const MOHomeScreen(),
    const UserHomeScreen(),
  ];

  List<SalomonBottomBarItem> userNavBarsItems() {
    return [
      SalomonBottomBarItem(
        icon: const Icon(Icons.dashboard),
        title: const Text("Home"),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.explore_outlined),
        title: const Text("Explore"),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person_outline_outlined),
        title: const Text("Profile"),
      ),
    ];
  }

  List<SalomonBottomBarItem> moNavBarsItems() {
    return [
      SalomonBottomBarItem(
        icon: const Icon(Icons.dashboard),
        title: const Text("Home"),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person_outline_outlined),
        title: const Text("Profile"),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController?.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: slate[50],
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          children: role == 'User' ? userScreen : moScreen,
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        selectedItemColor: indigo[500]!,
        unselectedItemColor: slate[400]!,
        onTap: _onItemTapped,
        items: role == 'User' ? userNavBarsItems() : moNavBarsItems(),
        margin: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 20.sp),
        itemShape:
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
        itemPadding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
      ),
    );
  }
}
