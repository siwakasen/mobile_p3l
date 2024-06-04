import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_p3l/src/data/models/laporanStokBB.dart';
import 'package:mobile_p3l/src/presentation/pages/laporan/laporan_stok_bahan_baku/print/pdf.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/presentation/pages/laporan/controllers/laporan_controller.dart';

class LaporanStokBBScreen extends StatefulWidget {
  const LaporanStokBBScreen({super.key});

  @override
  State<LaporanStokBBScreen> createState() => _LaporanStokBBScreenState();
}

class _LaporanStokBBScreenState extends State<LaporanStokBBScreen> {
  String? token;
  List<LaporanBahanBaku> laporanStokBahanBaku = [];

  void refresh() async {
    token = await loadPreference("token");

    LaporanController().getLaporanBahanBaku(token!).then((value) {
      setState(() {
        laporanStokBahanBaku = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Laporan Stok Bahan\nBaku",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              decoration: BoxDecoration(
                color: indigo[200],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 18.sp,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(width: 2.w),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.sp, vertical: 20.sp),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    generateLaporanBahanBaku(laporanStokBahanBaku, context);
                  },
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: indigo[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Text(
                        'Cetak Laporan',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    (laporanStokBahanBaku.isNotEmpty)
                        ? SizedBox(
                            child: SingleChildScrollView(
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Nama Bahan Baku')),
                                  DataColumn(label: Text('Satuan')),
                                  DataColumn(label: Text('Jumlah')),
                                ],
                                rows: laporanStokBahanBaku
                                    .map((e) => DataRow(cells: [
                                          DataCell(Text(e.namaBahanBaku!)),
                                          DataCell(Text(e.satuan!)),
                                          DataCell(Text(e.stok.toString())),
                                        ]))
                                    .toList(),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
