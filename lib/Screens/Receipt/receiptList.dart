import 'package:x_express/Screens/Receipt/Receipt%20Filter/receipt_filter.dart';
import 'package:x_express/Screens/Receipt/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';

class ReceiptListScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    final receipt = Provider.of<ReceiptService>(context, listen: false);
    TextEditingController _searchController = TextEditingController();
    final Debouncer _debouncer = Debouncer(milliseconds: 200);

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(createRoute(ReceiptFilterScreen()));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20.0, top: 15),
              child: Image.asset(
                'assets/images/filter.png',
                width: 20,
                height: 20,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
        titleSpacing: 0,
        elevation: 0,
        leadingWidth: 40,
        title: Text(language['receipts']),
      ),
      body: FutureBuilder(
          future: receipt.getReceipt(),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? ShimmerListCard()
              : Consumer<ReceiptService>(
                  builder: (ctx, data, _) => data.isRefresh
                      ? ShimmerListCard()
                      : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 12, left: 12, bottom: 0),
                                  child: CustomSearchFormField(
                                    controller: _searchController,

                                    prefix: Icon(Icons.search,size: 24),
                                    hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: AppTheme.black),
                                    hintText: language['search'],
                                    fillColor: AppTheme.white,
                                    borderType: true,
                                    onChange: (value) async {
                                      _debouncer.run(() {
                                        data.getSearchReceipt(text: _searchController.text, isRefresh: true);
                                      });
                                    },
                                  ),
                                ),
                                ( data.receiptList.isEmpty||(data.receiptSearchList.isEmpty&& _searchController.text.isNotEmpty))
                                    ? Expanded(child: EmptyScreen())
                                    : Expanded(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      LazyLoadScrollView(
                                        onEndOfPage: () async {
                                          data.changeState();
                                          _searchController.text.isEmpty
                                              ? await data.getReceipt(context: context, isPagination: true)
                                              : await data.getSearchReceipt(
                                                  isPagination: true, text: _searchController.text);
                                          data.changeState();
                                        },
                                        child: AnimationLimiter(
                                          child: RefreshIndicator(
                                            color: AppTheme.primary,
                                            onRefresh: () async {
                                              data.onRefreshLoading();
                                              await data.getReceipt(context: context, isRefresh: true);
                                              data.onRefreshLoading();
                                            },
                                            child: ListView.builder(
                                              physics: AlwaysScrollableScrollPhysics(),
                                              padding: EdgeInsets.only(bottom: 20, top: 7),
                                              itemCount: _searchController.text.isEmpty
                                                  ? receipt.receiptList.length
                                                  : receipt.receiptSearchList.length,
                                              itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                                position: i,
                                                duration: Duration(milliseconds: 500),
                                                child: SlideAnimation(
                                                  verticalOffset: 70.0,
                                                  child: FadeInAnimation(
                                                    child: ReceiptCard(
                                                        receipt: _searchController.text.isEmpty
                                                            ? receipt.receiptList[i]
                                                            : receipt.receiptSearchList[i]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible: data.isLoading,
                                          child: Positioned(
                                              bottom: 5,
                                              right: 10,
                                              left: 10,
                                              child: Center(
                                                child: CircularProgressIndicator(color: AppTheme.primary),
                                              )))
                                    ],
                                  ),
                                ),
                              ],
                            ))),
    );
  }
}
