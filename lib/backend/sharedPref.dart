import 'package:shared_preferences/shared_preferences.dart';

class SavedData {
  setLoggedIn(bool name) async {
    final savedUserName = await SharedPreferences.getInstance();
    await savedUserName.setBool('LoggedIn', name);
  }

  Future<bool> getLoggedIn() async {
    final savedUserName = await SharedPreferences.getInstance();
    final name = savedUserName.getBool('LoggedIn');
    if (name == null) {
      return false;
    } else
      return name;
  }
}
