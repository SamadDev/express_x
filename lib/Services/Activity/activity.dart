import 'package:x_express/Modules/Activity/activity.dart';
import 'package:x_express/Utils/exports.dart';


class ActivityService with ChangeNotifier {
  ActivityModule? _activity;
  ActivityModule get activity => _activity!;

  Future<void> getActivity({context, s_date, e_date, currencyType = "0"}) async {
    try {
      print('fms/reports/account-statement?accountId=0&fromDate=$s_date&toDate=$e_date&currencyId=$currencyType');
      s_date = DateFormat("yyyy-MM-dd").format(DateTime.parse(s_date.toString()));
      e_date = DateFormat("yyyy-MM-dd").format(DateTime.parse(e_date.toString()));
      var data = await Request.reqGet(
          'fms/reports/account-statement?accountId=0&fromDate=$s_date&toDate=$e_date&currencyId=$currencyType');

      _activity = ActivityModule.fromJson(data);
      print("Activity data is: ${_activity!.transactions!.length}");

      notifyListeners();
    } catch (e) {
      print("get order error is: $e");
    }
  }
}
