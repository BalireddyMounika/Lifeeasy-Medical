import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/models/portfolio/partner_type_request.dart';
import 'package:lifeeazy_medical/models/portfolio/professional_type_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/services/portfolio/portfolio_services.dart';

import '../../constants/strings.dart';

class PortfolioServicesImp extends  PortfolioServices
{

  Dio dio;
  PortfolioServicesImp(this.dio);


  // @override
  // Future<GenericResponse> postProfessionalType(ProfessionalTypeRequest request) async{
  //   var response = new GenericResponse();
  //   var url = "Pharmacy/Professionalpartner/";
  //
  //   try {
  //     var httpResponse = await dio.post(url, data: request.toJson());
  //
  //     if (httpResponse.statusCode == 200)
  //       return GenericResponse.fromMap(httpResponse.data);
  //
  //     response.message = httpResponse.statusMessage!;
  //     response.hasError = true;
  //   } catch (error) {
  //     if (error is DioError) {
  //       return GenericResponse.fromMap(error.response?.data);
  //     }
  //     else
  //       response.message = somethingWentWrong;
  //
  //     response.hasError = true;
  //   }
  //
  //   return response;
  //
  // }

  // @override
  // Future<GenericResponse> updateProfessionalType(ProfessionalTypeRequest request) async{
  //   var response = new GenericResponse();
  //   var url = "Pharmacy/Professionaltype/";
  //
  //   try {
  //     var httpResponse = await dio.put(url, data: request.toJson());
  //
  //     if (httpResponse.statusCode == 200)
  //       return GenericResponse.fromMap(httpResponse.data);
  //
  //     response.message = httpResponse.statusMessage!;
  //     response.hasError = true;
  //   } catch (error) {
  //     if (error is DioError) {
  //       return GenericResponse.fromMap(error.response?.data);
  //     }
  //     else
  //       response.message = somethingWentWrong;
  //
  //     response.hasError = true;
  //   }
  //
  //   return response;
  //
  // }

  @override
  Future<GenericResponse> postPartnerType(PartnerTypeRequest request) async
    {
    var response = new GenericResponse();
    var url = "Pharmacy/Professionalpartner/";

    try {
      var httpResponse = await dio.post(url, data: request.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;
  }

  @override
  Future<GenericResponse> getPartnerTypeByProfId(int id) async{
    var response = new GenericResponse();
    var url = "Pharmacy/GetPartnerType/$id";

    try {
      var httpResponse = await dio.get(url);

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;


  }

  @override
  Future<GenericResponse> getAllPartners() async{

    var response = new GenericResponse();
    var url = "Pharmacy/Getallpartnerslist/";

    try {
      var httpResponse = await dio.get(url);

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;

  }

  // @override
  // Future<GenericResponse> getProfessionalTypeByProfId(int id) async{
  //
  //   var response = new GenericResponse();
  //   var url = "Pharmacy/GetProfessionalType/$id";
  //
  //   try {
  //     var httpResponse = await dio.get(url);
  //
  //     if (httpResponse.statusCode == 200)
  //       return GenericResponse.fromMap(httpResponse.data);
  //
  //     response.message = httpResponse.statusMessage!;
  //     response.hasError = true;
  //   } catch (error) {
  //     if (error is DioError) {
  //       return GenericResponse.fromMap(error.response?.data);
  //     }
  //     else
  //       response.message = somethingWentWrong;
  //
  //     response.hasError = true;
  //   }
  //
  //   return response;
  //
  //
  // }

}