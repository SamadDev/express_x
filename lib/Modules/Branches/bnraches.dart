class BranchesModel {
  var id;
  var name;
  var nameAR;
  var nameKR;
  var countryId;
  var cityId;
  var phoneNo1;
  var phoneNo2;
  var address;
  var address2;
  var phoneCode1;
  var phoneCode2;
  var latitude;
  var longitude;
  var website;
  Country? country;
  City? city;
  var entityMode;

  BranchesModel(
      {this.id,
        this.name,
        this.nameAR,
        this.nameKR,
        this.countryId,
        this.cityId,
        this.phoneNo1,
        this.phoneNo2,
        this.address,
        this.address2,
        this.phoneCode1,
        this.phoneCode2,
        this.latitude,
        this.longitude,
        this.website,
        this.country,
        this.city,
        this.entityMode});

  BranchesModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
    nameAR = json['nameAR']??"";
    nameKR = json['nameKR']??"";
    countryId = json['countryId']??"";
    cityId = json['cityId']??"";
    phoneNo1 = json['phoneNo1']??"";
    phoneNo2 = json['phoneNo2']??"";
    phoneCode1 = json['phoneCode1']??"";
    phoneCode2 = json['phoneCode2']??"";
    address = json['address']??"";
    address2 = json['address2']??"";
    latitude = json['latitude'] ??"";
    longitude = json['longitude']??"";
    website = json['website']??"";
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    entityMode = json['entityMode'];
  }
}

class Country {
  var id;
  var name;
  var code;
  var phoneCode;
  var phoneMask;
  bool? isDefault;
  var image;
  var entityMode;

  Country(
      {this.id,
        this.name,
        this.code,
        this.phoneCode,
        this.phoneMask,
        this.isDefault,
        this.image,
        this.entityMode});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    phoneCode = json['phoneCode'];
    phoneMask = json['phoneMask'];
    isDefault = json['isDefault'];
    image = json['image'];
    entityMode = json['entityMode'];
  }
}

class City {
  var id;
  var countryId;
  var zoneId;
  var name;
  bool? isDefault;
  var entityMode;

  City(
      {this.id,
        this.countryId,
        this.zoneId,
        this.name,
        this.isDefault,
        this.entityMode});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['countryId'];
    zoneId = json['zoneId'];
    name = json['name'];
    isDefault = json['isDefault'];
    entityMode = json['entityMode'];
  }
}