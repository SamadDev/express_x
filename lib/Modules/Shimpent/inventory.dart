class InventoryListDetailModule {
  var id;
  String? receiveNo;
  String? itemCode;
  String? description;
  String? receiveDate;
  String? refNo;
  String? customerName;
  String? customerCode;
  String? itemName;
  String? cityName;
  String? warehouseName;
  var totalQty;
  var totalCBM;
  var totalWeight;

  InventoryListDetailModule(
      {this.id,
      this.receiveNo,
      this.receiveDate,
      this.refNo,
      this.customerName,
      this.customerCode,
      this.itemName,
      this.cityName,
      this.description,
      this.itemCode,
      this.warehouseName,
      this.totalQty,
      this.totalCBM,
      this.totalWeight});

  InventoryListDetailModule.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    receiveNo = json['ReceiveNo'];
    itemCode = json['ItemCode'];
    description = json['description'];
    receiveDate = json['ReceiveDate'];
    refNo = json['RefNo'];
    customerName = json['CustomerName'];
    customerCode = json['CustomerCode'];
    itemName = json['ItemName'];
    cityName = json['CityName'];
    warehouseName = json['WarehouseName'];
    totalQty = json['TotalQty'];
    totalCBM = json['TotalCBM'];
    totalWeight = json['TotalWeight'];
  }
}


class ShipmentDashboardModule {
  String? shipmentNo;
  String? shipmentDate;
  String? deliveryDate;
  String? customerName;
  var id;
  var shipmentId;
  var customerId;
  String? itemCode;
  String? itemName;
  var packing;
  var totalCBM;
  var totalWeight;
  String? description;
  String? uniqueId;
  var entityMode;

  ShipmentDashboardModule(
      {this.shipmentNo,
        this.shipmentDate,
        this.deliveryDate,
        this.customerName,
        this.id,
        this.shipmentId,
        this.customerId,
        this.itemCode,
        this.itemName,
        this.packing,
        this.totalCBM,
        this.totalWeight,
        this.description,
        this.uniqueId,
        this.entityMode});

  ShipmentDashboardModule.fromJson(Map<String, dynamic> json) {
    shipmentNo = json['shipmentNo'];
    shipmentDate = json['shipmentDate'];
    deliveryDate = json['deliveryDate'];
    customerName = json['customerName'];
    id = json['id'];
    shipmentId = json['shipmentId'];
    customerId = json['customerId'];
    itemCode = json['itemCode'];
    itemName = json['itemName'];
    packing = json['packing'];
    totalCBM = json['totalCBM'];
    totalWeight = json['totalWeight'];
    description = json['description'];
    uniqueId = json['uniqueId'];
    entityMode = json['entityMode'];
  }


}