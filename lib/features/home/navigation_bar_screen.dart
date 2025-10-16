import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:x_express/features/home/new_home_screen.dart';
import 'package:x_express/features/home/explore_screen.dart';
import 'package:x_express/features/home/bag_screen.dart';
import 'package:x_express/features/home/subscription_screen.dart';
import 'package:x_express/features/home/profile_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NewHomeScreen(),
    ExploreScreen(),
    BagScreen(),
    SubscriptionScreen(),
    ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFE8738F),
        unselectedItemColor: Color(0xFFBBBBBB),
        selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: 20),
            activeIcon: FaIcon(FontAwesomeIcons.house, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.store, size: 20),
            activeIcon: FaIcon(FontAwesomeIcons.store, size: 20),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: _buildBadgeIcon(FontAwesomeIcons.bagShopping),
            label: 'My Bag',
          ),
          BottomNavigationBarItem(
            icon: _buildBadgeIcon(FontAwesomeIcons.cartShopping),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user, size: 20),
            activeIcon: FaIcon(FontAwesomeIcons.user, size: 20),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeIcon(IconData icon) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        FaIcon(icon, size: 20),
        Positioned(
          right: -6,
          top: -6,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFFF5555),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

