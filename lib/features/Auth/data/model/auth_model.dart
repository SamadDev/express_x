class LoginResponse {
  String? requertAt;
  String? expiresIn;
  String? tokeyType;
  String? accessToken;
  User? user;

  LoginResponse({this.requertAt, this.expiresIn, this.tokeyType, this.accessToken, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    requertAt = json['requertAt'].toString();
    expiresIn = json['expiresIn'].toString();
    tokeyType = json['tokeyType'].toString();
    accessToken = json['accessToken'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requertAt'] = this.requertAt;
    data['expiresIn'] = this.expiresIn;
    data['tokeyType'] = this.tokeyType;
    data['accessToken'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? userName;
  String? employeeId;
  String? password;
  String? tempPassword;
  String? tempSendEmail;
  String? passwordSalt;
  String? email;
  String? phoneNo;
  String? photo;
  String? description;
  String? isActive;
  String? lastLoginDate;
  String? lastPasswordChangedDate;
  String? roleId;
  String? role;
  String? roleIdGuid;
  String? roleName;
  String? expiryDate;
  String? signature;
  String? token;
  String? resetCode;
  String? isTrashed;
  String? branches;
  String? employee;
  String? jobTitle;
  String? fullName;
  String? newPassword;

  User(
      {this.id,
      this.userName,
      this.employeeId,
      this.password,
      this.tempPassword,
      this.tempSendEmail,
      this.passwordSalt,
      this.email,
      this.phoneNo,
      this.photo,
      this.description,
      this.isActive,
      this.lastLoginDate,
      this.lastPasswordChangedDate,
      this.roleId,
      this.role,
      this.roleIdGuid,
      this.roleName,
      this.expiryDate,
      this.signature,
      this.token,
      this.resetCode,
      this.isTrashed,
      this.branches,
      this.employee,
      this.jobTitle,
      this.fullName,
      this.newPassword});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userName = json['userName'].toString();
    employeeId = json['employeeId'].toString();
    password = json['password'].toString();
    tempPassword = json['tempPassword'].toString();
    tempSendEmail = json['tempSendEmail'].toString();
    passwordSalt = json['passwordSalt'].toString();
    email = json['email'].toString();
    phoneNo = json['phoneNo'].toString();
    photo = json['photo'].toString();
    description = json['description'].toString();
    isActive = json['isActive'].toString();
    lastLoginDate = json['lastLoginDate'].toString();
    lastPasswordChangedDate = json['lastPasswordChangedDate'].toString();
    roleId = json['roleId'].toString();
    role = json['role'].toString();
    roleIdGuid = json['roleIdGuid'].toString();
    roleName = json['roleName'].toString();
    expiryDate = json['expiryDate'].toString();
    signature = json['signature'].toString();
    token = json['token'].toString();
    resetCode = json['resetCode'].toString();
    isTrashed = json['isTrashed'].toString();
    branches = json['branches'].toString();
    employee = json['employee'].toString();
    jobTitle = json['jobTitle'].toString();
    fullName = json['fullName'].toString();
    newPassword = json['newPassword'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['employeeId'] = this.employeeId;
    data['password'] = this.password;
    data['tempPassword'] = this.tempPassword;
    data['tempSendEmail'] = this.tempSendEmail;
    data['passwordSalt'] = this.passwordSalt;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['lastLoginDate'] = this.lastLoginDate;
    data['lastPasswordChangedDate'] = this.lastPasswordChangedDate;
    data['roleId'] = this.roleId;
    data['role'] = this.role;
    data['roleIdGuid'] = this.roleIdGuid;
    data['roleName'] = this.roleName;
    data['expiryDate'] = this.expiryDate;
    data['signature'] = this.signature;
    data['token'] = this.token;
    data['resetCode'] = this.resetCode;
    data['isTrashed'] = this.isTrashed;
    data['branches'] = this.branches;
    data['employee'] = this.employee;
    data['jobTitle'] = this.jobTitle;
    data['fullName'] = this.fullName;
    data['newPassword'] = this.newPassword;
    return data;
  }
}
