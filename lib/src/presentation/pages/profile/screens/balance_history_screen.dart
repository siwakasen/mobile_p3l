import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mobile_p3l/src/data/models/historiSaldoModel.dart';
import 'package:mobile_p3l/src/presentation/pages/profile/controllers/histori_saldo_controller.dart';
import 'package:intl/intl.dart';

class BalanceHistoryScreen extends StatefulWidget {
  const BalanceHistoryScreen({super.key});

  @override
  State<BalanceHistoryScreen> createState() => _BalanceHistoryScreenState();
}

class _BalanceHistoryScreenState extends State<BalanceHistoryScreen> {
  String? token;
  double? saldo = 0.0;
  String? formattedSaldo;
  List<HistoriSaldo> historySaldo = [];
  final HistoriSaldoController _historiSaldoController =
      HistoriSaldoController();
  final TextEditingController nominalSaldo = TextEditingController();

  loadHistorySaldo() async {
    String? getToken = await loadPreference("token");
    String? getSaldo = await loadPreference('saldo');
    setState(() {
      token = getToken;
      saldo = double.tryParse(getSaldo ?? '0') ?? 0.0;
      formattedSaldo =
          saldo != null ? NumberFormat("#,##0", "en_US").format(saldo!) : '0';
    });

    getHistoriSaldo();
  }

  Future<List<HistoriSaldo>> getHistoriSaldo() async {
    List<HistoriSaldo> data =
        await _historiSaldoController.getHistoriSaldo(token!);
    var newSaldo = await _historiSaldoController.getSaldo(token!);

    double parsedSaldo;
    if (newSaldo is int) {
      parsedSaldo = newSaldo.toDouble();
    } else if (newSaldo is double) {
      parsedSaldo = newSaldo;
    } else {
      throw Exception('Invalid type for saldo');
    }

    setState(() {
      saldo = parsedSaldo;
      formattedSaldo = NumberFormat("#,##0", "en_US").format(parsedSaldo);
      historySaldo = data;
    });

    return data;
  }

  @override
  void initState() {
    super.initState();
    loadHistorySaldo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Penarikan Saldo",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 22.5.w,
          leading: Row(
            children: [
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.all(2.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: indigo[200],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: indigo[500],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 0))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Saldo saat ini",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Rp. $formattedSaldo",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Masukkan Nominal Penarikan',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        TextField(
                                          keyboardType: TextInputType.number,
                                          controller: nominalSaldo,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: 'Nominal',
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (nominalSaldo.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Nominal tidak boleh kosong'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                              return;
                                            }
                                            if (int.parse(nominalSaldo.text) <
                                                10000) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Minimal penarikan Rp. 10.000'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                              return;
                                            }
                                            if (int.parse(nominalSaldo.text) >
                                                saldo!) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Saldo tidak mencukupi'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                              return;
                                            }
                                            var res =
                                                await _historiSaldoController
                                                    .addHistoriSaldo(
                                                        token!,
                                                        int.parse(
                                                            nominalSaldo.text));
                                            var response = json.decode(res.toString());
                                            Navigator.of(context).pop();
                                            if (response['status']) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Berhasil mengajukan penarikan saldo'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Gagal mengajukan penarikan saldo'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                            loadHistorySaldo();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.indigo[100],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            'Kirim',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                              color: Colors.indigo[500],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 28.h,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.indigo[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Ajukan Penarikan Saldo",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Colors.indigo[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  "Histori Penarikan Saldo",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 1.h),
                historySaldo.isEmpty
                    ? SizedBox(
                        height: 59.h,
                        child: Center(
                          child: Text(
                            "Tidak ada data",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                            itemCount: historySaldo.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: const Offset(0, 0))
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Status Penarikan",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            historySaldo[index]
                                                .keterangan_transaksi,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Nominal",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Rp. ${historySaldo[index].nominal_saldo}",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tanggal Pengajuan",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            historySaldo[index]
                                                .tanggal_pengajuan,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Tanggal Konfirmasi",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  historySaldo[index]
                                                      .tanggal_konfirmasi,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ));
                            }),
                      )
              ],
            )));
  }
}
