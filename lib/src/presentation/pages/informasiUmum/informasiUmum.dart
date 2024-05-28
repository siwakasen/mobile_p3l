import 'package:flutter/material.dart';

class InformasiUmumPage extends StatefulWidget {
  const InformasiUmumPage({Key? key}) : super(key: key);

  @override
  State<InformasiUmumPage> createState() => _InformasiUmumPageState();
}

class _InformasiUmumPageState extends State<InformasiUmumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white70,
                Colors.white70,
                Colors.white70,
                Color.fromARGB(255, 252, 210, 195)
              ],
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  Column(
                    children: <Widget>[
                      const Text(
                        "ATMA KITCHEN",
                        style: TextStyle(
                          fontSize: 28,
                          color: Color(0xFFFF7643),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Text(
                        "Kami menawarkan berbagai macam kue \ndan hampers dengan rasa yang unik",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                        ),
                      ),
                      Image.asset(
                        "assets/images/splash_2.png",
                        height: 220,
                        width: 235,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Atma Kitchen',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' adalah tempat yang tepat bagi Anda yang mencari kue, hampers, makanan ringan, dan minuman berkualitas tinggi. Kami berdedikasi untuk menyediakan produk-produk lezat yang dibuat dengan bahan-bahan terbaik dan penuh cinta.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 235,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/lokasi.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Lokasi : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationThickness: 5,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Jl. Babarsari No.43, Janti, Caturtunggal, Kec. Depok, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Phone : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextSpan(
                                  text: '(027) 4487711',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'E-mail : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextSpan(
                                  text: 'atmakitchen@example.com',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF7643),
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10),
                        
                      ),
                    ),
                    ),
                    child: const Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
