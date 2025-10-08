import 'package:x_express/Utils/exports.dart';

class ShipmentServices with ChangeNotifier {
  List<ShipmentModule> _shipmentList = [];
  List<ShipmentModule> _shipmentFilterList = [];
  List<ShipmentModule> _shipmentSearchList = [];

  List<ShipmentModule> get shipmentList => _shipmentList;
  List<ShipmentModule> get shipmentFilterList => _shipmentFilterList;
  List<ShipmentModule> get shipmentSearchList => _shipmentSearchList;
  ShipmentModule? shipment_notification_detail;

  int pageNumber = 0;
  int pageNumberFilter = 0;
  int pageNumberSearch = 0;

  bool isLoading = false;
  bool isRefresh = false;

  Future<void> getShipment({context, isPagination = true, isRefresh = false, statusId, text = ""}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumber = 0;
        _shipmentList = [];
      }
      if (isPagination || _shipmentList.isEmpty) {
        pageNumber += 1;
        var data = await Request.reqGet(
            'tms/shipments?statusId=$statusId&searchText=$text&pageNumber=$pageNumber&pageSize=10');
        List<ShipmentModule> new_shipmentList = data.map<ShipmentModule>((e) => ShipmentModule.fromJson(e)).toList();
        for (var newItem in new_shipmentList) {
          bool isDuplicate = _shipmentList.any((existingItem) => existingItem.id == newItem.id);
          if (!isDuplicate) {
            _shipmentList.add(newItem);
          }
        }
        print(shipmentList.length);
      }

      notifyListeners();
    } catch (e) {
      isLoading = false;
      isRefresh = false;
      print("get shipment error is: $e");
    }
  }

  Future<void> getShipmentSearch({isPagination = true, isRefresh = false, text}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberSearch = 0;
        _shipmentSearchList = [];
      }
      if (isPagination || _shipmentSearchList.isEmpty) {
        pageNumberSearch += 1;
        print('search tms/shipments?searchText=$text&pageNumber=$pageNumberSearch&pageSize=10');
        var data = await Request.reqGet('tms/shipments?searchText=$text&pageNumber=$pageNumberSearch&pageSize=10');
        List<ShipmentModule> new_shipmentList = data.map<ShipmentModule>((e) => ShipmentModule.fromJson(e)).toList();
        for (var newItem in new_shipmentList) {
          bool isDuplicate = _shipmentSearchList.any((existingItem) => existingItem.id == newItem.id);
          if (!isDuplicate) {
            _shipmentSearchList.add(newItem);
          }
        }

        print("length of this shipment list is: ${_shipmentSearchList.length}");
      }
      notifyListeners();
    } catch (e) {
      print("get shipment error is: $e");
    }
  }

  Future<void> getShipmentFilterList(
      {context, isPagination = true, isRefresh = false, statusId, shipmentNumber, e_date, s_date}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberFilter = 0;
        _shipmentFilterList = [];
      }
      statusId =
          statusId.isEmpty ? "" : statusId.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");
      if (e_date.toString() == s_date.toString()) {
        e_date = '';
        s_date = '';
      }
      pageNumberFilter += 1;

      print({
        'tms/shipments?shipmentNo=$shipmentNumber&fromDate=$s_date&toDate=$e_date&pageNumber=$pageNumberFilter&pageSize=12'
      });
      var data = await Request.reqGet(
          'tms/shipments?shipmentNo=$shipmentNumber&fromDate=$s_date&toDate=$e_date&pageNumber=$pageNumberFilter&pageSize=12');
      List<ShipmentModule> NewShipmentList = data.map<ShipmentModule>((e) => ShipmentModule.fromJson(e)).toList();

      for (var newItem in NewShipmentList) {
        bool isDuplicate = _shipmentFilterList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          _shipmentFilterList.add(newItem);
        }
      }
    } catch (e) {
      print("error is: $e");
    }

    notifyListeners();
  }

  //
  String searchValue = '';
  void setShipmentSearch(value) {
    searchValue = value;
    notifyListeners();
  }

  void changeState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void onRefreshLoading() {
    isRefresh = !isRefresh;
    notifyListeners();
  }
}
