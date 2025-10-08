import 'package:x_express/Utils/exports.dart';

class FutureList extends StatelessWidget {
  final future;
  final list;
  final cardWidget;
  const FutureList({Key? key, this.future,this.list,this.cardWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? SingleChildScrollView(child: Column(children: List.generate(12, (index) => ShimmerOrderCard())))
            : Consumer<ReceiptService>(
                builder: (ctx, data, _) => data.receiptList.isEmpty
                    ? EmptyScreen()
                    : LazyLoadScrollView(
                        scrollOffset: 350,
                        onEndOfPage: () {
                          data.getReceipt(context: context, isPagination: true);
                        },
                        child: AnimationLimiter(
                          child: RefreshIndicator(
                            color: AppTheme.primary,
                            onRefresh: () async {
                              data.receiptList.clear();
                              await data.getReceipt(
                                context: context,
                                isRefresh: true,
                              );
                            },
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 20, top: 7),
                              itemCount: list.length,
                              itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                position: i,
                                duration: Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 70.0,
                                  child: FadeInAnimation(
                                    child:cardWidget(i),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )));
  }
}
