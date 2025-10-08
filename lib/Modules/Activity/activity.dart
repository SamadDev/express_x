class ActivityModule {
  List<Debits>? debits;
  // List<Credits>? credits;
  List<Totals>? totals;
  List<Transactions>? transactions;
  // List<Null>? prevBalance;
  List<StatementBalance>? balance;

  ActivityModule({
    this.debits,
    // this.credits,
    this.totals,
    this.transactions,
    this.balance,
    // this.prevBalance, this.balance
  });

  ActivityModule.fromJson(Map<String, dynamic> json) {

    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }

    // if (json['transactions'] != null) {
    //   credits = <Credits>[];
    //   json['transactions'].forEach((v) {
    //     credits!.add(new Credits.fromJson(v));
    //   });
    // }
    if (json['totals'] != null) {
      totals = <Totals>[];
      json['totals'].forEach((v) {
        totals!.add(new Totals.fromJson(v));
      });
    }
    // if (json['Debits'] != null) {
    //   debits = <Debits>[];
    //   json['Debits'].forEach((v) {
    //     debits!.add(new Debits.fromJson(v));
    //   });
    // }
    // if (json['prevBalance'] != null) {
    //   prevBalance = <Null>[];
    //   json['prevBalance'].forEach((v) {
    //     prevBalance!.add(.fromJson(v));
    //   });
    // }
    if (json['balances'] != null) {
      balance = <StatementBalance>[];
      json['balances'].forEach((v) {
        balance!.add(new StatementBalance.fromJson(v));
      });
    }
  }
}

class Debits {
  var id;
  var documentTypeName;
  var documentNo;
  var documentDate;
  var refNo;
  var refDate;
  var debit;
  var credit;
  var amount;
  var dollar;
  var iqd;
  var exchangeRate;
  var exchangeAmount;
  var currencyName;
  var currencySymbol;
  var currencyColor;
  var fromCurrencyName;
  var fromCurrencySymbol;
  var fromCurrencyColor;
  var description;

  Debits(
      {this.id,
      this.documentTypeName,
      this.documentNo,
      this.documentDate,
      this.refNo,
      this.refDate,
      this.debit,
      this.credit,
      this.amount,
      this.dollar,
      this.iqd,
      this.exchangeRate,
      this.exchangeAmount,
      this.currencyName,
      this.currencySymbol,
      this.currencyColor,
      this.fromCurrencyName,
      this.fromCurrencySymbol,
      this.fromCurrencyColor,
      this.description});

  Debits.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    documentTypeName = json['DocumentType'];
    documentNo = json['DocumentNo'];
    documentDate = json['DocumentDate'];
    refNo = json['RefNo'];
    refDate = json['RefDate'];
    debit = json['Debit'];
    credit = json['Credit'];
    amount = json['Amount'];
    dollar = json['Dollar'];
    exchangeRate = json['ExchangeRate'];
    exchangeAmount = json['ExchangeAmount'];
    currencyName = json['CurrencyName'];
    currencySymbol = json['CurrencySymbol'];
    currencyColor = json['CurrencyColor'];
    fromCurrencyName = json['FromCurrencyName'];
    fromCurrencySymbol = json['FromCurrencySymbol'];
    fromCurrencyColor = json['FromCurrencyColor'];
    description = json['Description'];
  }
}

class Credits {
  var id;
  var documentTypeName;
  var documentNo;
  var documentDate;
  var refNo;
  var refDate;
  var debit;
  var credit;
  var amount;
  var exchangeRate;
  var exchangeAmount;
  var currencyName;
  var currencySymbol;
  var currencyColor;
  var fromCurrencyName;
  var fromCurrencySymbol;
  var fromCurrencyColor;
  var description;
  var dollar;

  Credits(
      {this.id,
      this.documentTypeName,
      this.documentNo,
      this.documentDate,
      this.refNo,
      this.refDate,
      this.debit,
      this.credit,
      this.amount,
      this.dollar,
      this.exchangeRate,
      this.exchangeAmount,
      this.currencyName,
      this.currencySymbol,
      this.currencyColor,
      this.fromCurrencyName,
      this.fromCurrencySymbol,
      this.fromCurrencyColor,
      this.description});

  Credits.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    documentTypeName = json['DocumentTypeName'];
    documentNo = json['DocumentNo'];
    documentDate = json['DocumentDate'];
    refNo = json['RefNo'];
    refDate = json['RefDate'];
    debit = json['Debit'];
    credit = json['Credit'];
    amount = json['Amount'];
    dollar = json['Dollar'];

    exchangeRate = json['ExchangeRate'];
    exchangeAmount = json['ExchangeAmount'];
    currencyName = json['CurrencyName'];
    currencySymbol = json['CurrencySymbol'];
    currencyColor = json['CurrencyColor'];
    fromCurrencyName = json['FromCurrencyName'];
    fromCurrencySymbol = json['FromCurrencySymbol'];
    fromCurrencyColor = json['FromCurrencyColor'];
    description = json['Description'];
  }
}

class Totals {
  var currencyName;
  var currencySymbol;
  var currencyColor;
  var totalDebit;
  var totalCredit;

  Totals({this.currencyName, this.currencySymbol, this.currencyColor, this.totalDebit, this.totalCredit});

  Totals.fromJson(Map<String, dynamic> json) {
    currencyName = json['CurrencyName'];
    currencySymbol = json['CurrencySymbol'];
    currencyColor = json['CurrencyColor'];
    totalDebit = json['TotalDebit'];
    totalCredit = json['TotalCredit'];
  }
}

class StatementBalance {
  int? currencyId;
  String? currencyCode;
  String? currencySymbol;
  double? balance;

  StatementBalance({this.currencyId, this.currencyCode, this.currencySymbol, this.balance});

  StatementBalance.fromJson(Map<String, dynamic> json) {
    currencyId = json['CurrencyId'];
    currencyCode = json['CurrencyCode'];
    currencySymbol = json['CurrencySymbol'];
    balance = json['Balance'];
  }
}

class Transactions {
  var id;
  String? documentType;
  String? url;
  String? accountName;
  String? documentNo;
  String? documentDate;
  double? debit;
  var credit;
  String? currencyName;
  String? exchangeRate;
  String?exchangeAmount;
  String? currencySymbol;
  double? balance;
  String? description;
  var rowNo;

  Transactions(
      {this.id,
      this.documentType,
      this.url,
      this.accountName,
      this.documentNo,
      this.documentDate,
      this.debit,
        this.exchangeRate,
        this.exchangeAmount,
      this.credit,
      this.currencyName,
      this.currencySymbol,
      this.balance,
      this.description,
      this.rowNo});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    documentType = json['DocumentType'];
    url = json['Url'];
    accountName = json['AccountName'];
    documentNo = json['DocumentNo'];
    documentDate = json['DocumentDate'];
    exchangeRate = json['ExchangeRate'];
    exchangeAmount = json['ExchangeAmount'];
    debit = json['Debit'];
    credit = json['Credit'];
    currencyName = json['CurrencyName'];
    currencySymbol = json['CurrencySymbol'];
    balance = json['Balance'];
    description = json['Description'];
    rowNo = json['RowNo'];
  }

}

//
// class ActivityModule {
//   List<Debits>? debits;
//   List<Credits>? credits;
//
//   List<PreviousBalances>? previousBalances;
//   List<StatementBalances>? balances;
//   List<Transactions>? transactions;
//
//   ActivityModule({this.previousBalances, this.credits, this.debits, this.balances, this.transactions});
//
//   ActivityModule.fromJson(Map<String, dynamic> json) {
//     if (json['Debit'] != null) {
//       debits = <Debits>[];
//       json['Debit'].forEach((v) {
//         debits!.add(new Debits.fromJson(v));
//       });
//     }
//     if (json['Credits'] != null) {
//       credits = <Credits>[];
//       json['Credits'].forEach((v) {
//         credits!.add(new Credits.fromJson(v));
//       });
//     }
//     if (json['previousBalances'] != null) {
//       previousBalances = <PreviousBalances>[];
//       json['previousBalances'].forEach((v) {
//         previousBalances!.add(new PreviousBalances.fromJson(v));
//       });
//     }
//     if (json['balances'] != null) {
//       balances = <StatementBalances>[];
//       json['balances'].forEach((v) {
//         balances!.add(new StatementBalances.fromJson(v));
//       });
//     }
//     if (json['transactions'] != null) {
//       transactions = <Transactions>[];
//       json['transactions'].forEach((v) {
//         transactions!.add(new Transactions.fromJson(v));
//       });
//     }
//   }
// }
//
// class PreviousBalances {
//   int? currencyId;
//   String? currencyCode;
//   String? currencySymbol;
//   int? balance;
//
//   PreviousBalances({this.currencyId, this.currencyCode, this.currencySymbol, this.balance});
//
//   PreviousBalances.fromJson(Map<String, dynamic> json) {
//     currencyId = json['CurrencyId'];
//     currencyCode = json['CurrencyCode'];
//     currencySymbol = json['CurrencySymbol'];
//     balance = json['Balance'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['CurrencyId'] = this.currencyId;
//     data['CurrencyCode'] = this.currencyCode;
//     data['CurrencySymbol'] = this.currencySymbol;
//     data['Balance'] = this.balance;
//     return data;
//   }
// }
//
// class StatementBalances {
//   int? currencyId;
//   String? currencyCode;
//   String? currencySymbol;
//   double? balance;
//
//   StatementBalances({this.currencyId, this.currencyCode, this.currencySymbol, this.balance});
//
//   StatementBalances.fromJson(Map<String, dynamic> json) {
//     currencyId = json['CurrencyId'];
//     currencyCode = json['CurrencyCode'];
//     currencySymbol = json['CurrencySymbol'];
//     balance = json['Balance'];
//   }
// }
//
// class Transactions {
//   int? id;
//   String? documentType;
//   String? url;
//   String? accountName;
//   String? documentNo;
//   String? documentDate;
//   double? debit;
//   int? credit;
//   String? currencyName;
//   String? currencySymbol;
//   double? balance;
//   String? description;
//   int? rowNo;
//
//   Transactions(
//       {this.id,
//       this.documentType,
//       this.url,
//       this.accountName,
//       this.documentNo,
//       this.documentDate,
//       this.debit,
//       this.credit,
//       this.currencyName,
//       this.currencySymbol,
//       this.balance,
//       this.description,
//       this.rowNo});
//
//   Transactions.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     documentType = json['DocumentType'];
//     url = json['Url'];
//     accountName = json['AccountName'];
//     documentNo = json['DocumentNo'];
//     documentDate = json['DocumentDate'];
//     debit = json['Debit'];
//     credit = json['Credit'];
//     currencyName = json['CurrencyName'];
//     currencySymbol = json['CurrencySymbol'];
//     balance = json['Balance'];
//     description = json['Description'];
//     rowNo = json['RowNo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['DocumentType'] = this.documentType;
//     data['Url'] = this.url;
//     data['AccountName'] = this.accountName;
//     data['DocumentNo'] = this.documentNo;
//     data['DocumentDate'] = this.documentDate;
//     data['Debit'] = this.debit;
//     data['Credit'] = this.credit;
//     data['CurrencyName'] = this.currencyName;
//     data['CurrencySymbol'] = this.currencySymbol;
//     data['Balance'] = this.balance;
//     data['Description'] = this.description;
//     data['RowNo'] = this.rowNo;
//     return data;
//   }
// }

// class Debits {
//   var id;
//   var documentTypeName;
//   var documentNo;
//   var documentDate;
//   var refNo;
//   var refDate;
//   var debit;
//   var credit;
//   var amount;
//   var dollar;
//   var iqd;
//   var exchangeRate;
//   var exchangeAmount;
//   var currencyName;
//   var currencySymbol;
//   var currencyColor;
//   var fromCurrencyName;
//   var fromCurrencySymbol;
//   var fromCurrencyColor;
//   var description;
//
//   Debits(
//       {this.id,
//       this.documentTypeName,
//       this.documentNo,
//       this.documentDate,
//       this.refNo,
//       this.refDate,
//       this.debit,
//       this.credit,
//       this.amount,
//       this.dollar,
//       this.iqd,
//       this.exchangeRate,
//       this.exchangeAmount,
//       this.currencyName,
//       this.currencySymbol,
//       this.currencyColor,
//       this.fromCurrencyName,
//       this.fromCurrencySymbol,
//       this.fromCurrencyColor,
//       this.description});
//
//   Debits.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     documentTypeName = json['DocumentTypeName'];
//     documentNo = json['DocumentNo'];
//     documentDate = json['DocumentDate'];
//     refNo = json['RefNo'];
//     refDate = json['RefDate'];
//     debit = json['Debit'];
//     credit = json['Credit'];
//     amount = json['Amount'];
//     dollar = json['Dollar'];
//     exchangeRate = json['ExchangeRate'];
//     exchangeAmount = json['ExchangeAmount'];
//     currencyName = json['CurrencyName'];
//     currencySymbol = json['CurrencySymbol'];
//     currencyColor = json['CurrencyColor'];
//     fromCurrencyName = json['FromCurrencyName'];
//     fromCurrencySymbol = json['FromCurrencySymbol'];
//     fromCurrencyColor = json['FromCurrencyColor'];
//     description = json['Description'];
//   }
// }
//
// class Credits {
//   var id;
//   var documentTypeName;
//   var documentNo;
//   var documentDate;
//   var refNo;
//   var refDate;
//   var debit;
//   var credit;
//   var amount;
//   var exchangeRate;
//   var exchangeAmount;
//   var currencyName;
//   var currencySymbol;
//   var currencyColor;
//   var fromCurrencyName;
//   var fromCurrencySymbol;
//   var fromCurrencyColor;
//   var description;
//   var dollar;
//
//   Credits(
//       {this.id,
//       this.documentTypeName,
//       this.documentNo,
//       this.documentDate,
//       this.refNo,
//       this.refDate,
//       this.debit,
//       this.credit,
//       this.amount,
//       this.dollar,
//       this.exchangeRate,
//       this.exchangeAmount,
//       this.currencyName,
//       this.currencySymbol,
//       this.currencyColor,
//       this.fromCurrencyName,
//       this.fromCurrencySymbol,
//       this.fromCurrencyColor,
//       this.description});
//
//   Credits.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     documentTypeName = json['DocumentTypeName'];
//     documentNo = json['DocumentNo'];
//     documentDate = json['DocumentDate'];
//     refNo = json['RefNo'];
//     refDate = json['RefDate'];
//     debit = json['Debit'];
//     credit = json['Credit'];
//     amount = json['Amount'];
//     dollar = json['Dollar'];
//
//     exchangeRate = json['ExchangeRate'];
//     exchangeAmount = json['ExchangeAmount'];
//     currencyName = json['CurrencyName'];
//     currencySymbol = json['CurrencySymbol'];
//     currencyColor = json['CurrencyColor'];
//     fromCurrencyName = json['FromCurrencyName'];
//     fromCurrencySymbol = json['FromCurrencySymbol'];
//     fromCurrencyColor = json['FromCurrencyColor'];
//     description = json['Description'];
//   }
// }
