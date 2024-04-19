
import 'package:flutter/cupertino.dart';
import '../Controllers/pendinglist_repo.dart';
import '../Controllers/userlist_repo.dart';

class PendingListProvider with ChangeNotifier {

  bool isLoaded = false;
  List? pendingDataPro;
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
    pendingDataPro = await PendingList().getCompleApi();
    print('-------33---$pendingDataPro');
    if (pendingDataPro != null) {
      setIsLoaded(true);
    }
    notifyListeners();
  }
}