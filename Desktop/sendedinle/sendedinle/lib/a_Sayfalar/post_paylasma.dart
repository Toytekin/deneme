import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/a_Sayfalar/home/home.dart';
import 'package:myapp/constant/snacbar.dart';
import 'package:myapp/model/post_like_model.dart';
import 'package:myapp/model/post_model.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/model/yorum_model.dart';
import 'package:myapp/repo/post/post_db.dart';
import 'package:myapp/widget/textfild.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../repo/profilresmi/profil_db.dart';

// ignore: must_be_immutable
class PostPaylasmaScreen extends StatefulWidget {
  UserModel userModel;
  PostPaylasmaScreen({super.key, required this.userModel});

  @override
  State<PostPaylasmaScreen> createState() => _PostPaylasmaScreenState();
}

class _PostPaylasmaScreenState extends State<PostPaylasmaScreen> {
  var title = TextEditingController();
  ImagePicker imagePicker = ImagePicker();

  File? resimDosya;
  String? kapakresmiIndirmeUrl;
  String basePhoto = 'asset/sendedinle.jpeg';

  File? file;
  List<YorumModel> yorumlar = [];
  bool kayitTamamlama = false;
  bool yuklemeBaslasin = false;
  bool muzikYuklemeBaslasin = false;
  bool muzikGeldi = false;
  String klasorID = const Uuid().v1();

  final String baseFotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/sendedinle-3c8e9.appspot.com/o/snededinle%2Fsendedinle.jpeg?alt=media&token=b9858767-31d2-4545-8fcd-b64c5ae16d47';

  @override
  Widget build(BuildContext context) {
    var providerPost = Provider.of<PostDB>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            yuklemeBaslasin == true ? 'Yükleniyor Lütfen Bekleyin...' : ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //*****************<< KAPAK RESMİ>>*************
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  await picImage();
                  if (resimDosya != null) {
                    var dosyaLink = await providerPost.muzikKapakResmi(
                        resimDosya!, klasorID);
                    if (dosyaLink != null) {
                      setState(() {
                        kapakresmiIndirmeUrl = dosyaLink;
                      });
                    }
                  } else {}
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black, width: 2)),
                  width: Get.width / 2,
                  height: Get.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: resimDosya != null
                          ? Image.file(resimDosya!, fit: BoxFit.fill)
                          : Image.asset('asset/sendedinle.jpeg'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            //*****************<< MÜZİK SEÇME>>*************
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  setState(() {});
                  muzikYuklemeBaslasin = true;
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      file = File(result.files.single.path!);
                      muzikYuklemeBaslasin = false;
                      muzikGeldi = true;
                    });
                  } else {
                    setState(() {
                      muzikYuklemeBaslasin = false;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black, width: 2)),
                  width: Get.width,
                  height: Get.width / 4,
                  child: Center(
                    child: muzikYuklemeBaslasin == false
                        ? muzikGeldi == false
                            ? const Icon(Icons.download, size: 40)
                            : const Icon(Icons.check, size: 40)
                        : const CircularProgressIndicator(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //*****************<< Title>>*************
            SbtTextFild(textEditingController: title, hintText: 'Şarkı Adı'),
            const SizedBox(height: 30),
            //! "*****************<< KAYDET>>*************

            yuklemeBaslasin == false
                ? ElevatedButton(
                    onPressed: () async {
                      setState(() {});
                      yuklemeBaslasin = true;
                      kayitTamamlama = false;
                      var likeID = const Uuid().v1();
                      String postID = const Uuid().v1();
                      var tarih = DateTime.now();

                      var profilPhotoUrl = await resimKontrol();

                      if (file != null) {
                        String? indirmeURL = await providerPost.muzikSave(
                            file!, widget.userModel.id, postID, klasorID);
                        if (kapakresmiIndirmeUrl != null) {
                          PostModel yeniPostModel;
                          if (indirmeURL != null && profilPhotoUrl != null) {
                            yeniPostModel = await providerPost.returnPostModel(
                                widget.userModel.id,
                                likeID,
                                postID,
                                widget.userModel.name,
                                title.text.toString(),
                                indirmeURL,
                                kapakresmiIndirmeUrl!,
                                profilPhotoUrl,
                                tarih,
                                0,
                                yorumlar);
                          } else {
                            yeniPostModel = await providerPost.returnPostModel(
                                widget.userModel.id,
                                likeID,
                                postID,
                                widget.userModel.name,
                                title.text.toString(),
                                baseFotoUrl,
                                kapakresmiIndirmeUrl!,
                                baseFotoUrl,
                                tarih,
                                0,
                                yorumlar);
                          }

                          var postLikeModel = PostLikeModel(
                              likeid: likeID,
                              postID: postID,
                              userID: widget.userModel.id,
                              begendim: true);

                          await providerPost.begenDefault(postLikeModel);
                          bool kayit =
                              await providerPost.saveMuzikStrore(yeniPostModel);

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    context: context,
                                    userModel: widget.userModel),
                              ),
                              (route) => false);
                          // ignore: use_build_context_synchronously
                          SbtSnacbar.snacBarSucces(
                              context, 'Başarıyla Paylaşıldı');

                          setState(() {
                            kayitTamamlama = kayit;
                            yuklemeBaslasin = false;
                          });
                        } else {
                          // ignore: use_build_context_synchronously
                          SbtSnacbar.snacBarError(context, 'Bir hata oluştu');
                          yuklemeBaslasin = false;
                          kayitTamamlama = false;
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        SbtSnacbar.snacBarError(
                            context, 'Bir Dosya Seçmelisin');
                        yuklemeBaslasin = false;
                        kayitTamamlama = false;
                      }
                    },
                    child: const Text('Paylaş'),
                  )
                : lotti()
          ],
        ),
      ),
    );
  }

  Future<String?> resimKontrol() async {
    var photoDB = Provider.of<ProfilResmiDB>(context, listen: false);

    String? resimIndirmeBaglantisi = await photoDB.resimcek();

    if (resimIndirmeBaglantisi != null) {
      return resimIndirmeBaglantisi;
    } else {
      return null;
    }
  }

  Expanded lotti() {
    return Expanded(
        flex: 1,
        child: Center(
          child: Lottie.asset(
            'asset/loading.json',
            fit: BoxFit.cover,
          ),
        ));
  }

  Future<void> picImage() async {
    var photo = await imagePicker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      resimDosya = File(photo.path);
      setState(() {});
    } else {}
  }
}
