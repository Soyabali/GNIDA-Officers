import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helpers/loader_helper.dart';
import 'base_repo.dart';


class OtpVerificationRepo {

  // this is a loginApi call functin

  Future otpverification(BuildContext context, String mobileNo, String otp,String password) async {

    try {
      print('----mobileNo---$mobileNo');
      print('----otp---$otp');
      print('----password---$password');

      var baseURL = BaseRepo().baseurl;
      var endPoint = "UpdatePasswordFromForgotPass/UpdatePasswordFromForgotPass";
      var otpverificationApi = "$baseURL$endPoint";
      print('------------17---otpverificationApi---$otpverificationApi');

      showLoader();
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse('$otpverificationApi'));
      request.body = json.encode({"sContactNo": mobileNo, "sOtp": otp,"sPassword":password});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------20---LOGINaPI RESPONSE----$map');
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
