import 'package:get_it/get_it.dart';
import 'package:lifeeazy_medical/net/api_service_config.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/services/add_notes/add_note_service.dart';
import 'package:lifeeazy_medical/services/add_notes/add_note_service_imp.dart';
import 'package:lifeeazy_medical/services/appointments/appointment_service_imp.dart';
import 'package:lifeeazy_medical/services/appointments/appointment_services.dart';
import 'package:lifeeazy_medical/services/authentication/auth_servcices.dart';
import 'package:lifeeazy_medical/services/authentication/auth_service_imp.dart';
import 'package:lifeeazy_medical/services/bank_details/bank_details_service.dart';
import 'package:lifeeazy_medical/services/bank_details/bank_details_service_imp.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service_imp.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/services/notifications/notifications_service.dart';
import 'package:lifeeazy_medical/services/notifications/notifications_service_imp.dart';
import 'package:lifeeazy_medical/services/pharmacy/pharmacy_services.dart';
import 'package:lifeeazy_medical/services/portfolio/portfolio_services.dart';
import 'package:lifeeazy_medical/services/portfolio/portfolio_services_imp.dart';
import 'package:lifeeazy_medical/services/prescription/prescription_service.dart';
import 'package:lifeeazy_medical/services/prescription/prescription_service_imp.dart';
import 'package:lifeeazy_medical/services/profile/profile_service.dart';
import 'package:lifeeazy_medical/services/profile/profile_service_imp.dart';
import 'package:lifeeazy_medical/services/schedule/schedule_service.dart';
import 'package:lifeeazy_medical/services/video_call/video_call_service.dart';
import 'package:lifeeazy_medical/services/video_call/video_call_service_imp.dart';
import 'package:lifeeazy_medical/viewmodel/appointment/appointment_viewmodel.dart';

import '../services/pharmacy/pharmacy_services_imp.dart';

final locator = GetIt.instance;
var config = ApiServiceConfig();
Future<void> setupLocator() async {
  locator.registerSingleton<AuthService>(AuthServiceImp(config.dio));
  locator.registerSingleton<DialogService>(DialogService());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator
      .registerSingleton<AppointmentService>(AppointmentServiceImp(config.dio));
  locator.registerSingleton<ProfileServices>(ProfileServiceImp(config.dio));
  locator.registerSingleton<CommonApiService>(CommonApiServiceImp(config.dio));
  locator.registerSingleton<PrescriptionService>(
      PrescriptionServiceImp(config.dio));
  locator.registerSingleton<AddNoteService>(AddNoteServiceImp(config.dio));

  locator.registerSingleton<NotificationService>(
      NotificationServiceImp(config.dio));
  locator.registerSingleton<VideoCallService>(VideoCallServiceImp(config.dio));
  locator
      .registerSingleton<BankDetailsService>(BankDetailsServiceImp(config.dio));
  locator
      .registerSingleton<PortfolioServices>(PortfolioServicesImp(config.dio));
  locator.registerSingleton<PharmacyService>(PharmacyServiceImp(config.dio));
  locator.registerSingleton<ScheduleService>(ScheduleService(config.dio));

  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance!);
  locator.registerLazySingleton(() => SnackBarService());
}
