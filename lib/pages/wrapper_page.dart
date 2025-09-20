import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hotel_page/pages/booking_page.dart';
import 'package:hotel_page/pages/favorite_page.dart';
import 'package:hotel_page/pages/home_page.dart';
import 'package:hotel_page/pages/profile_page.dart';
import 'package:hotel_page/utils/app_constants.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  final List<Widget> _pages = const [
    HomePage(),
    BookingPage(),
    FavoritePage(),
    ProfilePage(),
  ];
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            selectedItemColor: AppConstants.bottomNavigationBarColor,

            unselectedItemColor:
                AppConstants.bottomNavigationBarUnselectedColor,

            selectedLabelStyle: TextStyle(
              color: AppConstants.bottomNavigationBarColor,
            ),
            unselectedLabelStyle: TextStyle(
              color: AppConstants.bottomNavigationBarUnselectedColor,
            ),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
