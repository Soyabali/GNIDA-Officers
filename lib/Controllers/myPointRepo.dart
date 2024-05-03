
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Helpers/loader_helper.dart';
import 'package:http/http.dart' as http;
import '../screens/generalFunction.dart';
import 'baseurl.dart';

class MyPointTypeRepo {
  GeneralFunction generalFunction = GeneralFunction();
  Future<List<Map<String, dynamic>>?> mypointType(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');

    print('-----16---$sToken');

    try {
      var baseURL = BaseRepo().baseurl;
      var endPoint = "MyWallet/MyWallet";
      var myPointApi = "$baseURL$endPoint";
      showLoader();

      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };

      var request = http.Request('POST', Uri.parse('$myPointApi'));
      request.body = json.encode({
        "iUserId": '$iUserId'
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if(response.statusCode ==401){
        generalFunction.logout(context);
        hideLoader();
      }
      if (response.statusCode == 200) {
        hideLoader();
        var data = await response.stream.bytesToString();
        Map<String, dynamic> parsedJson = jsonDecode(data);
        List<dynamic>? dataList = parsedJson['Data'];

        if (dataList != null) {
          List<Map<String, dynamic>> myPointList = dataList.cast<Map<String, dynamic>>();
          print("xxxxxxxxxxxxxxxxxxx----: $myPointList");
          return myPointList;
        } else {
          hideLoader();
          return null;
        }
      } else{
        hideLoader();
        return null;
      }
    } catch (e) {
      hideLoader();
      debugPrint("Exception: $e");
      throw e;
    }
  }
}
