import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sebi/Controllers/login_controller.dart';
import 'package:sebi/Helpers/loader_helper.dart';
import 'package:sebi/Models/login_models.dart';

// import '../Models/login_models.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? loginData;
  var data;
  authenticate(context, request) async {
    showLoader();
    print("request from provider $request");
     data = await LoginController().login(jsonEncode(request));
      print("-------16-----: ");
    print("data: $data");
    hideLoader();
    notifyListeners();
  }
}
