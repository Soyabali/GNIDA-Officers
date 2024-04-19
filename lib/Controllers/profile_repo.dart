import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'base_api.dart';

class ProfileRepo {
  List profilelist = [];
  static var endPoint = "api/vistlistpending/";

  Future<List?> getCompleApi() async {
    try {
      var baseApi = BaseApi.baseApi;
      var UserListApi2 = baseApi + endPoint;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
       var userid = prefs.getString('userid');
        var visitListCompletedApi = "$UserListApi2$userid";
        print('USERlistComp--23--$visitListCompletedApi');
      print('token---------17--$token');
      print('userid---------17--$userid');
      // code

      var headers = {
  'Authorization': 'Bearer $token'
};
// http://49.50.118.112:8080/sebi-api/api/vistlistpending/89
var request = http.Request('GET', Uri.parse("http://49.50.118.112:8080/sebi-api/api/getUserProfile/89"));
request.headers.addAll(headers);
http.StreamedResponse response = await request.send();
  
 if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var map = json.decode(data);
        print('-----map--38--$map');
       
         map['data'].forEach((element) {
          debugPrint("element: $element");
          // store the data into the list after interation
          profilelist.add(element);
        });
        return profilelist;
      } else {
        var status = response.statusCode;
        debugPrint(response.reasonPhrase);
        return profilelist;
      }
    } on TimeoutException catch (e) {
      debugPrint('Timeout Error: $e');
    } on SocketException catch (e) {
      debugPrint('Socket Error: $e');
    } on Error catch (e) {
      debugPrint('General Error: $e');
    }
  }
}
