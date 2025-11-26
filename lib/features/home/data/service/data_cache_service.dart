import 'package:x_express/features/Home/data/service/tab_service.dart';

class DataCacheService {
  static DataCacheService? _instance;
  static DataCacheService get instance => _instance ??= DataCacheService._();

  DataCacheService._();

  List<TabItem>? _cachedTabs;
  List<Store>? _cachedAllStores;
  bool _isLoading = false;
  DateTime? _lastFetchTime;
  static const Duration _cacheExpiry =
      Duration(minutes: 5); // Cache for 5 minutes

  List<TabItem>? get cachedTabs => _cachedTabs;
  List<Store>? get cachedAllStores => _cachedAllStores;
  bool get isLoading => _isLoading;
  bool get hasData => _cachedTabs != null && _cachedTabs!.isNotEmpty;

  bool get isCacheValid {
    if (_lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!) < _cacheExpiry;
  }

  Future<List<TabItem>> getTabs({bool forceRefresh = false}) async {
    // Return cached data if available and not expired
    if (!forceRefresh && hasData && isCacheValid) {
      return _cachedTabs!;
    }

    // If already loading, wait for current request
    if (_isLoading) {
      while (_isLoading) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      return _cachedTabs ?? [];
    }

    // Fetch new data
    _isLoading = true;
    try {
      final tabs = await TabService.fetchTabs();
      _cachedTabs = tabs;
      _cachedAllStores = tabs.expand((tab) => tab.stores).toList();
      _lastFetchTime = DateTime.now();
      return tabs;
    } catch (e) {
      print('Error fetching tabs in cache service: $e');
      return _cachedTabs ?? [];
    } finally {
      _isLoading = false;
    }
  }

  Future<List<Store>> getAllStores({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedAllStores != null && isCacheValid) {
      return _cachedAllStores!;
    }

    await getTabs(forceRefresh: forceRefresh);
    return _cachedAllStores ?? [];
  }

  void clearCache() {
    _cachedTabs = null;
    _cachedAllStores = null;
    _lastFetchTime = null;
  }

  void refreshCache() {
    clearCache();
    getTabs(forceRefresh: true);
  }
}
