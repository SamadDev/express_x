class OpenOrderItemsModule{
  int? id;
  int? orderId;
  int? itemUnitId;
  String? itemCode;
  String? itemName;
  int? packing;
  int? packingQuantity;
  int? quantity;
  int? qtyReceived;
  int? packingReceived;
  int? unitPrice;
  int? discount;
  int? discountAmount;
  int? total;
  String? description;
  String? uniqueId;
  int? entityMode;

  OpenOrderItemsModule(
      {this.id,
        this.orderId,
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
        this.discountAmount,
        this.total,
        this.description,
        this.uniqueId,
        this.entityMode});

  OpenOrderItemsModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
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
    discountAmount = json['discountAmount'];
    total = json['total'];
    description = json['description'];
    uniqueId = json['uniqueId'];
    entityMode = json['entityMode'];
  }


}