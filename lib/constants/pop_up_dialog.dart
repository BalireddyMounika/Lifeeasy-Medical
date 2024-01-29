// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lifeeazy_medical/common_widgets/button_container.dart';
// import 'package:lifeeazy_medical/constants/styles.dart';
// import 'package:lifeeazy_medical/get_it/locator.dart';
// import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
// enum DialogType { ErrorDialog, WarningDialog, SuccessDialog }
// //ignore: must_be_immutable
// class PopUpDialog extends StatelessWidget {
//   DialogType dialogType = DialogType.ErrorDialog;
//
//   String? routes = "";
//   final String? buttonText;
//   final String? title;
//   final String? message;
//   final _navigationService = locator<NavigationService>();
//   bool isStackCleared =false;
//
//   PopUpDialog(
//       {
//         this.routes,
//         this.buttonText,
//         this.title,
//         this.message,
//         this.isStackCleared =false,
//         required this.dialogType});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Container(
//         // height: displayHeight(context) * 4,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             topIcon(),
//             SizedBox(
//               height: 30,
//             ),
//             Flexible(
//               child: Text(
//                 title ?? "",
//                 textAlign: TextAlign.center,
//                 style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               message ?? "",
//               style: bodyTextStyle,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             ButtonContainer(
//               buttonText: this.buttonText,
//               height: kToolbarHeight - 10,
//               onPressed: (){
//                 if(routes!.isEmpty)
//                   Navigator.pop(context);
//                 else if (this.isStackCleared ==true) {
//                   Navigator.pop(context);
//                   _navigationService.navigateToAndRemoveUntil(routes!);
//                 }
//                 else {
//                   Navigator.pop(context);
//                   _navigationService.navigateTo(routes!);
//                 }
//               },
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget headerContainer(Color colors, Widget icon) {
//     return Container(
//       height: 100,
//       width: 100,
//       decoration: BoxDecoration(
//         border: Border.all(color: colors),
//         shape: BoxShape.circle,
//       ),
//       child: Center(child: icon),
//     );
//   }
//
//   Widget topIcon() {
//     switch (dialogType) {
//       case DialogType.ErrorDialog:
//         return headerContainer(
//             Colors.red,
//             Icon(
//               Icons.clear,
//               size: 48,
//               color: Colors.red,
//             ));
//
//       case DialogType.WarningDialog:
//       // TODO: Handle this case.
//         return headerContainer(
//             Colors.orange,
//             Icon(
//               Icons.warning,
//               size: 48,
//               color: Colors.orange,
//             ));
//
//       case DialogType.SuccessDialog:
//       // TODO: Handle this case.
//         return headerContainer(
//             Colors.green,
//             Icon(
//               Icons.done,
//               size: 48,
//               color: Colors.green,
//             ));
//     }
//   }
// }
