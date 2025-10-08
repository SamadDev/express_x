import 'package:x_express/Utils/exports.dart';

class ReceiveStatusService with ChangeNotifier {
  List<SatesModule> existStateFilterList = [];
  List<SatesModule> receiveStatus = [];

  Future<void> getStatusReceive() async {
    try {
      if (receiveStatus.isEmpty) {
        var data = await Request.reqGet('tms/order-receives/statuses');
        receiveStatus = data.map<SatesModule>((e) => SatesModule.fromJson(e)).toList();

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
