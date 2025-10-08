import 'package:x_express/Screens/Currency/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';

class CurrencyListScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final currency = Provider.of<CurrencyService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(createRoute(CurrencyFilterScreen()));
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
        elevation: 0.1,
        leadingWidth: 40,
        title: Text(language["currencyRate"]),
      ),
      body: FutureBuilder(
        future: currency.getCurrency(),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? SingleChildScrollView(child: Column(children: List.generate(12, (index) => ShimmerOrderCard())))
            : Consumer<CurrencyService>(
                builder: (ctx, data, _) => data.currencyList.isEmpty
                    ? EmptyScreen()
                    : Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            LazyLoadScrollView(
                              scrollOffset: 350,
                              onEndOfPage: () async {
                                data.changeState();
                                await data.getCurrency(context: context, isPagination: true);
                                data.changeState();
                              },
                              child: AnimationLimiter(
                                child: RefreshIndicator(
                                  color: AppTheme.primary,
                                  onRefresh: () async {
                                    data.currencyList.clear();
                                    await data.getCurrency(
                                      context: context,
                                      isRefresh: true,
                                    );
                                  },
                                  child: ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(bottom: 20),
                                    itemCount: currency.currencyList.length,
                                    itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                      position: i,
                                      duration: Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 70.0,
                                        child: FadeInAnimation(
                                          child: CurrencyCard(currency: currency.currencyList[i]),
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
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
      ),
    );
  }
}
