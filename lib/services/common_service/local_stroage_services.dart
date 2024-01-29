import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  // Strings constants
  static const String Sign = "sign";
  static const String CustomFooter = "customFooter";
  static const String UserId = "userId";
  static const String OnboardingSeen = 'onboardingseen';
  static const String UserNumber = "userNumber";
  static const String SeenCoachMark = "seenCoachMark";
  static const String Vibration = "vibration";
  static const String PrinterType = "printerType";
  static const String PrinterSize = "printerSize";

  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  String? get signature => _getFromDisk(Sign);
  void setSignature(String value) => _saveToDisk(Sign, value);

  String? get customFooter => _getFromDisk(CustomFooter);
  void setCustomFooter(String value) => _saveToDisk(CustomFooter, value);

  bool get onBoardingSeen => _getFromDisk(OnboardingSeen) ?? false;
  void setOnboardingSeen(bool value) => _saveToDisk(OnboardingSeen, value);

  String? get userId => _getFromDisk(UserId);
  void setUserId(String? value) => _saveToDisk(UserId, value);

  String? get userNumber => _getFromDisk(UserNumber);
  void setUseNumber(String? value) => _saveToDisk(UserNumber, value);

  int get printerType => _getFromDisk(PrinterType) ?? 2;
  void setPrinterType(int? value) => _saveToDisk(PrinterType, value);

  String get printerSize => _getFromDisk(PrinterSize) ?? "58";
  void setPrinterSize(String? value) => _saveToDisk(PrinterSize, value);

  bool get seenCoachMark => _getFromDisk(SeenCoachMark) ?? false;
  void setSeenCoachMark(bool? value) => _saveToDisk(SeenCoachMark, value);

  bool get vibrate => _getFromDisk(Vibration) ?? true;
  void setVibration(bool? value) => _saveToDisk(Vibration, value);

  Future<void> clear() async {
    await _preferences!.clear();
  }

// updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content) {
    // print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

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
      _preferences!.setStringList(key, content.cast<String>());
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    // print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  Future<bool> removeFromDisk(String key) async {
    return _preferences!.remove(key);
  }
}
