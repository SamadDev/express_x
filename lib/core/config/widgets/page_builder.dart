import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/widgets/loading.dart';

class PageBuilder extends StatefulWidget {
  final List<Future Function()> fetch;
  final Widget Function(BuildContext context) builder;
  final bool isRefreshActive;

  const PageBuilder({
    super.key,
    required this.fetch,
    required this.builder,
    this.isRefreshActive = true,
  });

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  bool _isLoading = false;
  String? _error;
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetched) {
      _hasFetched = true;
      _fetchAllData();
    }
  }

  Future<void> _fetchAllData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      await WidgetsBinding.instance.endOfFrame;

      final List<dynamic> results = widget.fetch.map((func) => func()).toList();

      final List<Future> futures = results.whereType<Future>().toList();
      if (futures.isNotEmpty) {
        await Future.wait(futures);
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error.toString();
          _isLoading = false;
        });
      }
    }
  }

  Widget _wrapWithScrollIfNeeded(Widget child) {
    if (child is ScrollView) {
      return child;
    }

    return SingleChildScrollView(
      physics: widget.isRefreshActive
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      print("check if loading is: $_isLoading");
      return const Center(
        child: Align(
          alignment: Alignment.center,
          child: Loading(),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(_error ?? ""),
              const SizedBox(height: 8),
              TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kLightPrimary,
                ),
                onPressed: _fetchAllData,
                child: GlobalText(
                  'Retry',
                  color: kLightSurfacePrimary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      backgroundColor: kLightPlatinum50,
      color: kLightPrimary,
      onRefresh: _fetchAllData,
      child: _wrapWithScrollIfNeeded(widget.builder(context)),
    );
  }
}
