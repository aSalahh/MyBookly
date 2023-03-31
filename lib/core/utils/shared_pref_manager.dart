

import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SharedPrefManager {

  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    print('Shared Inithalized');
  }

  int? getUserPreferredProductsView() {
    return _prefs.getInt(kPreferredProductsViewKey);
  }

  void updateUserPreferredProductsView(int index) async {
    _prefs.setInt(kPreferredProductsViewKey, index);
  }




}
