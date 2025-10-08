class OrderPaymentModule {
  String? id;
  String? paymentNumber;
  String? paidAmount;
  String? reNumber;
  String? currency;
  String? paymentDate;
  OrderPaymentModule({this.currency, this.id, this.paidAmount, this.paymentDate, this.reNumber});

  OrderPaymentModule.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    paymentNumber = json['paymentNo'].toString();
    paidAmount = json['paymentAmount'].toString();
    reNumber = json['refNo'].toString().toString();
    paymentDate = json['paymentDate'].toString();
    currency = json['currency']['symbol'].toString();
  }
}
