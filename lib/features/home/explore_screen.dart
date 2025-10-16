import 'package:flutter/material.dart';
import 'package:x_express/features/home/services/data_cache_service.dart';
import 'package:x_express/features/home/services/tab_service.dart';
import 'package:x_express/features/StoreFeatures/store_webview.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Explore Stores',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF5C3A9E),
        elevation: 0,
        centerTitle: true,
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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: _filterStores,
        decoration: InputDecoration(
          hintText: 'Search stores...',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[600]),
                  onPressed: () {
                    _filterStores('');
                  },
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    if (_isLoading) {
      return Container(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF5C3A9E)),
        ),
      );
    }

    final tabNames = ['All'] + _tabs.map((tab) => tab.name).toList();

    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabNames.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedTabIndex == index;
          return GestureDetector(
            onTap: () => _filterByTab(index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF5C3A9E) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Color(0xFF5C3A9E) : Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: Text(
                  tabNames[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoresGrid() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Color(0xFF5C3A9E)),
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
                  backgroundColor: Color(0xFF5C3A9E),
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
