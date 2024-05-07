// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/data/models/presensiModel.dart';
import 'package:mobile_p3l/src/presentation/pages/home/screens/controllers/presensi_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MOHomeScreen extends StatefulWidget {
  const MOHomeScreen({super.key});

  @override
  State<MOHomeScreen> createState() => _MOHomeScreenState();
}

class _MOHomeScreenState extends State<MOHomeScreen> {
  String? token;
  TextEditingController dateInput = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController searchInput = TextEditingController();
  final PresensiController _presensiController = PresensiController();
  List<Presensi> listPresensi = [];

  Future<List<Presensi>> getPresensi() async {
    List<Presensi> data = await _presensiController.getPresensi(token!, dateInput.text);
    setState(() {
      listPresensi = data;
    });
    return data;
  }

  Future<void> generatePresensi() async {
    await _presensiController.generatePresensi(token!, dateInput.text);
    getPresensi();
  }

  Future<void> updatePresensi(int id, String status) async {
    await _presensiController.updatePresensi(token!, id, status);
    getPresensi();
  }

  loadPresensi() async {
    String? getToken = await loadPreference("token");
    setState(() {
      token = getToken;
    });
    getPresensi();
  }

  List<Presensi> searchPresensi(String query) {
    if(query.isEmpty) {
      getPresensi();
    }
    List<Presensi> result = listPresensi.where((element) => element.karyawan.nama_karyawan.toLowerCase().contains(query.toLowerCase())).toList();
    return result;
  }

  @override
  void initState() {
    loadPresensi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Presensi Karyawan",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600
          )
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.now()) == dateInput.text ?
                        'Hari Ini'
                        :
                        'Tanggal Presensi', 
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      const Spacer(),
                      Text(
                        convertDateFormat(dateInput.text),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text(
                        'Cari Tanggal Presensi',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      const Spacer(),
                      dateInput.text.isNotEmpty && dateInput.text != DateFormat('yyyy-MM-dd').format(DateTime.now()) ? 
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            dateInput.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
                          });
                          getPresensi();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            )
                          )
                        ),
                      )
                      :
                      const SizedBox()
                    ],
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    key: const Key('date'),
                    controller: dateInput,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now()
                      );
                      
                      if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                          setState(() {
                            dateInput.text = formattedDate;
                            searchInput.clear();
                          });
                          getPresensi();
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500
                    ),
                    decoration: InputDecoration(
                      hintText: 'Pilih Tanggal',
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Cari Nama Karyawan',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    key: const Key('search'),
                    controller: searchInput,
                    onChanged: (value) {
                      setState(() {
                        listPresensi = searchPresensi(value);
                      });
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama Karyawan',
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            listPresensi.isEmpty ?
            GestureDetector(
              onTap: () {
                generatePresensi();
              },
              
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: indigo[400],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.now()) == dateInput.text ?
                  'Generate Presensi Hari Ini'
                  :
                  'Generate Presensi ' + convertDateFormat(dateInput.text),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                  )
                )
              ),
            )
            :
            const SizedBox(),
            listPresensi.isEmpty ?
            SizedBox(
              height: 50.h,
              child: Center(
                child: Text(
                  'Tidak ada data presensi',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            )
            :
            Expanded(
              child: ListView.separated(
                itemCount: listPresensi.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  return Card(
                    surfaceTintColor: Colors.white,
                    shadowColor: Colors.grey[200],
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        listPresensi[index].karyawan.nama_karyawan,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      subtitle: Text(
                        listPresensi[index].status,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      trailing: DropdownButton(
                        icon: const Icon(Icons.more_vert),
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'Masuk',
                            child: Text('Masuk'),
                          ),
                          DropdownMenuItem(
                            value: 'Tidak Masuk',
                            child: Text('Tidak Masuk'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            updatePresensi(listPresensi[index].id_presensi, value.toString());
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}