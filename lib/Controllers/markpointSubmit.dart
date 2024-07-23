import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import '../screens/generalFunction.dart';
import 'baseurl.dart';

class MarkPointSubmitRepo {
  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future markpointsubmit(
      BuildContext context,
      randomNumber,
      dropDownValueMarkLocation,
      dropDownValueDistric,
      String location,
      slat,
      slong,
      String description,
      String uplodedImage,
      String? todayDate,
      userId) async {
    // sharedP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('sToken');

    try {
      print('----markLocation---$dropDownValueMarkLocation');
      print('----sectorvalue---$dropDownValueDistric');
      print('----location---$location');
      print('----slat---$slat');
      print('----slong---$slong');
      print('----description---$description');
      print('----photopath---$uplodedImage');
      print('----todayDate---$todayDate');
      print('----userId---$userId');
      print('----token---$token');
      print('----randomNumber---$randomNumber');

      var baseURL = BaseRepo().baseurl;

      /// TODO CHANGE HERE
      var endPoint = "MarkLocation/MarkLocation";
      var markPointSubmitApi = "$baseURL$endPoint";
      print('------------39---markPointSubmitApi---$markPointSubmitApi');

      String jsonResponse =
          '{"sArray":[{"iCompCode":$randomNumber,"iPointTypeCode":$dropDownValueMarkLocation,"iSectorCode":$dropDownValueDistric,"sLocation":"$location","fLatitude":$slat,"fLongitude":$slong,"sDescription":"$description","sBeforePhoto":"$uplodedImage","dPostedOn":"$todayDate","iPostedBy":$userId}]}';
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
          Uri.parse(
              'https://upegov.in/noidaoneapi/Api/MarkLocation/MarkLocation'));
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
        print('------92----xxxxxxxxxxxxxxx----');
        hideLoader();
        print('----------96-----$map');
        return map;
      } else if(response.statusCode==401)
      {
        generalFunction.logout(context);
      }else{
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
