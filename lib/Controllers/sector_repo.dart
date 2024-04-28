
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:noidaone/Controllers/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helpers/loader_helper.dart';

class SectorRepo {

  // this is a loginApi call functin

  Future sectorno1(BuildContext context) async {

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
      var bindsectorApi = "$baseURL$endPoint";
      print('------------17---bindsectorApi---$bindsectorApi');

      showLoader();
      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$bindsectorApi'));
      request.body = json.encode({
        "iUserId": iUserId,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------50---changePassword Response----$map');
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