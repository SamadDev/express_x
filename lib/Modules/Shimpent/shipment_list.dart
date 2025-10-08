class ShipmentModule {
  var statusName;
  var statusColor;
  var fromLocationName;
  var toLocationName;
  var locationName;
  var deliveryRate;
  var deliveryDate;

  var warehouseName;
  var totalRecords;
  var id;
  var shipmentNo;
  var shipmentDate;
  var warehouseId;
  var totalPacking;
  var totalCBM;
  var totalWeight;
  var statusId;
  var description;
  var uniqueId;
  var isTrashed;
  var trashedBy;
  var trashedDate;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;
  var faxNo;

  ShipmentModule(
      {this.statusName,
      this.statusColor,
      this.fromLocationName,
      this.toLocationName,
      this.deliveryDate,
      this.warehouseName,
      this.totalRecords,
        this.locationName,
      this.id,
      this.shipmentNo,
      this.shipmentDate,
      this.warehouseId,
      this.totalPacking,
      this.totalCBM,
      this.totalWeight,
      this.statusId,
      this.description,
      this.uniqueId,
      this.isTrashed,
      this.faxNo,
      this.deliveryRate,
      this.trashedBy,
      this.trashedDate,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.entityMode});

  ShipmentModule.fromJson(Map<String, dynamic> json) {
    statusName = json['statusName'];
    statusColor = json['statusColor'];
    fromLocationName = json['fromLocationName'];
    toLocationName = json['toLocationName'];
    locationName=json['locationName'];
    deliveryDate = json['deliveryDate'];
    warehouseName = json['warehouseName'];
    totalRecords = json['totalRecords'];
    id = json['id'];
    faxNo = json['faxNo'];
    shipmentNo = json['shipmentNo'];
    deliveryRate = json['deliveryRate'];
    shipmentDate = json['shipmentDate'];
    warehouseId = json['warehouseId'];
    totalPacking = json['totalPacking'];
    totalCBM = json['totalCBM'];
    totalWeight = json['totalWeight'];
    statusId = json['statusId'];
    description = json['description'];
    uniqueId = json['uniqueId'];
    isTrashed = json['isTrashed'];
    trashedBy = json['trashedBy'];
    trashedDate = json['trashedDate'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }
}
