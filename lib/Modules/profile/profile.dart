class ProfileModule {
  String? name;
  String? nameAR;
  bool? isActive;
  var photo;
  bool? forceChangePassword;
  String? lastLoginDate;
  String? refreshToken;
  String? refreshTokenExpiryTime;
  bool? isTrashed;
  String? userType;
  int? totalRecords;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool? emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  bool? lockoutEnabled;
  int? accessFailedCount;

  ProfileModule(
      {this.name,
      this.nameAR,
      this.isActive,
      this.forceChangePassword,
      this.lastLoginDate,
      this.refreshToken,
      this.refreshTokenExpiryTime,
      this.isTrashed,
      this.userType,
      this.totalRecords,
      this.id,
      this.photo,
      this.userName,
      this.normalizedUserName,
      this.email,
      this.normalizedEmail,
      this.emailConfirmed,
      this.passwordHash,
      this.securityStamp,
      this.concurrencyStamp,
      this.phoneNumber,
      this.phoneNumberConfirmed,
      this.twoFactorEnabled,
      this.lockoutEnabled,
      this.accessFailedCount});

  ProfileModule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameAR = json['nameAR'];
    isActive = json['isActive'];
    photo = json['photo'];
    forceChangePassword = json['forceChangePassword'];
    lastLoginDate = json['lastLoginDate'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiryTime = json['refreshTokenExpiryTime'];
    isTrashed = json['isTrashed'];
    userType = json['userType'];
    totalRecords = json['totalRecords'];
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    normalizedEmail = json['normalizedEmail'];
    emailConfirmed = json['emailConfirmed'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
  }
}
