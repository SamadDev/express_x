
class DetailsModule {
  int? id;
  int? orderId;
  int? itemId;
  int? itemUnitId;
  String? itemCode;
  int? packing;
  int? packingQuantity;
  int? quantity;
  int? qtyReceived;
  int? packingReceived;
  int? unitPrice;
  int? discount;
  String? discountType;
  int? discountAmount;
  int? total;
  String? description;
  String? uniqueId;
  Item? item;
  ItemUnit? itemUnit;
  String? createdBy;
  String? createdDate;
  String? modifiedBy;
  String? modifiedDate;
  int? entityMode;

  DetailsModule({this.id, this.orderId, this.itemId, this.itemUnitId, this.itemCode, this.packing, this.packingQuantity, this.quantity, this.qtyReceived, this.packingReceived, this.unitPrice, this.discount, this.discountType, this.discountAmount, this.total, this.description, this.uniqueId, this.item, this.itemUnit, this.createdBy, this.createdDate, this.modifiedBy, this.modifiedDate, this.entityMode});

  DetailsModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    itemId = json['itemId'];
    itemUnitId = json['itemUnitId'];
    itemCode = json['itemCode'];
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
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['itemId'] = this.itemId;
    data['itemUnitId'] = this.itemUnitId;
    data['itemCode'] = this.itemCode;
    data['packing'] = this.packing;
    data['packingQuantity'] = this.packingQuantity;
    data['quantity'] = this.quantity;
    data['qtyReceived'] = this.qtyReceived;
    data['packingReceived'] = this.packingReceived;
    data['unitPrice'] = this.unitPrice;
    data['discount'] = this.discount;
    data['discountType'] = this.discountType;
    data['discountAmount'] = this.discountAmount;
    data['total'] = this.total;
    data['description'] = this.description;
    data['uniqueId'] = this.uniqueId;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.itemUnit != null) {
      data['itemUnit'] = this.itemUnit!.toJson();
    }
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    data['entityMode'] = this.entityMode;
    return data;
  }
}

class Item {
  int? id;
  String? code;
  String? name;
  String? brandName;
  var scientificName;
  int? itemGroupId;
  int? itemTypeId;
  int? itemUnitId;
  var supplierId;
  int? price;
  var description;
  var group;
  var type;
  var unit;
  var supplier;
  var translations;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  int? entityMode;

  Item({this.id, this.code, this.name, this.brandName, this.scientificName, this.itemGroupId, this.itemTypeId, this.itemUnitId, this.supplierId, this.price, this.description, this.group, this.type, this.unit, this.supplier, this.translations, this.createdBy, this.createdDate, this.modifiedBy, this.modifiedDate, this.entityMode});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    brandName = json['brandName'];
    scientificName = json['scientificName'];
    itemGroupId = json['itemGroupId'];
    itemTypeId = json['itemTypeId'];
    itemUnitId = json['itemUnitId'];
    supplierId = json['supplierId'];
    price = json['price'];
    description = json['description'];
    group = json['group'];
    type = json['type'];
    unit = json['unit'];
    supplier = json['supplier'];
    translations = json['translations'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['brandName'] = this.brandName;
    data['scientificName'] = this.scientificName;
    data['itemGroupId'] = this.itemGroupId;
    data['itemTypeId'] = this.itemTypeId;
    data['itemUnitId'] = this.itemUnitId;
    data['supplierId'] = this.supplierId;
    data['price'] = this.price;
    data['description'] = this.description;
    data['group'] = this.group;
    data['type'] = this.type;
    data['unit'] = this.unit;
    data['supplier'] = this.supplier;
    data['translations'] = this.translations;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    data['entityMode'] = this.entityMode;
    return data;
  }
}

class ItemUnit {
  int? id;
  String? name;
  int? sort;
  bool? isDefault;
  var description;
  var translations;
  var createdBy;
  var createdDate;
  String? modifiedBy;
  String? modifiedDate;
  int? entityMode;

  ItemUnit({this.id, this.name, this.sort, this.isDefault, this.description, this.translations, this.createdBy, this.createdDate, this.modifiedBy, this.modifiedDate, this.entityMode});

  ItemUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    isDefault = json['isDefault'];
    description = json['description'];
    translations = json['translations'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sort'] = this.sort;
    data['isDefault'] = this.isDefault;
    data['description'] = this.description;
    data['translations'] = this.translations;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    data['entityMode'] = this.entityMode;
    return data;
  }
}