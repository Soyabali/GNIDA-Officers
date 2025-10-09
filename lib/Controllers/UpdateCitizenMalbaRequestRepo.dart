
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import '../screens/generalFunction.dart';
import 'baseurl.dart';


class UpdateCitizenMalbaRequestRepo {

  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future updateCitizenMalba(BuildContext context, sReqNo, String remarks, uplodedImage, double? lat, double? long, locationAddress) async {

    /// Here you should get a value from a sharedPreferenc that is stored at a login time.
    ///
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');

    try {

      var baseURL = BaseRepo().baseurl;
      var endPoint = "UpdateCitizenMalbaRequest/UpdateCitizenMalbaRequest";
      var updateCitizenApi = "$baseURL$endPoint";
      print('------------17---updateCitizenApi---$updateCitizenApi');

      showLoader();
      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$updateCitizenApi'));
      request.body = json.encode({
        "sReqNo": sReqNo,
        "iUserId": iUserId,
        "sRemarks": remarks,
        "sResolveImage": uplodedImage,
        "fResolvedLat": lat,
        "fResolvedLon": long,
        "sResolveLoc": locationAddress,

      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------50---UpdateCitizenMalbaRequest Response----$map');
      if(response.statusCode ==401){
        generalFunction.logout(context);
      }

      if (response.statusCode == 200) {
        hideLoader();
        print('----------53-----$map');
        return map;
      } else{
        print('----------29---UpdateCitizenMalbaRequest Response----$map');
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

