import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/bank_details/post_bank_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/bank_details/bank_details_service.dart';

class BankDetailsServiceImp extends BankDetailsService {
  late Dio dio;
  BankDetailsServiceImp(this.dio);
  @override
  Future<GenericResponse> getBankDetailsInfo(int id) async {
    GenericResponse response = GenericResponse();
    String url = "HCP/GetHcptBankDetails/$id";
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

  @override
  Future<GenericResponse> postBankDetailsInfo(
      PostBankDetailsRequest model) async {
    var response = new GenericResponse(
        message: "", result: dynamic, hasError: false, statusCode: 200);
    var url = "HCP/HcpPostBankDetails";

    try {
      var httpResponse = await dio.post(url, data: model.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      } else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;
  }

  @override
  Future<GenericResponse> updateBankDetails(
      PostBankDetailsRequest request) async {
    var response = new GenericResponse();
    var url = "HCP/UpdateHcpBankDetails/${SessionManager.getUser.id}";

    try {
      var httpResponse = await dio.put(url, data: request.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      } else
        response.message = somethingWentWrong;
      response.hasError = true;
    }
    return response;
  }
}
