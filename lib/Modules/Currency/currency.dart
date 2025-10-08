class CurrencyModule {
  var id;
  var date;
  var fromCurrencyId;
  var toCurrencyId;
  var exchangeRate;
  var description;
  FromCurrency? fromCurrency;
  FromCurrency? toCurrency;
  var entityMode;

  CurrencyModule(
      {this.id,
        this.date,
        this.fromCurrencyId,
        this.toCurrencyId,
        this.exchangeRate,
        this.description,
        this.fromCurrency,
        this.toCurrency,
        this.entityMode});

  CurrencyModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    fromCurrencyId = json['fromCurrencyId'];
    toCurrencyId = json['toCurrencyId'];
    exchangeRate = json['exchangeRate'];
    description = json['description'];
    fromCurrency = json['fromCurrency'] != null
        ? new FromCurrency.fromJson(json['fromCurrency'])
        : null;
    toCurrency = json['toCurrency'] != null
        ? new FromCurrency.fromJson(json['toCurrency'])
        : null;
    entityMode = json['entityMode'];
  }
}

class FromCurrency {
  var id;
  var code;
  var name;
  var nameAR;
  var symbol;
  bool? isDefault;
  var rate;
  var color;
  var sort;
  var entityMode;

  FromCurrency(
      {this.id,
        this.code,
        this.name,
        this.nameAR,
        this.symbol,
        this.isDefault,
        this.rate,
        this.color,
        this.sort,
        this.entityMode});

  FromCurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    nameAR = json['nameAR'];
    symbol = json['symbol'];
    isDefault = json['isDefault'];
    rate = json['rate'];
    color = json['color'];
    sort = json['sort'];
    entityMode = json['entityMode'];
  }
}