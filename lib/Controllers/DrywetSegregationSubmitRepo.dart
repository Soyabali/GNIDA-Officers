import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class DrywetSegregationSumitRepo {

  // this is a loginApi call functin

  Future drywetsegregation(BuildContext context, String sector, String location,
      String remarks,File? imagePath) async {

    try {
      print('----sector---$sector');
      print('----location---$location');
      print('----remarks---$remarks');
      print('----imagePath---$imagePath');

      var baseURL = BaseRepo().baseurl;
      var endPoint = "AppLogin/AppLogin";
      var loginApi = "$baseURL$endPoint";
      print('------------17---loginAPI---$loginApi');

      showLoader();
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse('$loginApi'));
      request.body = json.encode({"sContactNo": sector, "sPassword": location,"sAppVersion":1});
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
