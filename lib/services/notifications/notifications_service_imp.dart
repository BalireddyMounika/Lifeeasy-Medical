import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'notifications_service.dart';


 class NotificationServiceImp extends NotificationService {
   late Dio dio;
   NotificationServiceImp(this.dio);
   @override
   Future<GenericResponse> getNotificationInfo(int id) async {
     GenericResponse response = GenericResponse();
     String url = "Notifications/GetByHcpIdNotifications/$id/";
     try {
       var httpResponse = await dio.get((url));

       if (httpResponse.statusCode == 200) {
         return GenericResponse.fromMap(httpResponse.data);
       }
     } catch (error) {
       if (error is DioError) {
         return GenericResponse.fromMap(error.response?.data);
       } else {
         throw ("something went wrong");
       }
     }
     return response;
   }



 }

