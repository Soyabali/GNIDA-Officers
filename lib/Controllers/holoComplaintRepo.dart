import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noidaone/screens/generalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class HoloComplaintRepo {

  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();



  Future holoComplaint(BuildContext context,int iHold,String? imageFile, String iCompCode) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');

    try {
      print('----iHold---25--$iHold');
      print('----sHoldDocument----26--$imageFile');
      print('----iCompCode----27--$iCompCode');

      var baseURL = BaseRepo().baseurl;
      var endPoint = "UpdateHoldStatus/UpdateHoldStatus";
      var holdCompolaintApi = "$baseURL$endPoint";
      print('------------17---holdComplaint---$holdCompolaintApi');

      showLoader();

      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$holdCompolaintApi'));
      request.body = json.encode({
        "iCompCode": "$iCompCode",
        "iHold": iHold,
        "sHoldDocument": imageFile,
        "iHoldBy": iUserId,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------20---holo Complaint RESPONSE----$map');


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
