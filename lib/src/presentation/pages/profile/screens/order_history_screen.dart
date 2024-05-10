// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/data/models/pesananModel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mobile_p3l/src/presentation/pages/profile/controllers/order_history_controller.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String? token;
  final OrderHistoryController _orderHistoryController =
      OrderHistoryController();
  List<Pesanan> orderHistory = [];
  String? search;

  loadHistory() async {
    String? getToken = await loadPreference("token");
    setState(() {
      token = getToken;
    });
    getOrderHistory();
  }

  Future<List<Pesanan>> getOrderHistory() async {
    List<Pesanan> data = await _orderHistoryController.getOrderHistory(token!);
    setState(() {
      orderHistory = data;
    });
    return data;
  }

  Future<List<Pesanan>> searchOrderHistory(String query) async {
    if (query.isEmpty) {
      getOrderHistory();
      return orderHistory;
    }
    List<Pesanan> data = await getOrderHistory();
    List<Pesanan> result = data.where((element) {
      return element.detail_pesanan!.any((e) {
        return e.produk != null
            ? e.produk!.nama_produk.toLowerCase().contains(query.toLowerCase())
            : e.hampers!.nama_hampers
                .toLowerCase()
                .contains(query.toLowerCase());
      });
    }).toList();
    return result;
  }

  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Histori Pesanan",
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
              TextField(
                onChanged: (value) async {
                  setState(() {
                    search = value;
                  });
                  orderHistory = await searchOrderHistory(search!);
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Cari produk yang ingin dicari",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600),
                    prefixIcon:
                        const Icon(Icons.search_rounded, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              SizedBox(height: 2.h),
              orderHistory.isEmpty
                  ? Container(
                      height: 50.h,
                      child: Center(
                        child: Text(
                          "Tidak ada data",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.black),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemCount: orderHistory.length,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/purchase.png",
                                              width: 8.w,
                                              height: 8.w,
                                            ),
                                            SizedBox(width: 2.w),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Belanja",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  convertDateTimeFormat(
                                                      orderHistory[index]
                                                          .tanggal_pesanan!),
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Chip(
                                          label: Text(
                                            orderHistory[index]
                                                        .status_transaksi ==
                                                    "Pesanan Sudah Selesai"
                                                ? "Selesai"
                                                : "Belum Selesai",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 0.w),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                  color: Colors.transparent)),
                                          backgroundColor: orderHistory[index]
                                                      .status_transaksi ==
                                                  "Pesanan Sudah Selesai"
                                              ? indigo[500]
                                              : red[400],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                      color: Colors.grey, thickness: 0.3),
                                  Column(
                                      children: (orderHistory[index]
                                          .detail_pesanan!
                                          .map((e) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 10.w,
                                                height: 10.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            e.produk != null
                                                                ? API_URL +
                                                                    'storage/' +
                                                                    e.produk!
                                                                        .foto_produk
                                                                : API_URL +
                                                                    'storage/' +
                                                                    e.hampers!
                                                                        .foto_hampers
                                                            // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkjdQYqJp-qndaJRxEMg0LKKWiX67S83wBBcXFeb3CpQ&s"
                                                            ),
                                                        fit: BoxFit.cover)),
                                              ),
                                              SizedBox(width: 2.w),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.produk != null
                                                        ? e.produk!.nama_produk
                                                        : e.hampers!
                                                            .nama_hampers,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    "${e.jumlah} Produk",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }).toList())),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, bottom: 5),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total Bayar",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              formatRupiah(orderHistory[index]
                                                  .total_bayar!),
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 2.w),
                                          decoration: BoxDecoration(
                                            color: indigo[500],
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'Beli Lagi',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
            ],
          ),
        ));
  }
}
