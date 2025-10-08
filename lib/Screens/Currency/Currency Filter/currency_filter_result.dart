import 'package:x_express/Screens/Currency/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';

class CurrencyFilterResultScreen extends StatelessWidget {
  final currency;
  final s_date;
  final e_date;

  CurrencyFilterResultScreen({this.e_date, this.s_date, this.currency});
  Widget build(BuildContext context) {
    final currency = Provider.of<CurrencyService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          title: Text(language["filter_result"]),
        ),
        body: FutureBuilder(
          future: currency.getCurrencyFilterList(context: context,s_date: s_date,e_date: e_date,currency:currency),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? Column(children: List.generate(4, (index) => ShimmerOrderCard()))
              : Consumer<CurrencyService>(
                  builder: (ctx, data, _) => data.currencyFilterList.isEmpty
                      ? EmptyScreen()
                      : LazyLoadScrollView(
                          isLoading: false,
                          scrollOffset: 350,
                          onEndOfPage: () async {
                            Fluttertoast.showToast(
                                msg: language["please wait"],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppTheme.card,
                                textColor: AppTheme.primary,
                                fontSize: 16.0);
                            await data.currencyFilterList;
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 20),
                              itemCount: data.currencyFilterList.length,
                              itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                position: i,
                                duration: Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 70.0,
                                  child: CurrencyCard(
                                    currency: data.currencyFilterList[i],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
        ));
  }
}
