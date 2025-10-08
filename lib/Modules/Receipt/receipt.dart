class ReceiptModule {
  var debitAccountName;
  var creditAccountName;
  var currencyName;
  var toCurrencyName;
  var id;
  var name;
  var typeId;
  var docNo;
  var discount;
  var fee;
  var docDate;
  var paymentMethodName;
  var refNo;
  var refDate;
  var amount;
  var currencyId;
  var exchangeRate;
  var exchangeAmount;
  var description;
  var branchId;
  var uniqueId;
  bool? isTrashed;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;

  ReceiptModule(
      {this.debitAccountName,
        this.creditAccountName,
        this.currencyName,
        this.toCurrencyName,
        this.id,
        this.typeId,
        this.name,
        this.discount,
        this.docNo,
        this.docDate,
        this.refNo,
        this.paymentMethodName,
        this.refDate,
        this.amount,
        this.fee,
        this.currencyId,
        this.exchangeRate,
        this.exchangeAmount,
        this.description,
        this.branchId,
        this.uniqueId,
        this.isTrashed,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.entityMode});

  ReceiptModule.fromJson(Map<String, dynamic> json) {
    debitAccountName = json['debitAccountName'];
    creditAccountName = json['creditAccountName'];
    currencyName = json['currencyName'];
    toCurrencyName = json['toCurrencyName'];
    id = json['id'];
    typeId = json['typeId'];
    fee = json['fee'];
    discount = json['discount'];
    paymentMethodName = json['paymentMethodName'];
    docNo = json['docNo'];
    name = json['name'];
    docDate = json['docDate'];
    refNo = json['refNo'];
    refDate = json['refDate'];
    amount = json['amount'];
    currencyId = json['currencyId'];
    exchangeRate = json['exchangeRate'];
    exchangeAmount = json['exchangeAmount'];
    description = json['description'];
    branchId = json['branchId'];
    uniqueId = json['uniqueId'];
    isTrashed = json['isTrashed'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    entityMode = json['entityMode'];
  }
}