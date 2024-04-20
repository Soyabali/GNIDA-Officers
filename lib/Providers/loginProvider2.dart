
import 'package:flutter/cupertino.dart';

import '../Controllers/loginrepo.dart';

class LoginProvider2 with ChangeNotifier {

  bool isLoaded = false;
  List? logindata;
  bool isTapped = false;

  LoginProvider2(String email, String password);
  
  // Getter and Setter

  ///isLoaded
  bool getIsLoaded() {
    return isLoaded;
  }

  void setIsLoaded(bool value) {
    isLoaded = value;
    notifyListeners();
  }
  ///isTapped
  bool getIsTapped() {
    return isTapped;
  }
  void setIsTapped(bool value) {
    isTapped = value;
    notifyListeners();
  }
  // Repo into the provider
  Future<void> loadRepoInProvider() async {
    logindata = await LoginRepo().loginApi();
    if (logindata != null) {
      setIsLoaded(true);
    }
    notifyListeners();
  }
}