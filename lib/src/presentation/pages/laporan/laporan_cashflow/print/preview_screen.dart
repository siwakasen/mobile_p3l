// ignore_for_file: file_names

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text("Invoice Preview")
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
      ),
    );
  }
}

