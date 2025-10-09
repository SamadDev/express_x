class LoginResponse {
  String? accessToken;

  LoginResponse({this.accessToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['token'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['accessToken'] = this.accessToken;
    return data;
  }
}
