class CustomerModule {
  var id;
  var code;
  var name;
  var nameAR;
  var groupId;
  var statusId;
  var sourceId;
  var phoneCode;
  var phoneNo;
  var phoneCode2;
  var phoneNo2;
  var email;
  var cityId;
  var address;
  var description;
  var accountId;
  var uniqueId;
  List<Codes>? customerCodes;
  var createdBy;
  var createdDate;
  var modifiedBy;
  var modifiedDate;
  var entityMode;

  CustomerModule(
      {this.id,
      this.code,
      this.name,
      this.nameAR,
      this.groupId,
      this.statusId,
      this.sourceId,
      this.phoneCode,
      this.phoneNo,
      this.phoneCode2,
      this.phoneNo2,
      this.email,
      this.cityId,
      this.address,
      this.description,
      this.accountId,
      this.uniqueId,
      this.customerCodes,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.entityMode});

  CustomerModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    nameAR = json['nameAR'];
    groupId = json['groupId'];
    statusId = json['statusId'];
    sourceId = json['sourceId'];
    phoneCode = json['phoneCode'];
    phoneNo = json['phoneNo'];
    phoneCode2 = json['phoneCode2'];
    phoneNo2 = json['phoneNo2'];
    email = json['email'];
    cityId = json['cityId'];
    address = json['address'];
    description = json['description'];
    accountId = json['accountId'];
    uniqueId = json['uniqueId'];
    if (json['codes'] != null) {
      customerCodes = <Codes>[];
      json['codes'].forEach((v) {
        customerCodes!.add(new Codes.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
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
