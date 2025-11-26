import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:x_express/features/Home/view/home/home_screen.dart';
import 'package:x_express/features/Explore/view/explore_screen.dart';
import 'package:x_express/features/Order/view/order_history_screen.dart';
import 'package:x_express/features/Subscription/view/subscription_screen.dart';
import 'package:x_express/features/Profile/view/profile_screen.dart';
import 'package:x_express/features/Home/data/service/order_service.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:x_express/core/config/utitls/auth_guard.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    OrderHistoryScreen(),
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
        selectedItemColor: Color(0xff5d3ebd),
        unselectedItemColor: Color(0xFFBBBBBB),
        selectedLabelStyle:
            TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
        onTap: (index) async {
          // Check if the tab requires authentication
          // Protected tabs: Orders (2), Subscription (3), Account/Profile (4)
          final protectedTabs = [2, 3, 4];
          
          if (protectedTabs.contains(index)) {
            final hasAuth = await AuthGuard.requireAuth(context);
            if (!hasAuth) {
              // User cancelled login, don't switch tabs
              return;
            }
          }
          
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
            icon: FaIcon(FontAwesomeIcons.compass, size: 20),
            activeIcon: FaIcon(FontAwesomeIcons.compass, size: 20),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Consumer<OrderService>(
              builder: (context, orderService, child) {
                return Stack(
                  children: [
                    FaIcon(FontAwesomeIcons.listCheck, size: 20),
                    if (orderService.orders.isNotEmpty)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${orderService.orders.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.creditCard, size: 20),
            label: 'Subscription',
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
}
