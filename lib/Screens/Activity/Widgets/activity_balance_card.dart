import 'package:x_express/Modules/Activity/activity.dart';
import 'package:x_express/Screens/Currency/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ActivityTotalCard extends StatelessWidget {
  final List<StatementBalance> balance;

  ActivityTotalCard({required this.balance});
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    final fetch = Provider.of<PromotionServices>(context);
    return FutureBuilder(
      future: fetch.getPromotion(context: context),
      builder: (context, snap) => Consumer<PromotionServices>(
        builder: (ctx, promotion, _) => Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 12, right: 12, left: 12),
                child: CarouselSlider(
                  options: CarouselOptions(
                    pageSnapping: false,
                    clipBehavior: Clip.none,
                    onPageChanged: (index, reason) {
                      promotion.getIndex(index);
                    },
                    animateToClosest: false,
                    padEnds: false,
                    viewportFraction: 0.9,
                    disableCenter: false,
                    initialPage: promotion.currentIndex!,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: List.generate(
                      balance.length,
                      (index) => Container(
                            width: 260,
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(right: 4, left: 4, bottom: 18),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppTheme.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GlobalText(
                                  text:
                                      " ${balance[index].currencySymbol} ${formatQuantity(double.parse(balance[index].balance.toString()))}",

                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: balance[index].balance! > 0
                                      ? AppTheme.red
                                      : balance[index].balance! == 0.0
                                          ? AppTheme.black
                                          : AppTheme.green,
                                ),
                                GlobalText(
                                  text: language['balance'],
                                  fontSize: 13,
                                  fontFamily: 'nrt-reg',
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.grey_thin,
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GlobalText(
                                          text: balance[index].currencyCode!,

                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppTheme.green),
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                                      child: Image.asset(
                                        'assets/icons/${balance[index].currencyCode}.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )).toList(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: balance.map<Widget>((e) {
                    final index = balance.indexOf(e);
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        margin: EdgeInsets.only(right: 4),
                        height: 5,
                        width: promotion.currentIndex == index ? 15 : 5,
                        decoration: BoxDecoration(
                            color: promotion.currentIndex == index ? AppTheme.primary : AppTheme.grey_between,
                            borderRadius: BorderRadius.circular(3)));
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
