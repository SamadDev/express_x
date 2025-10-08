class OrderReceiveModule {
  var customerName;
  var codeName;
  var statusName;
  var statusClass;
  var statusColor;
  var warehouseName;
  var totalRecords;
  var id;
  var receiveNo;
  var receiveDate;
  var refNo;
  var refDate;
  var customerId;
  var warehouseId;
  var totalPacking;
  var totalCBM;
  var totalWeight;
  var uniqueId;
  bool? isTrashed;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;

  OrderReceiveModule(
      {this.customerName,
      this.codeName,
      this.statusName,
      this.statusClass,
      this.statusColor,
      this.warehouseName,
      this.totalRecords,
      this.id,
      this.receiveNo,
      this.receiveDate,
      this.refNo,
      this.refDate,
      this.customerId,
      this.warehouseId,
      this.totalPacking,
      this.totalCBM,
      this.totalWeight,
      this.uniqueId,
      this.isTrashed,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.entityMode});

  OrderReceiveModule.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    codeName = json['codeName'];
    statusName = json['statusName'];
    statusClass = json['statusClass'];
    statusColor = json['statusColor'];
    warehouseName = json['warehouseName'];
    totalRecords = json['totalRecords'];
    id = json['id'];
    receiveNo = json['receiveNo'];
    receiveDate = json['receiveDate'];
    refNo = json['refNo'];
    refDate = json['refDate'];
    customerId = json['customerId'];
    warehouseId = json['warehouseId'];
    totalPacking = json['totalPacking'];
    totalCBM = json['totalCBM'];
    totalWeight = json['totalWeight'];
    uniqueId = json['uniqueId'];
    isTrashed = json['isTrashed'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }
}
