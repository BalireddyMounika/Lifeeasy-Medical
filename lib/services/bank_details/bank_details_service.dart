import 'package:lifeeazy_medical/models/bank_details/post_bank_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

abstract class BankDetailsService {
  Future<GenericResponse> getBankDetailsInfo(int id);

  Future<GenericResponse> postBankDetailsInfo(PostBankDetailsRequest model);
  Future<GenericResponse> updateBankDetails(PostBankDetailsRequest request);
}