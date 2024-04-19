import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'base_api.dart';

class UserList {
  List dataList = [];
  static var endPoint = "api/vistlistpending/";
  Future<List?> getCompleApi() async {
    try {
      var baseApi = BaseApi.baseApi;
      var UserListApi2 = baseApi + endPoint;
      
 //  print('-----userList Api---23---$userListApi');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
       var userid = prefs.getString('userid');
        var visitListCompletedApi = "$UserListApi2$userid";
        print('USERlistComp--23--$visitListCompletedApi');
      print('token---------17--$token');
      print('userid---------17--$userid');
      var headers = {
         'Authorization': 'Bearer $token'
           };
// http://http://49.50.118.112:8080/sebi-api/api/vistlistcompleted/89
var request = http.Request('GET', Uri.parse(visitListCompletedApi));
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
    //   var userId = 118;
    //   var baseApi = BaseApi.baseApi;
    //   var UserListApi2 = baseApi + endPoint;
    //   var userListApi = "$UserListApi2$userId";
    //   print('-----userList Api---23---$userListApi');
    //  // var userListUrl = userListApi;
    //   //
    //   var headers = {'Authorization': '$token'};
    //   var request = http.Request('GET', Uri.parse(userListApi));
    //   request.headers.addAll(headers);
    //   http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var map = json.decode(data);
        print('-----map--33--$map');
        // Iterate the data
        // map.forEach((element) {
        //   dataList.add(element);
        // });
         map['data'].forEach((element) {
          debugPrint("element: $element");
          // store the data into the list after interation
          dataList.add(element);
        });
        return dataList;
      } else {
        var status = response.statusCode;
        debugPrint(response.reasonPhrase);
        return dataList;
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
