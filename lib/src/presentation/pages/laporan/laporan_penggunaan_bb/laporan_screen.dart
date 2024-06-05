import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/presentation/pages/laporan/laporan_penggunaan_bb/print/pdf.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/presentation/pages/laporan/controllers/laporan_controller.dart';
import 'package:mobile_p3l/src/data/models/laporanPenggunaanBBModel.dart';
import 'package:intl/intl.dart';

class LaporanPenggunaanBBScreen extends StatefulWidget {
  const LaporanPenggunaanBBScreen({super.key});

  @override
  State<LaporanPenggunaanBBScreen> createState() => _LaporanPenggunaanBBScreenState();
}

class _LaporanPenggunaanBBScreenState extends State<LaporanPenggunaanBBScreen> {
  String? token;
  var date = DateTime.now();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  List<LaporanPenggunaanBB> laporanPenggunaanBB = [];

  loadToken() async {
    token = await loadPreference("token");
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Laporan Penggunaan\nBahan Baku",
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
                      'Dari Tanggal',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: fromController,
                      decoration: InputDecoration(
                        hintText: 'YYYY-MM-DD',
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
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            fromController.text = formattedDate;
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
                      'Sampai Tanggal',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: toController,
                      decoration: InputDecoration(
                        hintText: 'YYYY-MM-DD',
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
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            toController.text = formattedDate;
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
                      if (fromController.text.isEmpty || toController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tanggal tidak boleh kosong'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      LaporanController()
                          .getLaporanPenggunaanBB(token!, fromController.text, toController.text)
                          .then((value) {
                        setState(() {
                          laporanPenggunaanBB = value;
                        });
                      });
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
                (laporanPenggunaanBB.isNotEmpty)
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
                            var fromDate = DateFormat('dd MMMM yyyy')
                                .format(DateFormat('yyyy-MM-dd').parse(fromController.text));
                            var toDate = DateFormat('dd MMMM yyyy')
                                .format(DateFormat('yyyy-MM-dd').parse(toController.text));
                            generateLaporan(
                                laporanPenggunaanBB, "${fromDate.toString()} - ${toDate.toString()}", context);
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
                (laporanPenggunaanBB.isNotEmpty)
                    ? SizedBox(
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Nama Bahan Baku')),
                              DataColumn(label: Text('Satuan')),
                              DataColumn(label: Text('Jumlah')),
                            ],
                            rows: laporanPenggunaanBB.map((e) => DataRow(cells: [
                                  DataCell(Text(e.nama_bahan_baku)),
                                  DataCell(Text(e.satuan)),
                                  DataCell(Text(e.jumlah.toString())),
                                ])).toList(),
                          ),
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
