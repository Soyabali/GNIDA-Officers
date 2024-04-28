import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class   MarkPointSubmitRepo {

  // this is a loginApi call functin

  Future markpointsubmit(BuildContext context, String markLocation,
      String sector,String location,String description,File? imagePath) async {

    try {
      print('----markLocation---$markLocation');
      print('----sector---$sector');
      print('----location---$location');
      print('----description---$description');
      print('----imagePath---$imagePath');


      var baseURL = BaseRepo().baseurl;
      /// TODO CHANGE HERE
      var endPoint = "AppLogin/AppLogin";
      var markPointSubmitApi = "$baseURL$endPoint";
      print('------------17---loginAPI---$markPointSubmitApi');

      showLoader();
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse('$markPointSubmitApi'));
      request.body = json.encode({"sContactNo": markLocation, "sPassword": sector,"sAppVersion":description});
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
