import 'package:flutter/material.dart';
import 'package:x_express/features/home/new_home_screen.dart';
import 'package:x_express/features/home/explore_screen.dart';
import 'package:x_express/features/home/bag_screen.dart';
import 'package:x_express/features/home/subscription_screen.dart';
import 'package:x_express/features/home/profile_screen.dart';
import 'package:x_express/features/home/widgets/button_notch_painter.dart';

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

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    NavigationItem(
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore,
      label: 'Explore',
    ),
    NavigationItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: 'Bag',
    ),
    NavigationItem(
      icon: Icons.card_membership_outlined,
      activeIcon: Icons.card_membership,
      label: 'Plans',
    ),
    NavigationItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildAnimatedNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedNavigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_selectedIndex == 0 ? 0.0 : 20.0),
          topRight: Radius.circular(_selectedIndex == _navigationItems.length - 1 ? 0.0 : 20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < _navigationItems.length; i++)
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = i),
              child: _buildIconButton(i),
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton(int index) {
    bool isActive = _selectedIndex == index;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    final item = _navigationItems[index];

    return SizedBox(
      width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotchPainter(),
                    )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              isActive ? item.activeIcon : item.icon,
              color: isActive ? Color(0xFF5C3A9E) : Colors.grey[600],
              size: 24,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              item.label,
              style: TextStyle(
                color: isActive ? Color(0xFF5C3A9E) : Colors.grey[600],
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
