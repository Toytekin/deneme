import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: must_be_immutable
class ProfileSayfasi extends StatefulWidget {
  DanisanModel druser;
  ProfileSayfasi(this.druser, {super.key});

  @override
  State<ProfileSayfasi> createState() => _ProfileSayfasiState();
}

class _ProfileSayfasiState extends State<ProfileSayfasi> {
  @override
  Widget build(BuildContext context) {
    //! DEĞİŞKENLER
    // ignore: unused_local_variable
    String resimurl = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    String? gelenResim;

    final ImagePicker picker = ImagePicker();

    // ignore: unused_element
    galeridenYukle() async {
      resmiUrlyeAl(Reference ref) async {
        setState(() {});
        gelenResim = (await ref.getDownloadURL()).toString();
      }

      // ignore: unused_local_variable
      XFile? alinanDosya = await picker.pickImage(source: ImageSource.gallery);

      if (alinanDosya != null) {
        setState(() {
          File yuklenecekDosya = File(alinanDosya.path);
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('flutter-tests')
              .child('/some-image.jpg');

          // ignore: unused_local_variable
          UploadTask yuklemeGorevi = ref.putFile(yuklenecekDosya);
          resmiUrlyeAl(ref);
        });
      }

      //else buraya yazabilirsin
    }

    var montserrat = const TextStyle(
      fontSize: 12,
    );

    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: AvatarClipper(),
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 11,
                          top: 50,
                          child: Row(
                            children: [
                              //? ********************************<<RESİM ALANI>>******************************************
                              InkWell(
                                onTap: () {
                                  setState(() {});
                                  galeridenYukle();
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: gelenResim == null
                                      ? NetworkImage(resimurl)
                                      : NetworkImage(gelenResim!),
                                ),
                              ),
                              const SizedBox(width: 20),
                              AdSoyad()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //? ********************************<<YAZI ALANI>>******************************************

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Twitter Account: \n GitHub Account: ",
                              style: montserrat,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Official Start: \n Occupation: ",
                              style: montserrat,
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Randevu Defteri'))
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: Color(0xFF9A9A9A),
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('       Video      '))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column AdSoyad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr.${widget.druser.danAd} ${widget.druser.danSoyad}',
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 28),
        const SizedBox(height: 8)
      ],
    );
  }

  TextStyle buildMontserrat(
    Color color, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
