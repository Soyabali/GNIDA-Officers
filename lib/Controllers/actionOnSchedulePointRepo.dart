import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class ActionOnScheduleRepo {

  Future actionOnSchedulePoint(
      BuildContext context, String remarks, String? uplodedImage, double? lat, double? long, String todayDate, String iTaskCode) async {
    // sharedP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('sToken');
    var  iUserTypeCode = prefs.getString('iUserTypeCode');
    var userId = prefs.getString('iUserId');

    print('--20--iUserTypeCode--$iUserTypeCode');
    print('--21--longitude--$userId');

    try {
      print('----remarks---24--$remarks');
      print('----token-----$token');
      print('----imageFile---$uplodedImage');
      print('----lat---$lat');
      print('----long---$long');
      print('----todayDate---$todayDate');
      print('-----iTaskCode---30--$iTaskCode');

      var baseURL = BaseRepo().baseurl;

      /// TODO CHANGE HERE
      var endPoint = "ActionOnScheduledPoint/ActionOnScheduledPoint";
      var actionOnSchedulePointApi = "$baseURL$endPoint";
      print('------------39---actionOnSchedulePointApi---$actionOnSchedulePointApi');

      String jsonResponse =
          '{"sArray":[{"iTaskCode":"$iTaskCode","iResolveBy":"$userId","dResolveAt":"$todayDate","sAfterPhoto":"$uplodedImage","sResolveRemarks":"$remarks","fResolveLatitude":"$lat","fResolveLongitude":"$long"}]}';
// Parse the JSON response
      Map<String, dynamic> parsedResponse = jsonDecode(jsonResponse);

// Get the array value
      List<dynamic> sArray = parsedResponse['sArray'];

// Convert the array to a string representation
      String sArrayAsString = jsonEncode(sArray);

// Update the response object with the string representation of the array
      parsedResponse['sArray'] = sArrayAsString;

// Convert the updated response object back to JSON string
      String updatedJsonResponse = jsonEncode(parsedResponse);

// Print the updated JSON response (optional)
      print(updatedJsonResponse);
      print('---63-----$updatedJsonResponse');

//Your API call
      var headers = {'token': '$token', 'Content-Type': 'application/json'};

      var request = http.Request(
          'POST',
          Uri.parse('$actionOnSchedulePointApi'));
      request.body =
          updatedJsonResponse; // Assign the JSON string to the request body
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('-------89--$map');
      print('---90---${response.statusCode}');
      // var response;
      // var map;
      //print('----------20---LOGINaPI RESPONSE----$map');
      if (response.statusCode == 200) {
        hideLoader();
        print('----------96-----$map');
        return map;
      } else {
        print('----------99----$map');
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
