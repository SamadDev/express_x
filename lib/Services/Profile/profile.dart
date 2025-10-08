import 'package:x_express/Utils/exports.dart';

class ProfileService with ChangeNotifier {
  ProfileModule? profile;
  bool loading = false;

  Future<void> getProfile({isReload = false}) async {
    try {
      if (profile != null && isReload == false) return;
      var data = await Request.reqGet('security/users/current-user');
      print("profile data is: $data");
      profile = ProfileModule.fromJson(data);
      notifyListeners();
    } catch (e) {
      print("get profile error is: $e");
    }
  }


  Future<void> uploadImage({imageFile, context}) async {
    Dio dio = Dio();
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });
    try {
      loading = true;
      final res=await dio.post(
        "$domain" + "security/users/upload",
        options: Options(headers: {"Authorization": "Bearer ${Auth.token}", "userType": "mobile", "language": "en"}),
        data: formData,
      );
      print(res);
      LoadingDialog(context);
      loading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      loading = false;
    }
  }
}
