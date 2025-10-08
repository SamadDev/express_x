class CurrencyTypeModule {
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
  bool? isCheck;

  CurrencyTypeModule(
      {this.id,
      this.code,
      this.name,
      this.nameAR,
      this.symbol,
      this.isDefault,
      this.rate,
      this.color,
      this.sort,
      this.isCheck = false,
      this.precision,
      this.entityMode});

  CurrencyTypeModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    nameAR = json['nameAR'];
    symbol = json['symbol'];
    isDefault = json['isDefault'];
    rate = json['rate'];
    color = json['color'];
    sort = json['sort'];
    isCheck = json['isCheck'];
    precision = json['precision'];
    entityMode = json['entityMode'];
  }
}
