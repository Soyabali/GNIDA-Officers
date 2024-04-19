// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int status;
  String data;
  String token;
  String usertype;
  String mail;
  String role;
  String name;
  String userid;
  String mobile;

  LoginModel({
    required this.status,
    required this.data,
    required this.token,
    required this.usertype,
    required this.mail,
    required this.role,
    required this.name,
    required this.userid,
    required this.mobile,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: json["data"],
        token: json["token"],
        usertype: json["usertype"],
        mail: json["mail"],
        role: json["role"],
        name: json["name"],
        userid: json["userid"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "token": token,
        "usertype": usertype,
        "mail": mail,
        "role": role,
        "name": name,
        "userid": userid,
        "mobile": mobile,
      };
}
