// import 'dart:convert';

import 'package:flutter/material.dart';
import '../Controllers/userlist_controlller.dart';
// import '../Helpers/loader_helper.dart';
import '../Helpers/loader_helper.dart';

class UserListProvider extends ChangeNotifier {

List? userDataListProvider;
 
Future callUserListController() async {
    showLoader();
    userDataListProvider = await UserListController().getUserApiData();
   if (userDataListProvider != null) {
      hideLoader();
    }
    notifyListeners();
  }
}
