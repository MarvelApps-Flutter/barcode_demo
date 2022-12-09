import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'dart:math' as mat;

import 'generate_barcode_widget.dart';
import 'scan_barcode_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? barcodeImageFile;
  String qrCodeResult = "Not Yet Scanned";
  TextEditingController textEditingController = TextEditingController();
  //GlobalKey _one = GlobalKey();
  int selectedScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: const Text("Barcode"),
      ),
      body: selectedScreenIndex == 0
          ? scanBarcodeWidget(textEditingController, GlobalKey(), () async {
              final codeSanner = (await FlutterBarcodeScanner.scanBarcode(
                  "black", "Cancel", true, ScanMode.DEFAULT));
              textEditingController.text = codeSanner.characters.toString();
              setState(() {});
            })
          : generateBarcodeWidget(textEditingController, barcodeImageFile,
              () async {
              final dm = Barcode.code128();
              Directory tempDir = await getTemporaryDirectory();

              String tempPath =
                  '${tempDir.path}/barcode${mat.Random().nextInt(99999)}.svg';
              final svg =
                  dm.toSvg(textEditingController.text, width: 200, height: 200);

              barcodeImageFile = await File(tempPath).writeAsString(svg);
              setState(() {});
            }),
      bottomNavigationBar: Container(
        color: Colors.indigo.shade400,
        child: Row(children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                selectedScreenIndex = 0;
                textEditingController = TextEditingController();

                setState(() {});
              },
              child: Text(
                "Scan Barcode",
                style: selectedScreenIndex == 0
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )
                    : const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                barcodeImageFile = File("");

                selectedScreenIndex = 1;
                textEditingController = TextEditingController();
                setState(() {});
              },
              child: Text(
                "Generate Barcode",
                style: selectedScreenIndex == 1
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )
                    : TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
