import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:signature/signature.dart';
import 'package:stacked/stacked.dart';

import '../../get_it/locator.dart';
import '../../viewmodel/signature/add_signature_viewmodel.dart';
class AddSignatureView extends StatefulWidget {
  const AddSignatureView({Key? key}) : super(key: key);

  @override
  State<AddSignatureView> createState() => _AddSignatureViewState();
}

class _AddSignatureViewState extends State<AddSignatureView> {
  late SignatureViewModel _viewModel;
   SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  void initState() {
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([

      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller.addListener(() {});
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignatureViewModel>.reactive(
        viewModelBuilder:()=>SignatureViewModel(),
        builder: (context , viewModel , child){
         _viewModel = viewModel;
          return    Scaffold(

            backgroundColor: Colors.white,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FloatingActionButton.extended(
                  backgroundColor: baseColor,
                  label: Text('Confirm', style: TextStyle(color:Colors.white , fontWeight: FontWeight.bold)),
                  icon: const Icon(Icons.check, color: Colors.white),
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      Uint8List?  signature =  await _controller.toPngBytes();
                       await _viewModel.addSignature(signature!);
                    } else {
                      Navigator.pop(context, null);
                    }
                  },
                ),
                SizedBox(width: 10),
                FloatingActionButton.extended(
                  heroTag: 'clear',
                  backgroundColor: Colors.red.shade300,
                  label: Text('Clear', style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),
                  icon: const Icon(Icons.clear_sharp, color: Colors.white),
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                ),
                SizedBox(width: 10),
                FloatingActionButton.extended(
                  heroTag: 'cancel',
                  backgroundColor: Colors.red,
                  label: Text('Cancel', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  icon: const Icon(Icons.cancel_outlined, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            appBar: CommonAppBar(title: 'Add Signature',onBackPressed:()=>Navigator.pop(context),),
            body:Signature(controller: _controller,backgroundColor: Colors.white,) ,

          );
        }
    ) ;


  }
}
