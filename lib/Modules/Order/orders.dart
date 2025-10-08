class OrderModule {
  var customerName;
  var customerContactName;
  var codeName;
  var supplierName;
  var totalPaid;
  var remaining;
  var statusName;
  var statusClass;
  var statusColor;
  var totalQty;
  var currencyName;
  var currencySymbol;
  var startLSN;
  var totalRecords;
  var id;
  var orderNo;
  var orderDate;
  var refNo;
  var refDate;
  var customerId;
  var supplierId;
  var subTotal;
  var discount;
  var discountType;
  var discountAmount;
  var totalExpenses;
  var total;
  var currencyId;
  var dueDate;
  var deliveryDate;
  var statusId;
  var entityMode;

  OrderModule(
      {this.customerName,
      this.customerContactName,
      this.codeName,
      this.supplierName,
      this.totalPaid,
      this.remaining,
      this.statusName,
      this.statusClass,
      this.statusColor,
      this.totalQty,
      this.currencyName,
      this.currencySymbol,
      this.startLSN,
      this.totalRecords,
      this.id,
      this.orderNo,
      this.orderDate,
      this.refNo,
      this.refDate,
      this.customerId,
      this.supplierId,
      this.subTotal,
      this.discount,
      this.discountType,
      this.discountAmount,
      this.totalExpenses,
      this.total,
      this.currencyId,
      this.dueDate,
      this.deliveryDate,
      this.statusId,
      this.entityMode});

  OrderModule.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    customerContactName = json['customerContactName'];
    codeName = json['codeName'];
    supplierName = json['supplierName'];
    totalPaid = json['totalPaid'];
    remaining = json['remaining'];
    statusName = json['statusName'];
    statusClass = json['statusClass'];
    statusColor = json['statusColor'];
    totalQty = json['totalQty'];
    currencyName = json['currencyName'];
    currencySymbol = json['currencySymbol'];
    startLSN = json['startLSN'];
    totalRecords = json['totalRecords'];
    id = json['id'];
    orderNo = json['orderNo'];
    orderDate = json['orderDate'];
    refNo = json['refNo'];
    refDate = json['refDate'];
    customerId = json['customerId'];
    supplierId = json['supplierId'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount'];
    totalExpenses = json['totalExpenses'];
    total = json['total'];
    currencyId = json['currencyId'];
    dueDate = json['dueDate'];
    deliveryDate = json['deliveryDate'];
    statusId = json['statusId'];
    entityMode = json['entityMode'];
  }
}
