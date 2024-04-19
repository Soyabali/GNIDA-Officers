// import 'package:sebi/Controllers/base_controller.dart';
// import 'dart:convert';

import 'package:sebi/Services/base_client.dart';
import 'package:sebi/Controllers/base_controller.dart';

class LoginController extends BaseController {
  var baseUrlLogin = "http://49.50.118.112:8080/sebi-api/sebi-api-jwt/";

  Future login(request) async {
    var response = BaseClient()
        .post(baseUrlLogin, 'authenticate', request)
        .catchError(handleError);
    print("=-=-=-=-=-=-> from $response");
    return response;
  }
}
