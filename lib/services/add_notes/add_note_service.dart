import 'package:lifeeazy_medical/models/add_notes/post_note_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

abstract class AddNoteService {

  Future<GenericResponse> getNoteInfo(int id);
  Future<GenericResponse> postNoteInfo(PostNoteRequest model);
}