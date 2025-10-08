import 'package:x_express/Utils/exports.dart';

abstract class PaginatedData {
  String get id;
}

class PaginationProvider<T extends PaginatedData> extends ChangeNotifier {
  List<T> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _itemsPerPage = 6;

  List<T> get items => _items;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  final Future<List<T>> Function(int page) fetchItems;

  PaginationProvider({required this.fetchItems});

  Future<void> loadItems({bool refresh = false}) async {
    if (_isLoading || (!refresh && !_hasMore)) return;

    _isLoading = true;
    notifyListeners();

    try {
      if (refresh) {
        _page = 1;
        _items = [];
        _hasMore = true;
      }

      final newItems = await fetchItems(_page);

      print('Fetched ${newItems.length} items for page $_page');

      if (newItems.isEmpty) {
        _hasMore = false;
        print('No more items to fetch');
      } else {
        _items.addAll(newItems);
        _page++;

        // Check if we've reached the end
        if (newItems.length < _itemsPerPage) {
          _hasMore = false;
          print('Reached the end of the list');
        }
      }
    } catch (e) {
      print('Error loading items: $e');
      _hasMore = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshItems() async {
    await loadItems(refresh: true);
  }
}

class PaginatedListView<T extends PaginatedData> extends StatefulWidget {
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final Widget Function(BuildContext)? emptyBuilder;
  final scrollDirectionType;

  const PaginatedListView(
      {Key? key,
        required this.itemBuilder,
        required this.loadingBuilder,
        required this.emptyBuilder,
        this.scrollDirectionType = Axis.vertical})
      : super(key: key);

  @override
  _PaginatedListViewState<T> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T extends PaginatedData> extends State<PaginatedListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaginationProvider<T>>().loadItems();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final provider = context.read<PaginationProvider<T>>();
      if (!provider.isLoading && provider.hasMore) {
        provider.loadItems();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaginationProvider<T>>(
      builder: (context, provider, child) {
        if (provider.items.isEmpty) {
          if (provider.isLoading) {
            return widget.loadingBuilder!(context);
          } else if (widget.emptyBuilder != null) {
            return EmptyScreen();
          } else {
            return SizedBox.shrink();
          }
        }

        return RefreshIndicator(
          onRefresh: provider.refreshItems,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: widget.scrollDirectionType,
            itemCount: provider.items.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < provider.items.length) {
                return widget.itemBuilder(context, provider.items[index]);
              } else if (provider.hasMore) {
                return Center(child: CircularProgressIndicator());
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
