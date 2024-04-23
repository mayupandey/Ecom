import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ecom/src/feature/home/presentation/home_screen.dart';
import 'package:ecom/src/feature/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
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
    '1': const HomeScreen(),
    '2': const ProfileScreen()
  };
  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: <Widget>[
          pages['$bottomSelectedIndex']!,
        ],
      ),
    );
  }

  Padding bottomBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
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
            icon: const Icon(Icons.search_outlined),
          ),
          // CustomNavigationBarItem(
          //   icon: Icon(Icons.shopping_bag_outlined),
          // ),

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

  // @override
  // bool get wantKeepAlive => true;
}
