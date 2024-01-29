
import 'package:lifeeazy_medical/models/authentication/location_response_model.dart';
import 'package:lifeeazy_medical/models/authentication/login_response_model.dart';

class SessionManager {
  // static late final SessionManager _instance;
  // static SessionManager getInstance() {
  //   return _instance = SessionManager._internal();
  // }

  // SessionManager._internal();
  static LoginResponseModel? _user;

  static LoginResponseModel get getUser => _user??new LoginResponseModel();

  static set setUser(value) => _user = value;


  static LocationResponseModel? _locationResponseModel;

  static  LocationResponseModel get getLocation => _locationResponseModel??LocationResponseModel();

  static set setLocation(value) => _locationResponseModel = value;


  static String? _fcmToken;

  static String? get fcmToken => _fcmToken??"";

  static set fcmToken(value) => _fcmToken = value;
  
  static String? _profileImageUrl;
  static String? get profileImageUrl => _profileImageUrl??"";
  static set profileImageUrl(value) => _profileImageUrl = value;



}
