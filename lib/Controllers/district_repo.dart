// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tut_application/model/state_list_model.dart';
//
// class StateRepo {
//   final baseUrl = "http://49.50.79.121:8080/jci-api/api/allState";
//   // var headers = {'API-Token': 'token'};
//
//   //Fetch Country Data
//   // Future<CountryDataModel?>
//  Future<StateList?> getStateList() async {
//     var client = http.Client();
//     final url = baseUrl;
//
//     try {
//       var response = await client.get(Uri.parse(url));
//       var jsonStr = jsonDecode(response.body);
//
//       debugPrint(response.body);
//       if (response.statusCode == 200) {
//         var json = response.body;
//         Map<String, dynamic> mapData = jsonDecode(json);
//         print("State List: ${StateList.fromJson(mapData)}");
//         return StateList.fromJson(mapData);
//       }
//     } catch (e) {
//       print(e);
//       throw e;
//     }
//   }
// }
import 'dart:convert';
import 'package:dartz/dartz_unsafe.dart';
import 'package:http/http.dart' as http;
import 'package:tut_application/model/state_list_model.dart';

class DistRepo
{
  List distList = [];
  Future<List> getDistList(int sId) async
  {
    try
    {
      var request = http.Request(
        'GET', Uri.parse('http://49.50.79.121:8080/jci-api/api/district/$sId'),
      );
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200)
      {
        var data = await response.stream.bytesToString();
        print("Dist repo: ${data}");
        var map = json.decode(data);
        // var model = StateList.fromJson(map);
        // List state
        // Iterate the Dist data
        json.decode(data).forEach((element)
        {
          distList.add(element);
        });
        print("Dist list xxxxxxxxx 61----61------>:$distList");
        return distList;
      } else
      {
        return distList;
      }
    } catch (e)
    {
      throw (e);
    }
  }
}