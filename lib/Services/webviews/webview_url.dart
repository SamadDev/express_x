import 'package:x_express/Utils/exports.dart';

class WebviewService with ChangeNotifier {
  bool isLoading = true;
  onStartLoading() {
    isLoading = true;
    notifyListeners();
  }

  onEndLoading() {
    isLoading = false;
    notifyListeners();
  }
}

// 161043