import 'package:flutter/cupertino.dart';

import '../../Modules/Promotion/promotion.dart';
import '../../Utils/Request.dart';

class PromotionService with ChangeNotifier {
  List<promotionModel> _promotionList = [];
  List<promotionModel> get promotionList => _promotionList;
  bool isLoading = false;

  Future<void> getPromotion({context, refresh = false}) async {
    try {
      if (promotionList.isEmpty || refresh == true) {
        isLoading = true;
        var data = await Request.reqGet('/advertisements');
        _promotionList = data.map<promotionModel>((e) => promotionModel.fromJson(e)).toList();
        isLoading = false;
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
