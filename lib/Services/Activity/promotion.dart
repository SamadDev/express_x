import 'package:x_express/Modules/Activity/promotion.dart';
import 'package:x_express/Utils/exports.dart';

class PromotionServices with ChangeNotifier {
  List<PromotionModule> _promotionList = [];
  List<PromotionModule> get promotionList => _promotionList;
  bool isLoading=false;

  Future<void> getPromotion({context, status = false}) async {
    try {
      if (promotionList.isEmpty||status==true) {
        isLoading=true;
        var data = await Request.reqGet('ads');
        _promotionList = data['data'].map<PromotionModule>((e) => PromotionModule.fromJson(e)).toList();
        isLoading=false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  int? currentIndex = 0;
  void getIndex(index) {
    currentIndex = index;
    notifyListeners();
  }
}