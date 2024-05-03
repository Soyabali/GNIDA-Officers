
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Helpers/loader_helper.dart';
import 'package:http/http.dart' as http;
import '../screens/generalFunction.dart';
import 'baseurl.dart';

class UserContributionTodayRepo {
  GeneralFunction generalFunction = GeneralFunction();

  Future<List<Map<String, dynamic>>?> userContributionTodat(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');

    try {
      var baseURL = BaseRepo().baseurl;
      var endPoint = "UserContribution/UserContribution";
      var userContributionApi = "$baseURL$endPoint";

      showLoader();

      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$userContributionApi'));
      request.body = json.encode({
        "iUserId": '$iUserId',
        "sSearchType": "1",   // A means All
        "sFilters": "T"
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if(response.statusCode ==401){
        generalFunction.logout(context);
      }
      if (response.statusCode == 200) {
        hideLoader();
        var data = await response.stream.bytesToString();
        Map<String, dynamic> parsedJson = jsonDecode(data);
        List<dynamic>? dataList = parsedJson['Data'];

        if (dataList != null) {
          List<Map<String, dynamic>> usercontributionTodatList = dataList.cast<Map<String, dynamic>>();
          print("usercontributionList----: $usercontributionTodatList");
          return usercontributionTodatList;
        } else {
          return null;
        }
      } else {
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
