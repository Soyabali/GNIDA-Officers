import 'package:flutter/cupertino.dart';
import '../Helpers/loader_helper.dart';
import '../Models/login_models.dart';

// import '../Models/login_models.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? loginData;
  var data;
  authenticate(context, request) async {
    showLoader();
    print("request from provider $request");
   //  data = await LoginController().login(jsonEncode(request));
      print("-------16-----: ");
    print("data: $data");
    hideLoader();
    notifyListeners();
  }
}
