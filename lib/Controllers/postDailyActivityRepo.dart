import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import '../screens/generalFunction.dart';
import 'baseurl.dart';

class PostDailyActiviyRepo {
  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future postDailyActivity(BuildContext context, int randomNumber, selectedStateId, String activityDetaile, File? imageFile, String? iUserId, double? lat, double? long,) async {
    // sharedP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('sToken');

    try {
      print('----randomNumber---$randomNumber');
      print('----selectedStateId---$selectedStateId');
      print('----activityDetaile---$activityDetaile');
      print('----imageFile---$imageFile');
      print('----iUserId---$iUserId');
      print('----lat---$lat');
      print('----long---$long');
      var baseURL = BaseRepo().baseurl;
      /// TODO CHANGE HERE
      var endPoint = "PostDailyActivity/PostDailyActivity";
      var postDailyActiviyApi = "$baseURL$endPoint";
      print('------------39---postDailyActiviyApi---$postDailyActiviyApi');

      String jsonResponse =
          '{"sArray":[{"iTranNo":$randomNumber,"iSectorCode":$selectedStateId,"sRemarks":"","sActivityPhoto":"$imageFile","iPostedBy":$iUserId,"fLatitude":$lat,"fLongitude":"$long"}]}';
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
          Uri.parse('$postDailyActiviyApi'));
      request.body = updatedJsonResponse; // Assign the JSON string to the request body
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('-------70--$map');
      print('---71---${response.statusCode}');
      // var response;
      // var map;
      //print('----------20---LOGINaPI RESPONSE----$map');
      if (response.statusCode == 200) {
        hideLoader();
        print('----------77-----$map');
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
