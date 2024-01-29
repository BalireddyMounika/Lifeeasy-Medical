import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  // Strings constants
  static const String AppLanguagesKey = 'language';
  static const String UserModel = "userModel";
  static const String IsLoggedInKey = "isLoggedInKey";
  static const String Location = "location";
  static const String ProfileImage = "profileImage";
  static const String Sign = "sign";

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance!;
  }

  String? get signature => _getFromDisk(Sign);
  void setSignature(String value) => _saveToDisk(Sign, value);

  String get getProfileImage => _getFromDisk(ProfileImage) ?? "";

  void setProfileImage(String value) => _saveToDisk(ProfileImage, value);

  String get userModel => _getFromDisk(UserModel) ?? null;

  void setUserModel(String value) => _saveToDisk(UserModel, value);


  String get getLocation => _getFromDisk(Location)??"";
  void setLocation(String value) => _saveToDisk(Location, value);



  bool get isLoggedIn => _getFromDisk(IsLoggedInKey) ?? false;

  void setIsLogIn(bool value) => _saveToDisk(IsLoggedInKey, value,);

// updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }
}
