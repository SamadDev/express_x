class OrderUserModule {
  var id;
  var orderNo;
  var orderDate;
  var refNo;
  var refDate;
  var customerId;
  var customerCodeId;
  var supplierId;
  var subTotal;
  var discount;
  var discountType;
  var discountAmount;
  var total;
  var currencyId;
  var dueDate;
  var deliveryDate;
  var statusId;
  var description;
  var terms;
  var phoneNo;
  var accountNo;
  var shopName;
  var bankName;
  var uniqueId;
  Customer? customer;
  CustomerCode? customerCode;
  Supplier? supplier;
  Currency? currency;
  Status? status;
  List<Details>? details;
  var totalPaid;
  bool? isTrashed;
  var createdBy;
  var createdDate;
  var entityMode;

  OrderUserModule(
      {this.id,
      this.orderNo,
      this.orderDate,
      this.refNo,
      this.refDate,
      this.customerId,
      this.customerCodeId,
      this.supplierId,
      this.subTotal,
      this.discount,
      this.discountType,
      this.discountAmount,
      this.total,
      this.currencyId,
      this.dueDate,
      this.deliveryDate,
      this.statusId,
      this.description,
      this.terms,
      this.phoneNo,
      this.accountNo,
      this.shopName,
      this.bankName,
      this.uniqueId,
      this.customer,
      this.customerCode,
      this.supplier,
      this.currency,
      this.status,
      this.details,
      this.totalPaid,
      this.isTrashed,
      this.createdBy,
      this.createdDate,
      this.entityMode});

  OrderUserModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['orderNo'];
    orderDate = json['orderDate'];
    refNo = json['refNo'];
    refDate = json['refDate'];
    customerId = json['customerId'];
    customerCodeId = json['customerCodeId'];
    supplierId = json['supplierId'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount'];
    total = json['total'];
    currencyId = json['currencyId'];
    dueDate = json['dueDate'];
    deliveryDate = json['deliveryDate'];
    statusId = json['statusId'];
    description = json['description'];
    terms = json['terms'];
    phoneNo = json['phoneNo'];
    accountNo = json['accountNo'];
    shopName = json['shopName'];
    bankName = json['bankName'];
    uniqueId = json['uniqueId'];
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    customerCode = json['customerCode'] != null ? new CustomerCode.fromJson(json['customerCode']) : null;
    supplier = json['supplier'] != null ? new Supplier.fromJson(json['supplier']) : null;
    currency = json['currency'] != null ? new Currency.fromJson(json['currency']) : null;
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    totalPaid = json['totalPaid'];
    isTrashed = json['isTrashed'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    entityMode = json['entityMode'];
  }
}

class Customer {
  var id;
  var code;
  var name;
  var statusId;
  var phoneNo;
  var uniqueId;
  List<Codes>? customerCodes;
  var entityMode;

  Customer({this.id, this.code, this.name, this.statusId, this.phoneNo, this.uniqueId, this.customerCodes, this.entityMode});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    statusId = json['statusId'];
    phoneNo = json['phoneNo'];
    uniqueId = json['uniqueId'];
    if (json['codes'] != null) {
      customerCodes = <Codes>[];
      json['codes'].forEach((v) {
        customerCodes!.add(new Codes.fromJson(v));
      });
    }
    entityMode = json['entityMode'];
  }
}

class Codes {
  var id;
  var customerId;
  var name;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;

  Codes(
      {this.id,
      this.customerId,
      this.name,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.entityMode});

  Codes.fromJson(Map<String, dynamic> json) {
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

class Supplier {
  var id;
  var code;
  var name;
  var statusId;
  var entityMode;

  Supplier({this.id, this.code, this.name, this.statusId, this.entityMode});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    statusId = json['statusId'];
    entityMode = json['entityMode'];
  }
}

class Currency {
  var id;
  var code;
  var name;
  var nameAR;
  var symbol;
  bool? isDefault;
  var rate;
  var color;
  var sort;
  var precision;
  var entityMode;

  Currency(
      {this.id,
      this.code,
      this.name,
      this.nameAR,
      this.symbol,
      this.isDefault,
      this.rate,
      this.color,
      this.sort,
      this.precision,
      this.entityMode});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    nameAR = json['nameAR'];
    symbol = json['symbol'];
    isDefault = json['isDefault'];
    rate = json['rate'];
    color = json['color'];
    sort = json['sort'];
    precision = json['precision'];
    entityMode = json['entityMode'];
  }
}

class Status {
  var id;
  var name;
  var sort;
  var color;
  bool? isDefault;
  var entityMode;

  Status({this.id, this.name, this.sort, this.color, this.isDefault, this.entityMode});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    color = json['color'];

    isDefault = json['isDefault'];
    entityMode = json['entityMode'];
  }
}

class Details {
  var id;
  var orderId;
  var itemId;
  var itemUnitId;
  var itemCode;
  var itemName;
  var packing;
  var packingQuantity;
  var quantity;
  var qtyReceived;
  var packingReceived;
  var unitPrice;
  var discount;
  var discountType;
  var discountAmount;
  var total;
  var description;
  var uniqueId;
  Item? item;
  ItemUnit? itemUnit;
  var createdBy;
  var createdDate;
  var entityMode;

  Details(
      {this.id,
      this.orderId,
      this.itemId,
      this.itemUnitId,
      this.itemCode,
      this.itemName,
      this.packing,
      this.packingQuantity,
      this.quantity,
      this.qtyReceived,
      this.packingReceived,
      this.unitPrice,
      this.discount,
      this.discountType,
      this.discountAmount,
      this.total,
      this.description,
      this.uniqueId,
      this.item,
      this.itemUnit,
      this.createdBy,
      this.createdDate,
      this.entityMode});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    itemId = json['itemId'];
    itemUnitId = json['itemUnitId'];
    itemCode = json['itemCode'];
    itemName = json['itemName'];
    packing = json['packing'];
    packingQuantity = json['packingQuantity'];
    quantity = json['quantity'];
    qtyReceived = json['qtyReceived'];
    packingReceived = json['packingReceived'];
    unitPrice = json['unitPrice'];
    discount = json['discount'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount'];
    total = json['total'];
    description = json['description'];
    uniqueId = json['uniqueId'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    itemUnit = json['itemUnit'] != null ? new ItemUnit.fromJson(json['itemUnit']) : null;
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    entityMode = json['entityMode'];
  }
}

class Item {
  var id;
  var code;
  var name;
  var brandName;
  var itemGroupId;
  var itemTypeId;
  var itemUnitId;
  var price;
  var entityMode;

  Item(
      {this.id,
      this.code,
      this.name,
      this.brandName,
      this.itemGroupId,
      this.itemTypeId,
      this.itemUnitId,
      this.price,
      this.entityMode});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    brandName = json['brandName'];
    itemGroupId = json['itemGroupId'];
    itemTypeId = json['itemTypeId'];
    itemUnitId = json['itemUnitId'];
    price = json['price'];
    entityMode = json['entityMode'];
  }
}

class ItemUnit {
  var id;
  var name;
  var sort;
  bool? isDefault;
  var entityMode;

  ItemUnit({this.id, this.name, this.sort, this.isDefault, this.entityMode});

  ItemUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    isDefault = json['isDefault'];
    entityMode = json['entityMode'];
  }
}
