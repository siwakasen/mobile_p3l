import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:mobile_p3l/src/data/models/laporanPenggunaanBBModel.dart';

Future<void> generateLaporan(List<LaporanPenggunaanBB> data, String periode, BuildContext context) async {
  final doc = pw.Document();
  const pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      footer: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Atma Kitchen',
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  'Jl. Centralpark No. 10 Yogyakarta',
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      build: (pw.Context context) {
        return [
          pw.Header(
            level: 0,
            child: pw.Text(
              'LAPORAN PENGGUNAAN BAHAN BAKU',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text('Periode : $periode'),
          pw.Text('Tanggal cetak: ${DateFormat('dd MMMM yyyy').format(DateTime.now())}'),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ['Nama Bahan', 'Satuan', 'Digunakan'],
            data: data.map((item) => [item.nama_bahan_baku, item.satuan, item.jumlah.toString()]).toList(),
            cellStyle: pw.TextStyle(fontSize: 12),
            headerStyle: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            border: pw.TableBorder.all(),
            cellAlignment: pw.Alignment.center,
          ),
        ];
      },
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PreviewScreen(doc: doc),
    ),
  );
}

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  PreviewScreen({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview')),
      body: PdfPreview(
        build: (format) => doc.save(),
      ),
    );
  }
}
