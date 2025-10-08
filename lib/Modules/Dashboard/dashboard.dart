class DashboardModule {
  List<Balance>? balance;
  List<Stats>? stats;
  List<Totals>? totals;
  List<CurrencyRates>? currencyRate;
  List<ShipmentModule>? shipments;
  List<Transactions>? transactions;
  Inventory? inventory;
  ShipmentStats? shipmentStats;

  DashboardModule({this.balance, this.stats, this.totals, this.shipments, this.shipmentStats, this.inventory});

  DashboardModule.fromJson(Map<String, dynamic> json) {
    if (json['balance'] != null) {
      balance = <Balance>[];
      json['balance'].forEach((v) {
        balance!.add(new Balance.fromJson(v));
      });
    }
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(new Stats.fromJson(v));
      });
    }
    if (json['totals'] != null) {
      totals = <Totals>[];
      json['totals'].forEach((v) {
        totals!.add(new Totals.fromJson(v));
      });
    }
    if (json['shipments'] != null) {
      shipments = <ShipmentModule>[];
      json['shipments'].forEach((v) {
        shipments!.add(new ShipmentModule.fromJson(v));
      });
    }

    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }

    if (json['currencyRates'] != null) {
      currencyRate = <CurrencyRates>[];
      json['currencyRates'].forEach((v) {
        currencyRate!.add(CurrencyRates.fromJson(v));
      });
    }

    inventory = json['inventory'] != null ?  Inventory.fromJson(json['inventory']) : null;

    shipmentStats = json['shipmentStats'] != null ?  ShipmentStats.fromJson(json['shipmentStats']) : null;
  }
}

class Balance {
  var currencyName;
  var currencySymbol;
  var currencyColor;
  var balance;
  var CurrencyCode;
  var documentDate;

  Balance(
      {this.currencyName, this.currencySymbol, this.currencyColor, this.balance, this.documentDate, this.CurrencyCode});

  Balance.fromJson(Map<String, dynamic> json) {
    currencyName = json['CurrencyName'];
    CurrencyCode = json['CurrencyCode'];
    currencySymbol = json['CurrencySymbol'];
    currencyColor = json['CurrencyColor'];
    balance = json['Balance'];
    documentDate = json['DocumentDate'];
  }
}

class CurrencyRates {
  var date;
  var rate;
  var description;
  var exchangeRate;
  var fromCurrencySymbol;
  var toCurrencySymbol;

  CurrencyRates(
      {this.date, this.description, this.exchangeRate, this.fromCurrencySymbol, this.toCurrencySymbol, this.rate});

  CurrencyRates.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    rate = json['Rate'];
    description = json['Description'];
    exchangeRate = json['ExchangeRate'];
    fromCurrencySymbol = json['FromCurrencySymbol'];
    toCurrencySymbol = json['ToCurrencySymbol'];
  }
}

class Transactions {
  var documentNo;
  var documentDate;
  var documentType;
  var description;
  var amount;
  var currencySymbol;
  var icon;

  Transactions(
      {this.documentNo,
      this.documentDate,
      this.documentType,
      this.description,
      this.amount,
      this.currencySymbol,
      this.icon});

  Transactions.fromJson(Map<String, dynamic> json) {
    documentNo = json['DocumentNo'];
    documentDate = json['DocumentDate'];
    documentType = json['DocumentType'];
    description = json['Description'];
    amount = json['Amount'];
    currencySymbol = json['CurrencySymbol'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentNo'] = this.documentNo;
    data['DocumentDate'] = this.documentDate;
    data['DocumentType'] = this.documentType;
    data['Description'] = this.description;
    data['Amount'] = this.amount;
    data['CurrencySymbol'] = this.currencySymbol;
    data['Icon'] = this.icon;
    return data;
  }
}

class Inventory {
  var totalQty;
  var totalCBM;
  var totalWeight;

  Inventory({this.totalQty, this.totalCBM, this.totalWeight});

  Inventory.fromJson(Map<String, dynamic> json) {
    totalQty = json['TotalQty'];
    totalCBM = json['TotalCBM'];
    totalWeight = json['TotalWeight'];
  }
}

class ShipmentStats {
  var totalQty;
  var totalCBM;
  var totalWeight;

  ShipmentStats({this.totalQty, this.totalCBM, this.totalWeight});

  ShipmentStats.fromJson(Map<String, dynamic> json) {
    totalQty = json['TotalQty'];
    totalCBM = json['TotalCBM'];
    totalWeight = json['TotalWeight'];
  }
}

class Stats {
  var type;
  var total;

  Stats({this.type, this.total});

  Stats.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Total'] = this.total;
    return data;
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

///shipment module
class ShipmentModule {
  var id;
  var shipmentNo;
  var shipmentDate;
  var containerNo;
  late final deliveryRate;
  var containerTypeName;
  var totalPacking;
  var totalCBM;
  var totalWeight;
  var statusId;
  var fromLocationName;
  var toLocationName;
  var deliveryDate;
  var statusName;
  var statusColor;
  var statusClass;
  var locationName;
  var warehouseName;
  bool? approved;
  var description;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  bool? isTrashed;
  var trashedBy;
  var trashedDate;
  var totalRecords;

  ShipmentModule(
      {this.id,
      this.shipmentNo,
      this.shipmentDate,
      this.containerNo,
      this.containerTypeName,
      this.totalPacking,
      this.totalCBM,
      this.totalWeight,
      this.statusId,
      this.fromLocationName,
      this.toLocationName,
      this.deliveryDate,
      this.statusName,
      this.statusColor,
      this.statusClass,
      this.deliveryRate,
      this.locationName,
      this.warehouseName,
      this.approved,
      this.description,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.isTrashed,
      this.trashedBy,
      this.trashedDate,
      this.totalRecords});

  ShipmentModule.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    shipmentNo = json['ShipmentNo'];
    shipmentDate = json['ShipmentDate'];
    containerNo = json['ContainerNo'];
    containerTypeName = json['ContainerTypeName'];
    totalPacking = json['TotalPacking'];
    totalCBM = json['TotalCBM'];
    totalWeight = json['TotalWeight'];
    statusId = json['StatusId'];
    fromLocationName = json['FromLocationName'];
    toLocationName = json['ToLocationName'];
    deliveryDate = json['DeliveryDate'];
    statusName = json['StatusName'];
    statusColor = json['StatusColor'];
    statusClass = json['StatusClass'];
    deliveryRate = json['DeliveryRate'];
    locationName = json['LocationName'];
    warehouseName = json['WarehouseName'];
    approved = json['Approved'];
    description = json['Description'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    isTrashed = json['IsTrashed'];
    trashedBy = json['TrashedBy'];
    trashedDate = json['TrashedDate'];
    totalRecords = json['TotalRecords'];
  }
}
