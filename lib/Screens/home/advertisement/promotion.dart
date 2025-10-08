import 'package:carousel_slider/carousel_slider.dart';
import 'package:x_express/Screens/home/advertisement/promotion_detail.dart';
import 'package:x_express/Utils/exports.dart';

class Promotion extends StatelessWidget {
  Widget build(BuildContext context) {
    final fetch = Provider.of<PromotionServices>(context);
    return FutureBuilder(
      future: fetch.getPromotion(context: context),
      builder: (context, snap) => Consumer<PromotionServices>(
        builder: (ctx, promotion, _) => Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12, right: 12, left: 12),
              child: promotion.isLoading
                  ? ShimmerEffect(width: Responsive.sW(context), height: 200)
                  : CarouselSlider(
                      options: CarouselOptions(
                        pageSnapping: false,
                        clipBehavior: Clip.none,
                        onPageChanged: (index, reason) {
                          promotion.getIndex(index);
                        },
                        animateToClosest: false,
                        padEnds: false,
                        viewportFraction: 1,
                        disableCenter: true,
                        height: 170,
                        initialPage: promotion.currentIndex!,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayCurve: Curves.ease,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 900),
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: promotion.promotionList.map((promotion) {
                        return GestureDetector(
                          onTap: () {
                            if (promotion.content!.isEmpty) return;
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) => PromotionDetailScreen(promotion: promotion)));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://img.ltwebstatic.com/v4/j/ccc/2025/03/10/d2/17415868971b5798485c3ac8256d62e33eba3f749f_thumbnail_2000x.webp'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Column(
                                      children: [
                                        Text(
                                          '31',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'OCAK\nSON',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    promotion.promotionList.length,
                    (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        margin: EdgeInsets.only(right: 4),
                        height: 5,
                        width: promotion.currentIndex == index ? 15 : 5,
                        decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(3))),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
