
import 'dart:typed_data';

import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class SignatureViewModel extends CustomBaseViewModel {


   addSignature( Uint8List signature) async {
    if (signature.isNotEmpty) {
      final status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final name = 'signature.png';
    // var result =   await ImageGallerySaver.saveImage(signature, name: name);
    //   if(result['isSuccess']) {
    //     locator<SnackBarService>().showSnackBar(
    //       title: "Successful",
    //       snackbarType: SnackbarType.success,
    //     );
    //   }
      notifyListeners();
    }
  }





}


  


