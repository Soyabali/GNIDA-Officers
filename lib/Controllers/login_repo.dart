import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noidaone/screens/generalFunction.dart';
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class LoginRepo1 {

  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future authenticate(BuildContext context, String number, String pass) async {

    try {
      print('----Number---$number');
      print('----PassWord---$pass');

      var baseURL = BaseRepo().baseurl;
      var endPoint = "AppLogin/AppLogin";
      var loginApi = "$baseURL$endPoint";
      print('------------17---loginAPI---$loginApi');

      showLoader();
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse('$loginApi'));
      request.body = json.encode({"sContactNo": number, "sPassword": pass,"sAppVersion":1});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------20---LOGINaPI RESPONSE----$map');


      if (response.statusCode == 200) {
        // create an instance of auth class
        print('----44-${response.statusCode}');
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
