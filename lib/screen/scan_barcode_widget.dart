import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:showcaseview/showcaseview.dart';

scanBarcodeWidget(TextEditingController textEditingController, GlobalKey _one,
    Function onTapScanBtn) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fetch Barcode Data",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Text(
              "Please scan your barcode",
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Expanded(child: Container()),
            Icon(
              Icons.qr_code_outlined,
              //  Icons.ballot_rounded,
              size: 50,
              color: Colors.indigo.shade400,
            )
          ],
        ),
        Expanded(child: Container()),
        Center(
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              suffixIcon: Showcase(
                key: _one,
                description: 'Click here to scan QR code',
                child: IconButton(
                  onPressed: () async {
                    await onTapScanBtn();
                  },
                  icon: Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.indigo.shade400,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    ),
  );
}
