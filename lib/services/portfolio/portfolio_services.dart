

import 'package:lifeeazy_medical/models/portfolio/partner_type_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

import '../../models/portfolio/professional_type_request.dart';

abstract class PortfolioServices
{
  // Future<GenericResponse> postProfessionalType(ProfessionalTypeRequest request);
  // Future<GenericResponse> updateProfessionalType(ProfessionalTypeRequest request);
   Future<GenericResponse> postPartnerType(PartnerTypeRequest request);
   Future<GenericResponse> getPartnerTypeByProfId(int id);
   Future<GenericResponse> getAllPartners();
  // Future<GenericResponse> getProfessionalTypeByProfId(int id);









}
