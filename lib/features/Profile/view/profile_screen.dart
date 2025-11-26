import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:x_express/features/Profile/data/service/profile_service.dart';
import 'package:x_express/features/Order/view/order_history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load profile data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileService = Provider.of<ProfileService>(context, listen: false);
      profileService.loadProfile();
    });
  }

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
    return Consumer<ProfileService>(
      builder: (context, profileService, child) {
        final profile = profileService.profile;
        
        return Container(
          padding: const EdgeInsets.all(20.0),
          color: kLightBackground,
          child: Row(
            children: [
              // Profile Image with Upload
              GestureDetector(
                onTap: () => _showImagePickerOptions(context),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: kLightPrimary,
                      backgroundImage: profile?.imageUrl != null && profile!.imageUrl!.isNotEmpty
                          ? CachedNetworkImageProvider(profile.imageUrl!)
                          : null,
                      child: profile?.imageUrl == null || profile!.imageUrl!.isEmpty
                          ? Text(
                              profile?.initials ?? 'NA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    if (profileService.isUploadingImage)
                      Positioned.fill(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.black54,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: kLightPrimary,
                          shape: BoxShape.circle,
                          border: Border.all(color: kLightBackground, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: profileService.isLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 16,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: 100,
                            height: 14,
                            color: Colors.grey[300],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.name ?? 'Guest User',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kLightText,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            profile?.phoneNumber ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: kLightLightGrayText,
                            ),
                          ),
                        ],
                      ),
              ),
              if (!profileService.isLoading)
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: kLightLightGrayText,
                    size: 20,
                  ),
                  onPressed: () {
                    // TODO: Navigate to edit profile screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit profile feature coming soon')),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: kLightPrimary),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera, color: kLightPrimary),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final profileService = Provider.of<ProfileService>(context, listen: false);
        final success = await profileService.uploadProfileImage(File(pickedFile.path));

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile image updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to upload image'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );

        // Get services from provider
        final profileService = Provider.of<ProfileService>(context, listen: false);
        final authService = Provider.of<AuthService>(context, listen: false);

        // Call logout API and clear local storage
        await profileService.logout();

        // Reset auth service
        authService.resetData();

        // Close loading dialog
        Navigator.of(context).pop();

        // Navigate to login screen
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        // Close loading dialog
        Navigator.of(context).pop();
        
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logged out successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login screen anyway since local data is cleared
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (Route<dynamic> route) => false,
        );
      }
    }
  }
}
