import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noidaone/screens/generalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/loader_helper.dart';
import 'baseurl.dart';

class ShopSubmitRepo {

  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future shopSummit(BuildContext context, String shopName,
      String ownerName, selectedShopId, String contactNo,
      selectedSectorId, String address, String landMark, uplodedImage, double? lat,
      double? long, userId, selectedShopSizeId, String? selectedOption, locationAddress) async {
    //selectedShopSizeId, String? selectedOption

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');
      print('-----22---$sToken');

      try {

        var baseURL = BaseRepo().baseurl;
        var endPoint = "PostShopSurvey/PostShopSurvey";
        var shopSurveyApi = "$baseURL$endPoint";
        print('------------17---shopSurveyApi---$shopSurveyApi');

        showLoader();
        var headers = {
          'token': '$sToken',
          'Content-Type': 'application/json'
        };
        var request = http.Request('POST', Uri.parse('$shopSurveyApi'));
        request.body = json.encode({
          "sShopName": shopName,
          "sShopOwnerName": ownerName,
          "sShopType": selectedShopId,
          "sContactNo": contactNo,
          "iSectorCode": selectedSectorId,
          "sAddress": address,
          "sLandmark": landMark,
          "sPhoto": uplodedImage,
          "fLatitude": lat,
          "fLongitude": long,
          "sGoogleLocation":locationAddress,
          "iSurveyBy": userId,
          "iSizeTypeId":selectedShopSizeId,
          "sPaymentReceived":selectedOption
        });
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        var map;
        var data = await response.stream.bytesToString();
        map = json.decode(data);

      if (response.statusCode == 200) {
        // create an instance of auth class
        print('----44-${response.statusCode}');
        hideLoader();
        print('----------22-----$map');
        return map;
      } else {
        print('----------29---LOGINaPI RESPONSE----$map');
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
