import 'package:x_express/Screens/Receipt/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';

class ReceiptFilterResultScreen extends StatelessWidget {
  final docNo;
  final currencyType;
  final s_date;
  final e_date;

  ReceiptFilterResultScreen({this.currencyType, this.e_date, this.s_date, this.docNo});
  Widget build(BuildContext context) {
    final receipt = Provider.of<ReceiptService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          title: Text(language['filter']),
        ),
        body: FutureBuilder(
          //
          future: receipt.getReceiptFilter(
            context: context,
            currencyType: currencyType,
            isPagination: false,
            docNo: docNo,
            e_date: e_date,
            s_date: s_date,
          ),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? Column(children: List.generate(4, (index) => ShimmerOrderCard()))
              : Consumer<ReceiptService>(
                  builder: (ctx, data, _) => data.receiptListFilter.isEmpty
                      ? EmptyScreen()
                      : Stack(
                          children: [
                            LazyLoadScrollView(
                              onEndOfPage: () async {
                                data.changeState();
                                await data.getReceiptFilter(
                                  context: context,
                                  currencyType: currencyType,
                                  isPagination: true,
                                  docNo: docNo,
                                  e_date: e_date,
                                  s_date: s_date,
                                );
                                data.changeState();
                              },
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 20, top: 7),
                                  itemCount: data.receiptListFilter.length,
                                  itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                    position: i,
                                    duration: Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 70.0,
                                      child: ReceiptCard(
                                        receipt: data.receiptListFilter[i],
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
        ));
  }
}
