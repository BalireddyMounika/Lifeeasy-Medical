import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/view/appointments/appointment_detail_view.dart';
import 'package:lifeeazy_medical/view/appointments/appointment_reschedule_view.dart';
import 'package:lifeeazy_medical/view/appointments/get_appointment_view.dart';
import 'package:lifeeazy_medical/view/authentication/login/login_view.dart';
import 'package:lifeeazy_medical/view/authentication/registration/registration_success_view.dart';
import 'package:lifeeazy_medical/view/authentication/registration/registration_view.dart';
import 'package:lifeeazy_medical/view/authentication/reset_password/reset_password_view.dart';
import 'package:lifeeazy_medical/view/authentication/signin_with_otp/signin_otp_view.dart';
import 'package:lifeeazy_medical/view/bank_details/add_bank_detail_view.dart';
import 'package:lifeeazy_medical/view/common_web_view.dart';
import 'package:lifeeazy_medical/view/dashboard/dashboard_view.dart';
import 'package:lifeeazy_medical/view/intro_screens/intro_screens_view.dart';
import 'package:lifeeazy_medical/view/notes/add_Notelist_view.dart';
import 'package:lifeeazy_medical/view/notes/add_note_view.dart';
import 'package:lifeeazy_medical/view/notifications/notifications_alerts_view.dart';
import 'package:lifeeazy_medical/view/patient/patient_records_view.dart';
import 'package:lifeeazy_medical/view/pharmacy/add_pharmacy_medicine_view.dart';
import 'package:lifeeazy_medical/view/pharmacy/my_paharmacy_view.dart';
import 'package:lifeeazy_medical/view/pharmacy/pharmacy_dashboard_view.dart';
import 'package:lifeeazy_medical/view/pharmacy/phramacy_order_detail_view.dart';
import 'package:lifeeazy_medical/view/prescription/add_edit_prescription_view.dart';
import 'package:lifeeazy_medical/view/prescription/prescription_details_view.dart';
import 'package:lifeeazy_medical/view/prescription/prescription_list_view.dart';
import 'package:lifeeazy_medical/view/profile/add_profile_view.dart';
import 'package:lifeeazy_medical/view/profile/clinic_view.dart';
import 'package:lifeeazy_medical/view/profile/profile_view.dart';
import 'package:lifeeazy_medical/view/profile/scheduler_view.dart';
import 'package:lifeeazy_medical/view/profile/settings_view.dart';
import 'package:lifeeazy_medical/view/schedule/create_schedule_view.dart';
import 'package:lifeeazy_medical/view/schedule/schedule_view.dart';
import 'package:lifeeazy_medical/view/splash_screen_view.dart';
import 'package:lifeeazy_medical/view/video_call/video_call_view.dart';

import '../view/portfolio/select_partner_type_view.dart';
import '../view/prescription/prescription_view.dart';
import '../view/profile/personal_Information_view.dart';
import '../view/profile/widgets/educational_info_widget.dart';
import '../view/profile/widgets/professional_info_widget.dart';
import '../view/signature/add_signature_view.dart';

class Routes {
  static const String resetPasswordView = "/resetPasswordView";
  static const String registerView = "/registerView";
  static const String signInWithOtpView = "/signInWithOtpView";
  static const String loginView = "/loginView";
  static const String dashboardView = "/dashboardView";
  static const String getAppointmentView = "/getAppointmentView";
  static const String settingsView = "/settingView";
  static const String addProfileView = "/AddprofileView";
  static const String schedulerView = "/schedulerView";
  static const String professionalInfoView = "/professionalInfoView";
  static const String clinicView = "/clinicView";
  static const String profileView = "/profileView";
  static const String prescriptionView = "/PrescriptionView";
  static const String addSignatureView = "/AddSignatureView";
  static const String prescriptionViewFromAppointment =
      "/PrescriptionViewFromAppointment";

  static const String prescriptionDetailsView = "/PrescriptionDetailsView";
  static const String addEditPrescriptionView = "/AddEditPrescriptionView";
  static const String appointmentRescheduleView = "/AppointmentRescheduleView";
  static const String registrationSuccessView = "/registrationSuccessView";
  static const String addBankDetailView = "/AddBankDetailsView";
  static const String patientRecordsView = "/PatientRecordsView";
  static const String appointmentDetailView = "/AppointmentDetailView";
  static const String addNoteView = "/AddDetailView";

  static const String addNoteListView = "/addNoteListView";
  static const String notificationsAlertsView = "/NotificationAlertsView";

  static const String videocallView = "/videocallView";
  static const String scheduleVideoCallView = "/scheduleVideoCallView";

  static const String introScreensView = "/introScreensView";
  static const String clinicProfileView = "/clinicProfileView";
  static const String personalInformationView = "/personalInformationView";
  static const String educationalInfoView = "/educationalInfoView";

  //Pharmacy

  static const String selectBusinessTypeView = "/selectBusinessTypeView";
  static const String selectPartnerTypeView = "/selectPartnerTypeView";
  static const String pharmacyDashBoardView = "/pharmacyOrders";
  static const String myPharmacyView = "/myPharmacyView";
  static const String pharmacyOrderDetailView = "/pharmacyOrderDetailView";
  static const String addPharmacyMedicineView = "/addPharmacyMedicineView";
  static const String scheduleView = "/scheduleView";
  static const String createScheduleView = "create/scheduleView";

  static const String commonWebView = "/commonWebView";

  static Route<dynamic> generateRouter(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreenView());

      case loginView:
        return MaterialPageRoute(builder: (_) => LoginView());
      case personalInformationView:
        Map map = args as Map;
        var response = map['response'];
        return MaterialPageRoute(
            builder: (_) => PersonalInformationView(response));
      case signInWithOtpView:
        return MaterialPageRoute(builder: (_) => SignInWithOtpView());
      case resetPasswordView:
        return MaterialPageRoute(builder: (_) => ResetPasswordView());
      case registerView:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case dashboardView:
        return MaterialPageRoute(builder: (_) => DashBoardView());
      case registrationSuccessView:
        return MaterialPageRoute(builder: (_) => RegistrationSuccessView());
      case getAppointmentView:
        return MaterialPageRoute(builder: (_) => GetAppointmentsView());
      case notificationsAlertsView:
        return MaterialPageRoute(builder: (_) => NotificationAlertsView());
      case appointmentDetailView:
        Map maps = args as Map;
        var appointmentResponse = maps['appointmentResponse'];
        return MaterialPageRoute(
            builder: (_) => AppointmentDetailView(appointmentResponse));
      case settingsView:
        return MaterialPageRoute(builder: (_) => SettingsView());
      case addProfileView:
        return MaterialPageRoute(builder: (_) => AddProfileView());
      case schedulerView:
        return MaterialPageRoute(builder: (_) => SchedulerView());
      case professionalInfoView:
        return MaterialPageRoute(builder: (_) => ProfessionalInfoView());

      case commonWebView:
        Map map = args as Map;
        var url = map['url'];
        var title = map['title'];
        return MaterialPageRoute(builder: (_) => CommonWebView(url, title));

      case clinicView:
        return MaterialPageRoute(builder: (_) => ClinicView());
      case profileView:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case educationalInfoView:
        return MaterialPageRoute(builder: (_) => EducationalInfoView());
      case prescriptionView:
        Map maps = args as Map;
        var appointmentId = maps['appointmentId'];
        return MaterialPageRoute(
            builder: (_) => PrescriptionView(appointmentId));
      case prescriptionViewFromAppointment:
        Map maps = args as Map;
        var appointmentResponse = maps['prescriptionResponse'];
        var isFromAppointment = maps['isFromAppointment'];
        return MaterialPageRoute(
            builder: (_) => PrescriptionListView.fromAppointment(
                appointmentResponse, isFromAppointment));

      case prescriptionDetailsView:
        Map maps = args as Map;
        var appointmentResponse = maps['prescriptionResponse'];
        return MaterialPageRoute(
            builder: (_) => PrescriptionDetailsView(appointmentResponse));
      case addEditPrescriptionView:
        Map maps = args as Map;
        var appointmentResponse = maps['appointmentResponse'];
        return MaterialPageRoute(
            builder: (_) => AddEditPrescriptionView(appointmentResponse));
      case appointmentRescheduleView:
        return MaterialPageRoute(builder: (_) => AppointmentrescheduleView());
      case addSignatureView:
        return MaterialPageRoute(builder: (_) => AddSignatureView());

      case patientRecordsView:
        return MaterialPageRoute(builder: (_) => PatientRecordsView());

      case addNoteView:
        Map maps = args as Map;
        var appointmentResponse = maps['appointmentResponse'];

        return MaterialPageRoute(
            builder: (_) => AddNoteView(appointmentResponse));

      case addNoteListView:
        Map maps = args as Map;
        var appointmentResponse = maps['appointmentResponse'];
        return MaterialPageRoute(
            builder: (_) => AddNoteListView(appointmentResponse));

      case introScreensView:
        return MaterialPageRoute(builder: (_) => IntroScreensView());
      case videocallView:
        Map maps = args as Map;
        int userId = maps['userId'];
        int appointmentId = maps['appointmentId'];
        return MaterialPageRoute(
            builder: (_) => VideoCallView(
                  userId: userId,
                  appointmentId: appointmentId,
                ));
      // case scheduleVideoCallView:
      //   Map maps = args as Map;
      //   var appointmentId = maps['appointmentId'];
      //   return MaterialPageRoute(
      //       builder: (_) => ScheduleVideoCallView(
      //             appointmentResponse: appointmentId,
      //           ));
      case addBankDetailView:
        return MaterialPageRoute(builder: (_) => AddBankDetailsView());

      // case selectBusinessTypeView:
      //   return MaterialPageRoute(builder: (_) => SelectProfessionalTypeView());

      case selectPartnerTypeView:
        return MaterialPageRoute(builder: (_) => SelectPartnerTypeView());

      case pharmacyDashBoardView:
        return MaterialPageRoute(builder: (_) => PharmacyDashBoardView());

      case myPharmacyView:
        return MaterialPageRoute(builder: (_) => MyPharmacyView());

      case scheduleView:
        return MaterialPageRoute(builder: (_) => ScheduleView());

      case createScheduleView:
        return MaterialPageRoute(builder: (_) => CreateScheduleView());

      case pharmacyOrderDetailView:
        Map maps = args as Map;
        var pharmacyOrderResponse = maps['pharmacyOrderResponse'];
        return MaterialPageRoute(
            builder: (_) => PharmacyOrderDetailView(pharmacyOrderResponse));

      case addPharmacyMedicineView:
        Map maps = args as Map;
        var orderId = maps['id'];
        return MaterialPageRoute(
            builder: (_) => AddPharmacyMedicineView(orderId));
      default:
        return MaterialPageRoute(builder: (_) => SplashScreenView());
    }
  }
}
