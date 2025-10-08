class OpenOrderModule {
  var codeName;
  var supplierName;
  var remaining;
  var statusName;
  var statusClass;
  var statusColor;
  var currencyName;
  var id;
  var orderNo;
  var orderDate;
  var refNo;
  var refDate;
  var customerId;
  var customerCodeId;
  var supplierId;
  var total;
  var currencyId;
  var deliveryDate;
  var statusId;
  var description;
  var phoneNo;
  var accountNo;
  var shopName;
  var uniqueId;
  var totalPaid;
  bool? isTrashed;
  var entityMode;

  OpenOrderModule(
      {this.codeName,
        this.supplierName,
        this.remaining,
        this.statusName,
        this.statusClass,
        this.statusColor,
        this.currencyName,
        this.id,
        this.orderNo,
        this.orderDate,
        this.refNo,
        this.refDate,
        this.customerId,
        this.customerCodeId,
        this.supplierId,
        this.total,
        this.currencyId,
        this.deliveryDate,
        this.statusId,
        this.description,
        this.phoneNo,
        this.accountNo,
        this.shopName,
        this.uniqueId,
        this.totalPaid,
        this.isTrashed,
        this.entityMode});

  OpenOrderModule.fromJson(Map<String, dynamic> json) {
    codeName = json['codeName'];
    supplierName = json['supplierName'];
    remaining = json['remaining'];
    statusName = json['statusName'];
    statusClass = json['statusClass'];
    statusColor = json['statusColor'];
    currencyName = json['currencyName'];
    id = json['id'];
    orderNo = json['orderNo'];
    orderDate = json['orderDate'];
    refNo = json['refNo'];
    refDate = json['refDate'];
    customerId = json['customerId'];
    customerCodeId = json['customerCodeId'];
    supplierId = json['supplierId'];
    total = json['total'];
    currencyId = json['currencyId'];
    deliveryDate = json['deliveryDate'];
    statusId = json['statusId'];
    description = json['description'];
    phoneNo = json['phoneNo'];
    accountNo = json['accountNo'];
    shopName = json['shopName'];
    uniqueId = json['uniqueId'];
    totalPaid = json['totalPaid'];
    isTrashed = json['isTrashed'];
    entityMode = json['entityMode'];
  }
}