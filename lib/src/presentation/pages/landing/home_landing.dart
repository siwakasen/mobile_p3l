import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/data/repositories/produkRepository.dart';
import 'package:mobile_p3l/src/data/repositories/hampersRepository.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mobile_p3l/src/data/models/produkEntity.dart';
import 'package:mobile_p3l/src/data/models/hampersEntity.dart';
import 'package:mobile_p3l/src/presentation/pages/landing/widget/bannerCard.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeLanding extends StatefulWidget {
  const HomeLanding({super.key});

  @override
  State<HomeLanding> createState() => _HomeLandingState();
}

class _HomeLandingState extends State<HomeLanding> {
  List<Produk>? produks;
  List<Hampers>? hampers;
  List<dynamic>? data = [];

  void refresh() async {
    List<Produk>? dataProduks = await ProdukRepository().getProduk();
    List<Hampers>? dataHampers = await HampersRepository().getHampers();
    setState(() {
      hampers = dataHampers;
      produks = dataProduks;

      if (produks != null) {
        data?.addAll(produks!);
      }
      if (hampers != null) {
        data?.addAll(hampers!);
      }
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  List bannerImages = [
    'banner1.jpeg',
    'banner2.jpeg',
    'banner3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Atma Kitchen",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.info,
                    color: indigo[600],
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/informasi-toko", (route) => false);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: indigo[600],
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/auth/login", (route) => false);
                  },
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: data == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CarouselSlider(
                    items: bannerImages.map(
                      (e) {
                        return BannerCard(
                          index: e,
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      height: 20.h,
                      autoPlay: true,
                      viewportFraction: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: GridView.builder(
                      itemCount: data?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setPreference(
                                "detail_item",
                                data![index] is Produk
                                    ? data![index].namaProduk
                                    : data![index].namaHampers);

                            data![index] is Produk
                                ? Navigator.of(context)
                                    .pushNamed("/detail/produk")
                                : Navigator.of(context)
                                    .pushNamed("/detail/hampers");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.08),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Image.network(
                                          '$API_URL_IMAGE${data![index] is Produk ? data![index].fotoProduk : data![index].fotoHampers}',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                      data![index] is Produk
                                          ? data![index].idKategori != 4
                                              ? Positioned(
                                                  right: 5,
                                                  top: 5,
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration: BoxDecoration(
                                                        color: indigo[100]!
                                                            .withOpacity(0.9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                      child: Text(
                                                        data![index]
                                                                    .limitProdukHariIni
                                                                    ?.limit ==
                                                                null
                                                            ? "Kouta : 0"
                                                            : "Kouta : ${data![index].limitProdukHariIni?.limit}",
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: "Poppins",
                                                        ),
                                                      )),
                                                )
                                              : Container()
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data![index] is Produk
                                            ? data![index].namaProduk!
                                            : data![index].namaHampers,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      Text(
                                        data![index] is Produk
                                            ? data![index]
                                                .hargaProduk
                                                .toString()
                                            : data![index]
                                                .hargaHampers
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w300),
                                      ),
                                      data![index] is Produk
                                          ? Text(
                                              data![index].idKategori != 4
                                                  ? "Stok: ${data![index].stokProduk.toString()}"
                                                  : "Ready Stok",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Poppins",
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
