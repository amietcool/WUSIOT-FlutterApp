import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  // Key used to store the login state.
  static const String _loginKey = "LOGIN";

  // Private constructor for singleton implementation.
  PreferenceManager._privateConstructor();

  // Singleton instance.
  static final PreferenceManager _instance =
  PreferenceManager._privateConstructor();

  // Getter to access the singleton instance.
  static PreferenceManager get instance => _instance;

  SharedPreferences? _prefs;

  /// Initialize SharedPreferences instance.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save the login state.
  Future<void> setLogin(bool login) async {
    if (_prefs == null) {
      // Ensure that init() has been called before using setLogin.
      await init();
    }
    await _prefs!.setBool(_loginKey, login);
  }

  /// Retrieve the login state.
  bool getLogin() {
    if (_prefs == null) {
      // If SharedPreferences is not yet initialized, return a default value.
      return false;
    }
    return _prefs!.getBool(_loginKey) ?? false;
  }
}
