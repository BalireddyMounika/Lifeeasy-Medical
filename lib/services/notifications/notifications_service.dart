
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

 abstract class NotificationService {
   Future<GenericResponse> getNotificationInfo(int id);
 }