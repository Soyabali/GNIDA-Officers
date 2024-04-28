
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class SectorRepo {

  // this is a loginApi call functin

  Future sector(BuildContext context) async {

    /// Here you should get a value from a sharedPreferenc that is stored at a login time.
    ///
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');

    print('-----22---$sToken');
    print('-----23---$iUserId');

    try {

      var baseURL = BaseRepo().baseurl;
      var endPoint = "BindSector/BindSector";
      var sectorApi = "$baseURL$endPoint";
      print('------------17---sectorApi---$sectorApi');

      showLoader();
      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$sectorApi'));
      request.body = json.encode({
        "iUserId": iUserId,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------50---sectorResponse Response----$map');
      if (response.statusCode == 200) {
        hideLoader();
        print('----------53-----$map');
        return map;
      } else {
        print('----------29---changePassword Response----$map');
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



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../Helpers/loader_helper.dart';
// import 'baseurl.dart';
//
//
// class LoginRepo1 {
//
//   // this is a loginApi call functin
//
//   Future authenticate(BuildContext context, String number, String pass) async {
//
//     try {
//       print('----Number---$number');
//       print('----PassWord---$pass');
//
//       var baseURL = BaseRepo().baseurl;
//       var endPoint = "AppLogin/AppLogin";
//       var loginApi = "$baseURL$endPoint";
//       print('------------17---loginAPI---$loginApi');
//
//       showLoader();
//       var headers = {'Content-Type': 'application/json'};
//       var request = http.Request(
//           'POST',
//           Uri.parse('$loginApi'));
//       request.body = json.encode({"sContactNo": number, "sPassword": pass,"sAppVersion":1});
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//       var map;
//       var data = await response.stream.bytesToString();
//       map = json.decode(data);
//       print('----------20---LOGINaPI RESPONSE----$map');
//       if (response.statusCode == 200) {
//         hideLoader();
//         print('----------22-----$map');
//         return map;
//       } else {
//         print('----------29---LOGINaPI RESPONSE----$map');
//         hideLoader();
//         print(response.reasonPhrase);
//         return map;
//       }
//     } catch (e) {
//       hideLoader();
//       debugPrint("exception: $e");
//       throw e;
//     }
//   }
// }


//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
//
// class BlockRepo
// {
//   List blockList = [];
//   Future<List> getBlockList(int sId) async
//   {
//     try
//     {
//       var request = http.Request(
//         'GET', Uri.parse('http://49.50.79.121:8080/jci-api/api/block/$sId'),
//       );
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200)
//       {
//         var data = await response.stream.bytesToString();
//         print("Block repo:xxxxxxxxxxx ${data}");
//         var map = json.decode(data);
//         // var model = StateList.fromJson(map);
//         // List state
//         // Iterate the Dist data
//         json.decode(data).forEach((element)
//         {
//           blockList.add(element);
//         });
//         // map.forEach((elements)=> print(elements) );
//         // print(" map: ${map}");
//         print("blockList:xxxxxxxxxx $blockList");
//         return blockList;
//       } else {
//         return blockList;
//         print(response.reasonPhrase);
//       }
//     } catch (e)
//     {
//       throw (e);
//     }
//   }
// }