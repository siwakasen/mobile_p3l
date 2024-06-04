import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_p3l/src/presentation/pages/laporan/laporan_cashflow/print/pdf.dart';

import 'package:mobile_p3l/src/data/models/laporanCashflowModel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/data/repositories/laporanRepository.dart';

class LaporanCashflowScreen extends StatefulWidget {
  const LaporanCashflowScreen({super.key});

  @override
  State<LaporanCashflowScreen> createState() => _LaporanCashflowScreenState();
}

class _LaporanCashflowScreenState extends State<LaporanCashflowScreen> {
  String? token = '';
  Map<String, dynamic>  dataCashflow = {};
  TextEditingController bulan = TextEditingController();
  TextEditingController tahun = TextEditingController();
  loadToken() async {
    token = await loadPreference("token");
  }

  Future getDataLaporanCashflow() async {
    if (token != '') {
      final data = await LaporanRepository()
          .getLaporanCashflow(token ?? '', tahun.text, bulan.text);
      setState(() {
        dataCashflow = data;
      });
      print(dataCashflow);
      return data;
    }
  }

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Laporan Pemasukan\ndan Pengeluaran",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bulan',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: bulan,
                      decoration: InputDecoration(
                        hintText: 'MM',
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('MM').format(pickedDate);
                          setState(() {
                            bulan.text = formattedDate;
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tanggal tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tahun',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: tahun,
                      decoration: InputDecoration(
                        hintText: 'YYYY',
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy').format(pickedDate);
                          setState(() {
                            tahun.text = formattedDate;
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tanggal tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                 SizedBox(height: 2.h),
                Container(
                  width: 100.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: indigo[200],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: TextButton(
                    onPressed: () {
                      getDataLaporanCashflow();
                    },
                    child: Text(
                      'Tampilkan Laporan',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                (dataCashflow.isNotEmpty)
                    ? Container(
                        width: 100.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          color: indigo[200],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: TextButton(
                          onPressed: () {
                            generateLaporan(
                                dataCashflow, tahun.text,bulan.text, context);
                          },
                          child: Text(
                            'Cetak Laporan',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 2.h),
                (dataCashflow.isNotEmpty)
                    ? SizedBox(
                      child: SingleChildScrollView(
                          child:DataTable(
                            columns: const [
                              DataColumn(label: Text('')),
                              DataColumn(label: Text('Pendapatan')),
                              DataColumn(label: Text('Pengeluaran')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('Penjualan')),
                                DataCell(Text(dataCashflow['pendapatan']['penjualan'].toString())),
                                DataCell(Text('')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Tip')),
                                DataCell(Text(dataCashflow['pendapatan']['tip'].toString())),
                                DataCell(Text('')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Gaji Karyawan')),
                                DataCell(Text('')),
                                DataCell(Text(dataCashflow['pengeluaran']['gaji'].toString())),
                              ]),DataRow(cells: [
                                DataCell(Text('Bahan Baku')),
                                DataCell(Text('')),
                                DataCell(Text(dataCashflow['pengeluaran']['bahan_baku'].toString())),
                              ]),DataRow(cells: [
                                DataCell(Text('Pembayaran Penitip')),
                                DataCell(Text('')),
                                DataCell(Text(dataCashflow['pengeluaran']['penitip'].toString())),
                              ]),
                              for (var i in dataCashflow['pengeluaran_lain'])
                                DataRow(cells: [
                                  DataCell(Text(i['nama_pengeluaran'])),
                                  DataCell(Text('')),
                                  DataCell(Text(i['nominal_pengeluaran'].toString())),
                                ]),
                            ],
                          )
                        ),
                    )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
