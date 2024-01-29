import 'dart:io';

import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:pdfx/pdfx.dart';
// import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:share/share.dart';

import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../models/prescription/prescription_response.dart';
import '../../services/prescription/prescription_service.dart';
import '../../view/prescription/prescription_pdf_api.dart';
import '../transaction/base_view_model.dart';

class PrescriptionDetailViewModel extends CustomBaseViewModel {
  File? _pdfFile;
  PdfController? _pdfController;
  PdfController? get pdfController => _pdfController;
  File? get pdfFile => _pdfFile;
  var _commonService = locator<CommonApiService>();
  PrescriptionResponse response = PrescriptionResponse();
  PrescriptionDetailViewModel(this.response);
  int appointmentId = 0;
  String loadingMsg = "";
  List<PrescriptionResponse> _prescriptionList = [];

  List<PrescriptionResponse> get prescriptionList => _prescriptionList;
  var _prescriptionService = locator<PrescriptionService>();
  PrescriptionDetailViewModel.get(this.appointmentId);

  generatePdf() async {
    var response = await _commonService.getImageByName(
        prescriptionList.first.hcpId?.professional?.signature ?? "");
    var data = response.result as Map<String, dynamic>;
    var image = data["Image"];
    _pdfFile = await PdfParagraphApi.generate(prescriptionList.first, image);
    _pdfController = PdfController(
      document: PdfDocument.openFile(_pdfFile!.path),
    );
    setState(ViewState.Completed);
  }

  share() {
    Share.shareFiles([pdfFile!.path],
        mimeTypes: ['application/pdf'], subject: 'Prescription');
  }

  Future getPrescriptionInfoByAppointmentId() async {
    try {
      loadingMsg = "Fetching Prescription";
      setState(ViewState.Loading);

      var response = await _prescriptionService
          .getPrescriptionInfoByAppointmentId(appointmentId ?? 0);

      if (response.hasError == true) {
        setState(ViewState.Error);
      } else {
        var data = response.result as List;

        data.forEach((element) {
          _prescriptionList.add(PrescriptionResponse.fromMap(element));
        });

        if (prescriptionList.length >= 1) {
          generatePdf();
        } else
          setState(ViewState.Empty);
      }
    } catch (e) {
      setState(ViewState.Empty);
    }
  }
}
