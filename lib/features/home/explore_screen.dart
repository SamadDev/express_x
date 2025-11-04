import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_express/features/home/services/data_cache_service.dart';
import 'package:x_express/features/home/services/tab_service.dart';
import 'package:x_express/features/Store/store_webview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:x_express/core/config/theme/color.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<TabItem> _tabs = [];
  List<Store> _allStores = [];
  List<Store> _filteredStores = [];
  bool _isLoading = true;
  String _searchQuery = '';
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final tabs = await DataCacheService.instance.getTabs();
      final allStores = await DataCacheService.instance.getAllStores();
      setState(() {
        _tabs = tabs;
        _allStores = allStores;
        _filteredStores = _allStores;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading data: $e');
    }
  }

  void _filterStores(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredStores = _allStores;
      } else {
        _filteredStores = _allStores.where((store) {
          return store.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _filterByTab(int tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
      if (tabIndex == 0) {
        _filteredStores = _allStores;
      } else if (tabIndex - 1 < _tabs.length) {
        _filteredStores = _tabs[tabIndex - 1].stores;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Explore Stores',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kLightPrimary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabBar(),
          Expanded(child: _buildStoresGrid()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kLightPrimary.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: _filterStores,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search stores...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: kLightPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.search, color: kLightPrimary, size: 20),
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? Container(
                  margin: EdgeInsets.all(4),
                  child: IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey[600], size: 20),
                    onPressed: () {
                      _filterStores('');
                    },
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    if (_isLoading) {
      return Container(
        height: 50,
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

    final tabNames = ['All'] + _tabs.map((tab) => tab.name).toList();

    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabNames.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedTabIndex == index;
          final tabName = tabNames[index];
          
          return GestureDetector(
            onTap: () => _filterByTab(index),
            child: Container(
              margin: EdgeInsets.only(right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    child: Text(
                      tabName,
                      style: TextStyle(
                        color: isSelected ? kLightPrimary : Colors.grey[600],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // Underline for active tab
                  if (isSelected)
                    Container(
                      height: 2,
                      width: tabName.length * 9.0, // Approximate width based on text
                      decoration: BoxDecoration(
                        color: kLightPrimary,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    )
                  else
                    SizedBox(height: 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoresGrid() {
    if (_isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
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

    if (_filteredStores.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No stores found for "$_searchQuery"'
                  : 'No stores available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            if (_searchQuery.isNotEmpty) ...[
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _filterStores(''),
                child: Text('Clear Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kLightPrimary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 4,
      ),
      itemCount: _filteredStores.length,
      itemBuilder: (context, index) {
        final store = _filteredStores[index];
        return _buildStoreCard(store);
      },
    );
  }

  Widget _buildStoreCard(Store store) {
    return GestureDetector(
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
              child: store.image.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: store.image,
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
                      "assets/images/${store.image}",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
            ),
            Text(
              store.name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
