import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import '../screens/generalFunction.dart';
import 'baseurl.dart';

class PostComplaintRepo {
  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future postComplaint(
      BuildContext context, int randomNumber, iPointTypeCode, iSectorCode, String location, double? lat, double? long, String description, String imageFile, String todayDate, String? iUserId,) async {
    // sharedP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('sToken');

    try {
      showLoader();
      print('----randomNumber---$randomNumber');
      print('----iPointTypeCode---$iPointTypeCode');
      print('----iSectorCode---$iSectorCode');
      print('----location---$location');
      print('----lat---$lat');
      print('----long---$long');
      print('----description---$description');
      print('----imageFile---$imageFile');
      print('----todayDate---$todayDate');
      print('----iUserId---$iUserId');

      var baseURL = BaseRepo().baseurl;

      /// TODO CHANGE HERE
      var endPoint = "PostComplaint/PostComplaint";
      var postComplaintApi = "$baseURL$endPoint";
      print('------------48-----postComplaintApi---$postComplaintApi');

      String jsonResponse =
          '{"sArray":[{"iCompCode":$randomNumber,"iPointTypeCode":$iPointTypeCode,"iSectorCode":$iSectorCode,"sLocation":"$location","fLatitude":$lat,"fLongitude":$long,"sDescription":"$description","sBeforePhoto":"$imageFile","dPostedOn":"$todayDate","iPostedBy":$iUserId}]}';
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

      var request = http.Request('POST',Uri.parse('$postComplaintApi'));
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
      } else if(response.statusCode==401)
      {
        generalFunction.logout(context);
      }else {
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
