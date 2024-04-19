
import 'package:flutter/cupertino.dart';
import 'package:sebi/Controllers/profile_repo.dart';
import '../Controllers/pendinglist_repo.dart';
import '../Controllers/userlist_repo.dart';

class ProfileProvider with ChangeNotifier {

  bool isLoaded = false;
  List? profiledata;
  bool isTapped = false;
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
    profiledata = await ProfileRepo().getCompleApi();
    if (profiledata != null) {
      setIsLoaded(true);
    }
    notifyListeners();
  }
}