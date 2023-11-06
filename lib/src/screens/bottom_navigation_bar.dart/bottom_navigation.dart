import 'package:flutter/material.dart';
import 'package:task_1/src/screens/home/home_screen.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/offers/offer.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/order.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  Widget? _pages(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeWidget();

      case 1:
        return const CategoryScreen();

      case 2:
        return const OffersScreen();

      case 3:
        return const OrdersScreen();

      case 4:
        return ProfileScreen(
          onTap: () {
            setState(() {
              _selectedIndex = 3;
            });
          },
        );

      default:
    }
    return null;
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 244, 122, 29),
        unselectedItemColor: Colors.black45,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
