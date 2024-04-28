import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class   MarkPointSubmitRepo2 {

   sendPostRequest(BuildContext context) async {

       SharedPreferences prefs = await SharedPreferences.getInstance();
       //var token = prefs.getString('sToken');
       String? token = prefs.getString('sToken');

       print('----34------$token');
    // API endpoint and token
    String apiUrl = 'https://upegov.in/noidaoneapi/Api/MarkLocation/MarkLocation';
  //  String token = 'B6500E62-A01E-43E4-97C1-7FC9749BDB34';

    // Request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
       // Add token to headers only if it's not null
       if (token != null) {
         headers['token'] = token;
       }

    // Request body
    Map<String, dynamic> requestBody = {

      'sArray': [
        {
          "iCompCode": 67876690056,
          "iPointTypeCode": 1,
          "iSectorCode": 1,
          "sLocation": "Kirtiman Tower",
          "fLatitude": 0,
          "fLongitude": 0,
          "sDescription": "Test",
          "sBeforePhoto": "NA",
          "dPostedOn": "30/Mar/2024 13:41",
          "iPostedBy": 1
        }
      ]
    };

    // Convert request body to JSON string
    String requestBodyJson = json.encode(requestBody);

    try {
      // Send POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBodyJson,
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Print response body

        print('Response: ${response.body}');
        print('Status code: ${response.statusCode}');
      } else {
        // Print error response
        print('Status code: ${response.statusCode}');
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
     // print('Status code: ${response.statusCode}');
      // Print error if request fails
      print('Error: $e');
    }
  }
}
