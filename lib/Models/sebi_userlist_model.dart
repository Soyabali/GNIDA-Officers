// // To parse this JSON data, do
// //
// //     final userListModel = userListModelFromJson(jsonString);

// import 'dart:convert';

// UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

// String userListModelToJson(UserListModel data) => json.encode(data.toJson());

// class UserListModel {
//     int id;
//     String name;
//     String email;
//     String mobile;
//     String password;
//     String userType;
//     String role;
//     int userStatus;
//     int createdBy;
//     DateTime createdOn;

//     UserListModel({
//         required this.id,
//         required this.name,
//         required this.email,
//         required this.mobile,
//         required this.password,
//         required this.userType,
//         required this.role,
//         required this.userStatus,
//         required this.createdBy,
//         required this.createdOn,
//     });

//     factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         mobile: json["mobile"],
//         password: json["password"],
//         userType: json["user_type"],
//         role: json["role"],
//         userStatus: json["user_status"],
//         createdBy: json["created_by"],
//         createdOn: DateTime.parse(json["created_on"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "mobile": mobile,
//         "password": password,
//         "user_type": userType,
//         "role": role,
//         "user_status": userStatus,
//         "created_by": createdBy,
//         "created_on": createdOn.toIso8601String(),
//     };
// }



// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

List<UserListModel> userListModelFromJson(String str) => List<UserListModel>.from(json.decode(str).map((x) => UserListModel.fromJson(x)));

String userListModelToJson(List<UserListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListModel {
    int id;
    Name? name;
    String email;
    String? mobile;
    String password;
    UserType? userType;
    String? role;
    int? userStatus;
    int? createdBy;
    DateTime createdOn;

    UserListModel({
        required this.id,
        this.name,
        required this.email,
        this.mobile,
        required this.password,
        this.userType,
        this.role,
        this.userStatus,
        this.createdBy,
        required this.createdOn,
    });

    factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        email: json["email"],
        mobile: json["mobile"],
        password: json["password"],
        userType: userTypeValues.map[json["user_type"]]!,
        role: json["role"],
        userStatus: json["user_status"],
        createdBy: json["created_by"],
        createdOn: DateTime.parse(json["created_on"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "email": email,
        "mobile": mobile,
        "password": password,
        "user_type": userTypeValues.reverse[userType],
        "role": role,
        "user_status": userStatus,
        "created_by": createdBy,
        "created_on": createdOn.toIso8601String(),
    };
}

enum Name { SURAJ, RAKESH, PRAKHAR, PRAKHARRAI }

final nameValues = EnumValues({
    "prakhar": Name.PRAKHAR,
    "prakharrai": Name.PRAKHARRAI,
    "rakesh": Name.RAKESH,
    "suraj": Name.SURAJ
});

enum UserType { WEB, MOBILE, USER_TYPE_MOBILE }

final userTypeValues = EnumValues({
    "Mobile": UserType.MOBILE,
    "mobile": UserType.USER_TYPE_MOBILE,
    "Web": UserType.WEB
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}



// class SebiUserModel {
//   final int id;
//   final String name;
//   final String email;
//   final String mobile;
//   final String password;
//   final String userType;
//   final String role;
//   final int userStatus;
//   final int createdBy;
//   final String createdOn;

//   SebiUserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.mobile,
//     required this.password,
//     required this.userType,
//     required this.role,
//     required this.userStatus,
//     required this.createdBy,
//     required this.createdOn,
//   });

//   factory SebiUserModel.fromJson(Map<String, dynamic> json) {
//     return SebiUserModel(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       mobile: json['mobile'],
//       password: json['password'],
//       userType: json['user_type'],
//       role: json['role'],
//       userStatus: json['user_status'],
//       createdBy: json['created_by'],
//       createdOn: json['created_on'],
//     );
//   }
// }
