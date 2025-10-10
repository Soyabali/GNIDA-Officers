import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/generalFunction.dart';
import 'base_api.dart';

class PendingList {
  List dataList = [];
  GeneralFunction generalFunction = GeneralFunction();
  static var endPoint = "api/vistlistpending/";

  Future<List?> getCompleApi() async {
    try {
      var baseApi = BaseApi.baseApi;
      var UserListApi2 = baseApi + endPoint;
      
    //  print('-----userList Api---23---$userListApi');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
       var userid = prefs.getString('userid');
          var visitListPendingApi = "$UserListApi2$userid";
          print('------24--$visitListPendingApi');

  
      var headers = {
  'Authorization': 'Bearer $token'
};  //   http://49.50.118.112:8080/sebi-api/api/vistlistpending/89
var request = http.Request('GET', Uri.parse(visitListPendingApi));
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
   
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var map = json.decode(data);
        
          map['data'].forEach((element) {
          debugPrint("element: $element");
          // store the data into the list after interation
          dataList.add(element);
        });
        return dataList;
      } else if(response.statusCode==401) {
       // generalFunction.logout(context);
      }else{
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
