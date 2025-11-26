import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_express/features/Address/view/address_home/pages/address_home.dart';
import 'package:x_express/features/Advertisement/view/advertisement.dart';
import 'package:x_express/features/Logistic/view/logistic_list.dart';
import 'package:x_express/features/Store/view/store_webview.dart';
import 'package:x_express/features/Home/data/service/data_cache_service.dart';
import 'package:x_express/features/Home/data/service/tab_service.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Home/view/home/widgets/timer_selection_widget.dart';
import 'package:x_express/features/Home/view/home/widgets/order_link_widget.dart';
import 'package:x_express/features/Home/view/home/widgets/home_app_bar_widget.dart';
import 'package:x_express/features/Home/view/home/widgets/brand_logo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<TabItem> _tabs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTabs();
  }

  Future<void> _loadTabs() async {
    try {
      final tabs = await DataCacheService.instance.getTabs();
      if (mounted) {
        setState(() {
          _tabs = tabs;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('Error loading tabs: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget customTabWidget() {
    if (_isLoading) {
      return Container(
        height: 48,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 30,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      );
    }

    if (_tabs.isEmpty) {
      return Container(
        height: 48,
        child: Center(
          child: Text(
            'No tabs available. Please check your connection.',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _pageController.jumpToPage(index);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: _selectedIndex == index
                              ? kLightPrimary
                              : Colors.transparent,
                          width: 2,
                        ),
                      )),
                      child: Text(
                        _tabs[index].name,
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? kLightPrimary
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: _selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedTabContent() {
    if (_isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 4,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          },
        ),
      );
    }

    if (_tabs.isEmpty || _selectedIndex >= _tabs.length) {
      return Center(
        child: Text(
          'No stores available. Please check your connection.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    final selectedTab = _tabs[_selectedIndex];
    final stores = selectedTab.stores;

    if (stores.isEmpty) {
      return Center(
        child: Text(
          'No stores available for ${selectedTab.name}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 4,
      ),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        return BrandLogoWidget(
          name: store.name,
          image: store.image,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreWebViewScreen(
                  storeUrl: store.websiteUrl,
                  storeName: store.name,
                  baseUrl: store.websiteUrl,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: HomeAppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressHome(),
            Logistic(),
            Advertisement(),
            OrderLinkWidget(),
            TimerSelectionWidget(),
            customTabWidget(),
            getSelectedTabContent(),
          ],
        ),
      ),
    );
  }
}
