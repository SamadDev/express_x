import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:x_express/features/Auth/data/repository/local_storage.dart';
import 'package:x_express/features/home/order_history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  int _selectedNavIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              _buildMyAccountSection(),
              _buildAppSettingsSection(),
              _buildShoppingHelpSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: kLightBackground,
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: kLightPrimary,
            child: Text(
              'BL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello razed',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kLightText,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '0751 434 4915',
                  style: TextStyle(
                    fontSize: 14,
                    color: kLightLightGrayText,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.edit,
            color: kLightLightGrayText,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMyAccountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
            child: Text(
              'My Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kLightText,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kLightSurface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItemSimple(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Wallet',
                ),
                _buildMenuItemSimple(
                  icon: Icons.receipt_long_outlined,
                  title: 'Order History',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistoryScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuItemSimple(
                  icon: Icons.location_on_outlined,
                  title: 'Delivery Addresses',
                ),
                _buildMenuItemSimple(
                  icon: Icons.notifications_none_outlined,
                  title: 'Notifications',
                ),
                _buildMenuItemSimple(
                  icon: Icons.favorite_outline,
                  title: 'Wishlist',
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
            child: Text(
              'App Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFF0F0F0),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode_outlined,
                        color: Color(0xFF999999),
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Switch(
                          value: _isDarkMode,
                          activeColor: Color(0xFFE8738F),
                          onChanged: (value) {
                            setState(() {
                              _isDarkMode = value;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildMenuItemSimple(
                  icon: Icons.language_outlined,
                  title: 'Languages',
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingHelpSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
            child: Text(
              'Shopping Help',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                _buildMenuItemSimple(
                  icon: Icons.description_outlined,
                  title: 'Shopping Policy',
                ),
                _buildMenuItemSimple(
                  icon: Icons.info_outline,
                  title: 'About BonLili',
                ),
                _buildMenuItemSimple(
                  icon: Icons.play_circle_outline,
                  title: 'How to order',
                ),
                _buildMenuItemSimple(
                  icon: Icons.chat_bubble_outline,
                  title: 'Chat with us',
                ),
                _buildMenuItemSimple(
                  icon: Icons.contact_support_outlined,
                  title: 'Contact Us',
                ),
                _buildLogoutMenuItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemSimple({
    required IconData icon,
    required String title,
    bool isLast = false,
    VoidCallback? onTap,
  }) {
    Widget menuItem = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
          bottom: BorderSide(
            color: Color(0xFFF0F0F0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: kLightPrimary,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kLightText,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: kLightLightGrayText,
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: menuItem,
      );
    }

    return menuItem;
  }

  Widget _buildLogoutMenuItem() {
    return GestureDetector(
      onTap: _handleLogout,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              Icons.logout,
              color: Colors.red,
              size: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Color(0xFFCCCCCC),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    // Show confirmation dialog
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      try {
        // Get AuthService from provider
        final authService = Provider.of<AuthService>(context, listen: false);
        
        // Clear session data
        await LocalStorage.clearSession();
        
        // Reset auth service
        authService.resetData();
        
        // Navigate to login screen
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error during logout: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}