import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/bottom_cart.dart';
import '../pages/bottom_fav.dart';
import '../pages/bottom_home.dart';
import '../pages/bottom_profile.dart';
import '../style/style.dart';

class BottomNav extends StatelessWidget {
  final _pages = [
    BottomHome(),
    BottomFav(),
    Cart(),
    BottomProfile(),
  ];
  var _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.grey,
              currentIndex: _currentIndex.value,
              onTap: (value) {
                _currentIndex.value = value;
              },
              items: [
                AppStyle().navBar(Icons.home, 'Home'),
                AppStyle().navBar(Icons.favorite, 'Favourit'),
                AppStyle().navBar(Icons.shopping_cart_outlined, 'Cart'),
                AppStyle().navBar(Icons.person, 'Profile'),
              ]),
          body: _pages[_currentIndex.value],
        ));
  }
}
