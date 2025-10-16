import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              _buildMyAccountSection(),
              _buildAppSettingsSection(),
              _buildShoppingHelpSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.pink,
            child: Text(
              'BonLili',
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '0751 434 4915',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.grey[600]),
            onPressed: () {
              _showEditProfileDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMyAccountSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          _buildMenuItem(
            icon: Icons.account_balance_wallet,
            title: 'Wallet',
            onTap: () => _showFeatureDialog(context, 'Wallet', 'Manage your wallet and payment methods.'),
          ),
          _buildMenuItem(
            icon: Icons.receipt_long,
            title: 'Invoices',
            onTap: () => _showFeatureDialog(context, 'Invoices', 'View your order invoices and receipts.'),
          ),
          _buildMenuItem(
            icon: Icons.location_on,
            title: 'Delivery Addresses',
            onTap: () => _showFeatureDialog(context, 'Delivery Addresses', 'Manage your delivery addresses.'),
          ),
          _buildMenuItem(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () => _showFeatureDialog(context, 'Notifications', 'Manage your notification preferences.'),
          ),
          _buildMenuItem(
            icon: Icons.favorite,
            title: 'Wishlist',
            onTap: () => _showFeatureDialog(context, 'Wishlist', 'View your saved items and wishlist.'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettingsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          _buildMenuItem(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            onTap: null,
          ),
          _buildMenuItem(
            icon: Icons.language,
            title: 'Languages',
            onTap: () => _showFeatureDialog(context, 'Languages', 'Change your app language.'),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingHelpSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shopping Help',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          _buildMenuItem(
            icon: Icons.policy,
            title: 'Shopping Policy',
            onTap: () => _showFeatureDialog(context, 'Shopping Policy', 'View our shopping policies and terms.'),
          ),
          _buildMenuItem(
            icon: Icons.info,
            title: 'About BonLili',
            onTap: () => _showFeatureDialog(context, 'About BonLili', 'Learn more about our app and company.'),
          ),
          _buildMenuItem(
            icon: Icons.play_circle,
            title: 'How to order',
            onTap: () => _showFeatureDialog(context, 'How to order', 'Learn how to place orders on our platform.'),
          ),
          _buildMenuItem(
            icon: Icons.chat,
            title: 'Chat with us',
            onTap: () => _showFeatureDialog(context, 'Chat with us', 'Get instant help through our chat support.'),
          ),
          _buildMenuItem(
            icon: Icons.contact_support,
            title: 'Contact Us',
            onTap: () => _showFeatureDialog(context, 'Contact Us', 'Get in touch with our support team.'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[600],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        trailing: trailing ?? Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }


  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Settings'),
        content: Text('Settings functionality will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPersonalInfoDialog(BuildContext context) {
    _showFeatureDialog(context, 'Personal Information', 'Update your profile details, name, email, and other personal information.');
  }

  void _showAddressesDialog(BuildContext context) {
    _showFeatureDialog(context, 'Addresses', 'Manage your delivery addresses for faster checkout.');
  }

  void _showPaymentDialog(BuildContext context) {
    _showFeatureDialog(context, 'Payment Methods', 'Add, edit, or remove your payment methods.');
  }

  void _showNotificationsDialog(BuildContext context) {
    _showFeatureDialog(context, 'Notifications', 'Customize your notification preferences.');
  }

  void _showHelpDialog(BuildContext context) {
    _showFeatureDialog(context, 'Help & Support', 'Get help with your account or contact our support team.');
  }

  void _showAboutDialog(BuildContext context) {
    _showFeatureDialog(context, 'About', 'X Express v1.0.0\nBuilt with Flutter');
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle sign out logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showFeatureDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

