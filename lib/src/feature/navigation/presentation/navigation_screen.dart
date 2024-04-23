import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ecom/src/feature/favourites/presentation/favourite_screen.dart';
import 'package:ecom/src/feature/home/presentation/home_screen.dart';
import 'package:ecom/src/feature/profile/presentation/profile_screen.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:ecom/src/utils/internetStatusChecker.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with AutomaticKeepAliveClientMixin {
  PageController controller = PageController();
  int bottomSelectedIndex = 0;
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      controller.jumpToPage(index);
    });
  }

  var pages = {
    '0': const HomeScreen(),
    '1': const FavouriteScreen(),
    '2': ProfileScreen()
  };
  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: bottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: NetworkAware(
        PageView(
          controller: controller,
          onPageChanged: (index) {
            pageChanged(index);
          },
          children: <Widget>[
            pages['$bottomSelectedIndex']!,
          ],
        ),
      ),
    );
  }

  Padding bottomBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceInfo.responsiveHeight(20)),
      child: CustomNavigationBar(
        iconSize: 30.0,
        isFloating: true,
        selectedColor: Colors.white,
        strokeColor: Colors.white,
        unSelectedColor: Colors.grey[600],
        backgroundColor: Colors.black,
        borderRadius: const Radius.circular(20.0),
        blurEffect: true,
        opacity: 0.8,
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
          ),
        ],
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          setState(() {
            bottomTapped(index);
          });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
