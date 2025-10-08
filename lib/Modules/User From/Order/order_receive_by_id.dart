import 'package:x_express/Modules/User%20From/Order/order_user_data.dart';
import 'package:x_express/Modules/User%20From/Warehouse/warehouse.dart';

class OrderReceiveByIdModule {
  var id;
  var receiveNo;
  var receiveDate;
  var refNo;

  var refDate;
  var customerId;
  var customerCodeId;
  var warehouseId;
  var warehouseName;
  var totalPacking;
  var totalCBM;
  var totalWeight;
  var orderId;
  var uniqueId;

  WarehouseModule?warehouse;
  Customer? customer;
  StatusReceives? status;
  CustomerCode? customerCode;
  Order? order;
  List<Details>? details;
  bool? isTrashed;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;

  OrderReceiveByIdModule(
      {this.id,
      this.receiveNo,
      this.receiveDate,
      this.refNo,
      this.refDate,
      this.customerId,
      this.customerCodeId,
      this.warehouseId,
        this.warehouse,
      this.warehouseName,
      this.totalPacking,
      this.totalCBM,
      this.totalWeight,
      this.orderId,
        this.status,
      this.uniqueId,
      this.customer,
      this.customerCode,
      this.order,
      this.details,
      this.isTrashed,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.entityMode});

  OrderReceiveByIdModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiveNo = json['receiveNo'];
    receiveDate = json['receiveDate'];
    refNo = json['refNo'];

    refDate = json['refDate'];
    customerId = json['customerId'];
    customerCodeId = json['customerCodeId'];
    warehouseName = json['warehouseName'];

    totalPacking = json['totalPacking'];
    totalCBM = json['totalCBM'];
    totalWeight = json['totalWeight'];
    orderId = json['orderId'];
    uniqueId = json['uniqueId'];
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    warehouse = json['warehouse'] != null ? new WarehouseModule.fromJson(json['warehouse']) : null;
    customerCode = json['customerCode'] != null ? new CustomerCode.fromJson(json['customerCode']) : null;
    status = json['status'] != null ? new StatusReceives.fromJson(json['status']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    isTrashed = json['isTrashed'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }
}

class Customer {
  var id;
  var code;
  var name;
  var statusId;
  var uniqueId;
  List<CustomerCodes>? customerCodes;
  var entityMode;

  Customer({this.id, this.code, this.name, this.statusId, this.uniqueId, this.customerCodes, this.entityMode});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    statusId = json['statusId'];
    uniqueId = json['uniqueId'];
    if (json['codes'] != null) {
      customerCodes = <CustomerCodes>[];
      json['codes'].forEach((v) {
        customerCodes!.add(CustomerCodes.fromJson(v));
      });
    }
    entityMode = json['entityMode'];
  }
}

class CustomerCodes {
  var id;
  var customerId;
  var name;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;

  CustomerCodes(
      {this.id,
      this.customerId,
      this.name,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.entityMode});

  CustomerCodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    name = json['name'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }
}

class CustomerCode {
  var id;
  var customerId;
  var name;
  var entityMode;

  CustomerCode({this.id, this.customerId, this.name, this.entityMode});

  CustomerCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    name = json['name'];
    entityMode = json['entityMode'];
  }
}

class Order {
  var id;
  var orderDate;
  var customerId;
  var supplierId;
  var currencyId;
  var statusId;
  var phoneNo;
  var accountNo;
  var shopName;
  var bankName;
  var uniqueId;
  var totalPaid;
  bool? isTrashed;
  var entityMode;

  Order(
      {this.id,
      this.orderDate,
      this.customerId,
      this.supplierId,
      this.currencyId,
      this.statusId,
      this.phoneNo,
      this.accountNo,
      this.shopName,
      this.bankName,
      this.uniqueId,
      this.totalPaid,
      this.isTrashed,
      this.entityMode});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDate = json['orderDate'];
    customerId = json['customerId'];
    supplierId = json['supplierId'];
    currencyId = json['currencyId'];
    statusId = json['statusId'];
    phoneNo = json['phoneNo'];
    accountNo = json['accountNo'];
    shopName = json['shopName'];
    bankName = json['bankName'];
    uniqueId = json['uniqueId'];
    totalPaid = json['totalPaid'];
    isTrashed = json['isTrashed'];
    entityMode = json['entityMode'];
  }
}

class Details {
  var id;
  var orderReceiveId;
  var itemId;
  var itemUnitId;
  var itemCode;
  var itemName;
  var packing;
  var packingQuantity;
  var quantity;
  var length;
  var width;
  var height;
  var cbm;
  var totalCBM;
  var weight;
  var totalWeight;
  var unitPrice;
  var discount;
  var total;
  var description;
  var uniqueId;
  Item? item;
  Item? itemUnit;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;

  Details(
      {this.id,
      this.orderReceiveId,
      this.itemId,
      this.itemUnitId,
      this.itemCode,
      this.itemName,
      this.packing,
      this.packingQuantity,
      this.quantity,
      this.length,
      this.width,
      this.height,
      this.cbm,
      this.totalCBM,
      this.weight,
      this.totalWeight,
      this.unitPrice,
      this.discount,
      this.total,
      this.description,
      this.uniqueId,
      this.item,
      this.itemUnit,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.entityMode});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderReceiveId = json['orderReceiveId'];
    itemId = json['itemId'];
    itemUnitId = json['itemUnitId'];
    itemCode = json['itemCode'];
    itemName = json['itemName'];
    packing = json['packing'];
    packingQuantity = json['packingQuantity'];
    quantity = json['quantity'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    cbm = json['cbm'];
    totalCBM = json['totalCBM'];
    weight = json['weight'];
    totalWeight = json['totalWeight'];
    unitPrice = json['unitPrice'];
    discount = json['discount'];
    total = json['total'];
    description = json['description'];
    uniqueId = json['uniqueId'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    itemUnit = json['itemUnit'] != null ? new Item.fromJson(json['itemUnit']) : null;
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }
}

class Item {
  var id;
  var name;
  var entityMode;

  Item({this.id, this.name, this.entityMode});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    entityMode = json['entityMode'];
  }
}

class StatusReceives {
  var id;
  var name;
  var nameAr;
  var nameKr;
  var sort;
  var color;
  bool? isDefault;
  var entityMode;

  StatusReceives({this.id, this.name, this.sort, this.color, this.isDefault, this.entityMode});

  StatusReceives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['nameAR'];
    nameKr = json['nameKU'];
    sort = json['sort'];
    color = json['color'];

  }
}

