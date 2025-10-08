import 'package:x_express/Utils/exports.dart';

class UserFormService with ChangeNotifier {
  String markValue = '';
  String warehouseValue = '';
  String orderId = "";
  String orderNo = "";
  List items = [];
  bool loading = false;
  int itemType = 0;


  Future<void> postOrderReceive({data, context}) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({"orderReceive": json.encode(data)});
    try {
      LoadingDialog(context);
      loading = true;
      print(loading);
     final res= await dio.post(
        "$domain" + "tms/order-receives",
        options: Options(headers: {"Authorization": "Bearer ${Auth.token}", "userType": "mobile", "language": "en"}),
        data: formData,
      );

      print( res.data);
      print(res.statusCode);

      LoadingDialog(context);
      navigator_route(context: context, page: NavigationUserScreen(page: 1));
      notifyListeners();
    } catch (error) {
      print(error);
      loading = false;
    }
  }


  Future<void> postItemImage({uuId, images, context}) async {
    try {
      print("image uuId is: $uuId");
      Dio dio = Dio();
      FormData formData = FormData();
      for (int i = 0; i < images.length; i++) {
        File? value = images[i];
        if (value != null) {
          String filename = value.path.split("/").last;
          print(filename);
          formData.files.add(
            MapEntry(
              "attachment[$i]",
              await MultipartFile.fromFile(
                value.path,
                filename: filename,
              ),
            ),
          );
        }
      }
      final res = await dio.post(
        "$domain" + "pim/items/upload-photos?uniqueId=$uuId",
        options: Options(headers: {"Authorization": "Bearer ${Auth.token}", "userType": "mobile", "language": "en"}),
        data: formData,
      );

      print("response uuId is:$uuId ");
      print("response is image $res");
      notifyListeners();
    } catch (error) {
      print(error);
      loading = false;
    }
  }

  var imageListWithUuId;
  Future<void> getImagesByUuId(uuid) async {
    try {
      imageListWithUuId = await Request.reqGet('pim/items/photos?uniqueId=$uuid');

      print("get image is: $imageListWithUuId");
      notifyListeners();
    } catch (e) {
      print("get error order image is: $e");
    }
  }

  Future<void> removeImagesByUuId(id) async {
    try {
      print("image id is: $id");
      final res = await Request.requestDelete('pim/items/photos/$id');
      print("response for delete iamge is: ");
      notifyListeners();
    } catch (e) {
      print("delete error order image is: $e");
    }
  }

  Future<void> updateOrderReceive({data, context}) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({"orderReceive": json.encode(data)});
    try {
      LoadingDialog(context);
      loading = true;
      print(loading);
      final result = await dio.put(
        "$domain" + "tms/order-receives",
        options: Options(headers: {"Authorization": "Bearer ${Auth.token}", "userType": "mobile", "language": "en"}),
        data: formData,
      );
      print("result is: $result");
      navigator_route_pop(context: context);
      navigator_route(context: context, page: NavigationUserScreen(page: 1));
      notifyListeners();
    } catch (error) {
      navigator_route_pop(context: context);
      print(error);
      loading = false;
    }
  }

  void setItemType(value) {
    itemType = value;
    notifyListeners();
  }

  void setMarkValue(value) {
    markValue = value;
    notifyListeners();
  }

  void setWarehouseValue(value) {
    warehouseValue = value;
    notifyListeners();
  }

  void addItems(value) {
    items.add(value);
    notifyListeners();
  }

  void setItems(itemsList) {
    items = itemsList;
    notifyListeners();
  }

  void setOrderId(orderIdValue, orderNoValue) {
    orderId = orderIdValue;
    orderNo = orderNoValue;
    notifyListeners();
  }

  void removeItems(value) {
    final index = items.indexWhere((element) => element['itemCode'] == value.toString());
    print(index);
    print("index of :$index");
    items.removeAt(index);
    notifyListeners();
  }
}
