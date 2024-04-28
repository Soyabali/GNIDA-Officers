import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';

class ForgotPassWordRepo {

  Future forgotpassword(BuildContext context, String phone) async {

    try {
       print('----Phone---12-----$phone');

       var baseURL = BaseRepo().baseurl;
      var endPoint = "SendOTPForForgotPassword/SendOTPForForgotPassword";
      var forgotpasswordApi = "$baseURL$endPoint";
      print('------------17---versionApi---$forgotpasswordApi');

      showLoader();
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse('$forgotpasswordApi'));
      request.body = json.encode({"sContactNo": phone});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------20---forgotPassWord----$map');

      if (response.statusCode == 200) {
        hideLoader();
        print('----------22-----$map');
        return map;
      } else {
        print('----------29---LOGINaPI RESPONSE----$map');
        hideLoader();
        print(response.reasonPhrase);
        return map;
      }
    } catch (e) {
      hideLoader();
      debugPrint("exception: $e");
      throw e;
    }
  }
}
