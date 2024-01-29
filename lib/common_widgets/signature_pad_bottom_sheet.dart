import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/viewmodel/common/singature_pad_bottom_sheet_viewmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignaturePadBottomSheet extends StatelessWidget {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  late SignaturePadBottomSheetViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignaturePadBottomSheetViewModel>.reactive(
        viewModelBuilder: () => SignaturePadBottomSheetViewModel(),
        builder: (context, viewmodel, child) {
          _viewModel = viewmodel;
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SfSignaturePad(
                    key: _signaturePadKey,
                    minimumStrokeWidth: 1,
                    maximumStrokeWidth: 3,
                    strokeColor: Colors.blue,
                    backgroundColor: Colors.white,
                  ),
                ),
                viewmodel.state == ViewState.Loading
                    ? CircularProgressIndicator()
                    : ButtonContainer(
                        buttonText: "Save",
                        onPressed: () async {
                          ui.Image image =
                              await _signaturePadKey.currentState!.toImage();
                          final bytes = await image.toByteData(
                              format: ui.ImageByteFormat.png);

                          _viewModel
                              .addDoctorSignatureImage(
                                  await writeToFile(bytes!))
                              .then((value) {
                            Navigator.pop(context, value);
                          });
                        },
                      )
              ],
            ),
          );
        });
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.png'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
