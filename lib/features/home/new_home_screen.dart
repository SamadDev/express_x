import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_express/features/home/address/pages/address_home.dart';
import 'package:x_express/features/home/advertisement/advertisement.dart';
import 'package:x_express/features/home/logistic/pages/logistic_list.dart';
import 'package:x_express/features/StoreFeatures/store_webview.dart';
import 'package:x_express/features/home/services/data_cache_service.dart';
import 'package:x_express/features/home/services/tab_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
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
      setState(() {
        _tabs = tabs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
                      setState(() {
                        _selectedIndex = index;
                      });
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: _selectedIndex == index ? Color(0xff8b66fd) : Colors.transparent,
                          width: 2,
                        ),
                      )),
                      child: Text(
                        _tabs[index].name,
                        style: TextStyle(
                          color: _selectedIndex == index ? Color(0xff5d3ebd) : Colors.grey,
                          fontSize: 16,
                          fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
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
        return _BrandLogo(
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
      appBar: PreferredSize(preferredSize: Size(double.infinity, 60), child: _AppBarWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressHome(),
            Logistic(),
            Advertisement(),
            _SearchWidget(),
            _TimerSelectionWidget(),
            customTabWidget(),
            getSelectedTabContent(),
          ],
        ),
      ),
    );
  }
}

class _TimerSelectionWidget extends StatelessWidget {
  const _TimerSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF5C3A9E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Text(
            'Free delivery offer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          _buildTimeBox('07'),
          const Text(' : ', style: TextStyle(color: Colors.white)),
          _buildTimeBox('14'),
          const Text(' : ', style: TextStyle(color: Colors.white)),
          _buildTimeBox('44'),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time,
        style: const TextStyle(
          color: Color(0xFF5C3A9E),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for store name...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF5C3A9E),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Filter Store',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xFF5C3A9E),
      title: Image.asset("assets/images/logo.png", height: 30),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const IconButton(
            icon: Icon(Icons.shopping_basket_outlined, color: Color(0xFF5C3A9E)),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}

class _BrandLogo extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback? onTap;

  const _BrandLogo({
    super.key,
    required this.name,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              child: image.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.store, color: Colors.grey[400]),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.store, color: Colors.grey[400]),
                      ),
                    )
                  : Image.asset(
                      "assets/images/$image",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
