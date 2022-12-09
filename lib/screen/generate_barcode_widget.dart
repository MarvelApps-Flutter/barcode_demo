import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

generateBarcodeWidget(TextEditingController textEditingController,
    File? barcodeImageFile, Function onTapGenerateBtn) {
  return Center(
    child: Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        //Scroll view given to Column
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              barcodeImageFile != null &&
                      barcodeImageFile!.path.isNotEmpty &&
                      barcodeImageFile!.path != ""
                  ? SvgPicture.file(barcodeImageFile!)
                  : Container(),
              // qrInputData != ""
              //     ? QrImage(data: qrInputData)
              //     : Container(),
              SizedBox(height: 20),
              Text(
                "Generate Barcode",
                style: TextStyle(fontSize: 20),
              ),

              //TextField for input link
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: "Enter the data here..."),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                //Button for generating barcode code
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await onTapGenerateBtn();
                    },
                    //Title given on Button
                    child: Text(
                      "Generate Barcode",
                      style: TextStyle(
                        color: Colors.indigo[900],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    ),
  );
}
