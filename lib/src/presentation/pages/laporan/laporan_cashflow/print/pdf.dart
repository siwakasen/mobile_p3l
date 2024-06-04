import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:mobile_p3l/src/data/models/laporanPenggunaanBBModel.dart';

Future<void> generateLaporan(Map<String,dynamic> data, String tahun, String bulan, BuildContext context) async {
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
              'LAPORAN PEMASUKAN DAN PENGELUARAN',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text('Bulan : $bulan'),
          pw.Text('Tahun : $tahun'),
          pw.Text('Tanggal cetak: ${DateFormat('dd MMMM yyyy').format(DateTime.now())}'),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ['', 'Pemasukan', 'Pengeluaran'],
            data: [
              ['Penjualan', data['pendapatan']['penjualan'].toString(), ''],
              ['Tip', data['pendapatan']['tip'].toString(), ''],
              ['Gaji Karyawan', '', data['pengeluaran']['gaji'].toString()],
              ['Bahan Baku', '', data['pengeluaran']['bahan_baku'].toString()],
              ['Pembayaran Penitip','', data['pengeluaran']['penitip'].toString()],
              for(var i in data['pengeluaran_lain'])
                [i['nama_pengeluaran'], '', i['nominal_pengeluaran'].toString()],
              ['Total', '', data['total'].toString()],
            ],
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
