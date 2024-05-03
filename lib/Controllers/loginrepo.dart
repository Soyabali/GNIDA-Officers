import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'base_api.dart';

class LoginRepo {
  List dataList = [];
  static var endPoint = "api/vistlistpending/";

  Future<List?> loginApi() async {
  try {
      var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://49.50.118.112:8080/sebi-api/sebi-api-jwt/authenticate'));
request.body = json.encode({
  "email": "vishal@gmail.com",
  "password": "12345"
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

        var data = await response.stream.bytesToString();
        var map = json.decode(data);
        print('-----50--$map');

          map['data'].forEach((element) {
          debugPrint("element: $element");
          // store the data into the list after interation
          dataList.add(element);
        });
        return dataList;
      } else if(response.statusCode == 401) {

    }else{
        var status = response.statusCode;
        debugPrint(response.reasonPhrase);
        return dataList;
      }
    } on TimeoutException catch (e) {
      debugPrint('Timeout Error: $e');
    } on SocketException catch(e) {
      debugPrint('Socket Error: $e');
    } on Error catch (e) {
      debugPrint('General Error: $e');
    }
  }
  void logout(){
    print("----44--44----4-4--xxxxxxxx---");
  }
}
