import 'package:x_express/Utils/exports.dart';

class LeadersService with ChangeNotifier {
  List<LeadersModel> _leadersList = [];
  List<LeadersModel> get leadersList => _leadersList;

   Debouncer debouncer = Debouncer(milliseconds: 200);
  TextEditingController searchController = TextEditingController();

  Future<List<LeadersModel>> getLeaders({required int page, required BuildContext context, type}) async {
    try {
      var data = await Request.reqGet('shared/notifications/user-notifications?pageNumber=$page&pageSize=10');
      if (data['status'] == 'false') return [];
      _leadersList = data.map<LeadersModel>((e) => LeadersModel.fromJson(e)).toList();
      return leadersList;
    } catch (e) {
      print("error pending is: $e");
      return [];
    }
  }
}
