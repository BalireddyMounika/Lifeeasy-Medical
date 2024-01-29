import 'package:lifeeazy_medical/models/add_notes/post_note_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/models/vide_call/schedule_call_status.dart';
import 'package:lifeeazy_medical/models/vide_call/video_call_responce.dart';

abstract class VideoCallService {

  Future<GenericResponse> postVideoCall(VideoCallRequest request);
  Future<GenericResponse> postScheduleCallStatus(ScheduleCallStatus request);
  Future<GenericResponse> getScheduleCallStatusByAppointmentId(int id);
  Future<GenericResponse> agoraToken(String channelName);


}