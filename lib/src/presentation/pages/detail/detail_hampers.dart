import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_p3l/src/data/models/hampersEntity.dart';
import 'package:mobile_p3l/src/data/models/produkEntity.dart';
import 'package:mobile_p3l/src/data/repositories/hampersRepository.dart';
import 'package:mobile_p3l/src/data/repositories/limitRepository.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailHampers extends StatefulWidget {
  const DetailHampers({super.key});

  @override
  State<DetailHampers> createState() => _DetailHampersState();
}

class _DetailHampersState extends State<DetailHampers> {
  Hampers? hampers;
  List<LimitProdukHariIni>? limit;

  TextEditingController tanggal = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var limitProduk;

  void refresh() async {
    String? item_name = await loadPreference('detail_item');
    List<Hampers>? dataHampers =
        await HampersRepository().searchHampers(item_name, tanggal.text);
    List<LimitProdukHariIni>? dataLimit =
        await LimitRepository().getLimit(dataHampers!.first.idProduk);

    setState(() {
      hampers = dataHampers.first;
      limit = dataLimit;
    });
  }

  @override
  void initState() {
    tanggal.text = DateTime.now().toString().split(' ')[0];
    refresh();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        tanggal.text = "${pickedDate.toLocal()}".split(' ')[0];
        limitProduk = limit!.firstWhere(
            (e) => DateFormat('yyyy-MM-dd').format(e.tanggal!) == tanggal.text,
            orElse: () => LimitProdukHariIni());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail",
          style: TextStyle(
              fontFamily: "Poppins", fontSize: 24, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/guest/landing", (route) => false);
          },
        ),
      ),
      body: hampers != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.h,
                      height: 25.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: '$API_URL_IMAGE${hampers!.fotoHampers}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            hampers!.namaHampers!,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        formatRupiah(hampers!.hargaHampers!),
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(hampers!.deskripsiHampers!,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: slate[600]!,
                          ),
                          textAlign: TextAlign.justify),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text('Limit : ${limitProduk?.limit ?? 0}',
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: tanggal,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: slate[400],
                                ),
                                hintText: "Pilih tanggal limit",
                                hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: slate[400],
                                ),
                                errorStyle: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: slate[300]!),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              readOnly: true,
                              onTap: () {
                                refresh();
                                _selectDate(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
