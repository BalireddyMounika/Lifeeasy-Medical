import 'dart:io';

import 'package:flutter/services.dart';
import 'package:lifeeazy_medical/utils/date_formatting.dart';
import 'package:lifeeazy_medical/view/prescription/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../models/prescription/prescription_response.dart';

class PdfParagraphApi {
  static Future<File> generate(
      PrescriptionResponse response, String image) async {
    final pdf = Document();
    final logo =
        (await rootBundle.load('images/logo2.png')).buffer.asUint8List();
    final locationIcon =
        (await rootBundle.load('images/logo2.png')).buffer.asUint8List();
    // final image = (await rootBundle.load('images/sign.png')).buffer.asUint8List();
    final sign = await networkImage(image ??
        'https://api.byhanddelivery.com/images/blob/profiles/8f915b90-b61d-48b1-94a1-f33b559be754.png');
    String age = "NA";
    final dob = response.userId?.profile?.dob;
    if (dob != null) {
      final currentTime = DateTime.now().difference(dob!);
      String age = (currentTime.inDays / 365).floor().toString();
    }
    pdf.addPage(
      MultiPage(
          pageTheme: PageTheme(
            buildBackground: (context) => Center(
                child: Container(
              width: 350,
              decoration: BoxDecoration(
                // color:  PdfColor.fromHex('7c94b6'),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: MemoryImage(logo),
                ),
              ),
            )),
          ),
          header: (context) => Container(
              width: double.infinity,
              child: Column(children: [
                doctorDetailsHeader(response),
                SizedBox(height: 4),
                patientDetailsHeader(response, age),
                Divider(thickness: 0.5),
              ])),
          build: (context) => <Widget>[
                ListView.builder(
                  itemCount: response.medication!.length,
                  itemBuilder: (context, int index) => _medicineContainer(
                      response.medication![index], index + 1),
                ),
              ],
          footer: (context) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        'Next FollowUp Date : '
                        '${formatDate(response.nextFollowUpDate.toString().split(' ').first)}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(
                        width: 70,
                        child: Column(children: [
                          Image(sign),
                          Divider(thickness: 0.5),
                          Text('Signature'),
                        ]))
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  color: PdfColor.fromHex('32A887'),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    child: Text(
                      "We aim to provide accessible, available & affordable online healthcare services to anyoneanytime & anywhere log on to website  vivifyhealthcare.com",
                      maxLines: 3,
                      style: TextStyle(color: PdfColor.fromHex('ffffff')),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Page : ${context.pageNumber}',
                      textAlign: TextAlign.right),
                ])
              ],
            );
          }),
    );
    return PdfApi.saveDocument(name: 'Prescription.pdf', pdf: pdf);
  }

  static Widget doctorDetailsHeader(PrescriptionResponse response) => Container(
        decoration: BoxDecoration(
          color: PdfColor.fromHex('32A887'),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "DR. ${response.hcpId!.firstname} ${response.hcpId!.lastname}",
                      style: TextStyle(
                        color: PdfColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 7),
                    Text(
                      "${response.hcpId!.education!.degree}",
                      style: TextStyle(
                        fontSize: 12,
                        color: PdfColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${response.hcpId!.professional!.specialization}',
                      style: TextStyle(
                        fontSize: 12,
                        color: PdfColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${response.hcpId!.professional!.mciNumber}',
                      style: TextStyle(
                        fontSize: 12,
                        color: PdfColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      '${response.hcpId!.email}',
                      style: TextStyle(
                          fontSize: 12,
                          color: PdfColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${response.hcpId!.mobileNumber}',
                      style: TextStyle(
                          fontSize: 12,
                          color: PdfColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Clinic Name :${response.hcpId!.clinicdetails!.first.clinicName} ',
                      style: TextStyle(
                          fontSize: 12,
                          color: PdfColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Clinic Address : ${response.hcpId!.clinicdetails!.first.address}',
                      style: TextStyle(
                          fontSize: 12,
                          color: PdfColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  static Widget patientDetailsHeader(
          PrescriptionResponse response, String age) =>
      Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    response.familyMemberId == null
                        ? '${response.userId?.firstname ?? 'Name'} ${response.userId?.lastname ?? ''}'
                        : '${response.familyMemberId!.firstname} ${response.familyMemberId!.lastname}',
                    style: TextStyle(
                      fontSize: 15,
                      color: PdfColor.fromHex('686262'),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('${response.userId!.address?['Address'] ?? "NA"}',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                      maxLines: 2),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Gender:  ${response.familyMemberId == null ? response.userId?.profile?.gender ?? "NA" : response.familyMemberId?.gender ?? "NA"}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Age:${response.familyMemberId == null ? age : response.familyMemberId?.age ?? "NA"} ',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      );

  static Widget _medicineContainer(Medication response, int index) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '$index.  ${response.drugName}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${response.quantity} Tablets',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Note: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: PdfColor.fromHex('32A887')),
                  ),
                  Text(
                      '${response.dosages} ${response.frequency} ${response.instructions} ',
                      overflow: TextOverflow.span)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
