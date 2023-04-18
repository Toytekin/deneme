import 'dart:async';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/a_Sayfalar/home/home.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/model/yorum_model.dart';
import 'package:myapp/widget/textfild.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../repo/post/post_db.dart';
import '../../repo/profilresmi/profil_db.dart';

// ignore: must_be_immutable
class YorumlarScreen extends StatefulWidget {
  UserModel userModel;
  String postID;
  String userID;
  String userPhotoUrl;

  YorumlarScreen({
    super.key,
    required this.userModel,
    required this.postID,
    required this.userID,
    required this.userPhotoUrl,
  });

  @override
  State<YorumlarScreen> createState() => _YorumlarScreenState();
}

class _YorumlarScreenState extends State<YorumlarScreen> {
  var yorumController = TextEditingController();

  List<YorumModel> allYorumlar = [];
  String? aktifUserPhotoUrl;
  String baseFotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/sendedinle-3c8e9.appspot.com/o/snededinle%2Fsendedinle.jpeg?alt=media&token=b9858767-31d2-4545-8fcd-b64c5ae16d47';
  @override
  void initState() {
    super.initState();
    yorumlariGetir();
    resimAl();
  }

  @override
  Widget build(BuildContext context) {
    var dbProviider = Provider.of<PostDB>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              //  _timer!.cancel();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Home'),
      ),
      body: allYorumlar.isEmpty
          ? const Center(
              child: Text('Yorum yapılmadı'),
            )
          : ListView.builder(
              itemCount: allYorumlar.length,
              itemBuilder: (context, index) {
                var tekData = allYorumlar[index];
                DateTime dateTime = tekData.yorumTarih.toDate();
                return Card(
                  child: ListTile(
                    title: Text(tekData.yorum),
                    subtitle: Text(dateTime.toString()),
                    leading: CircularProfileAvatar('',
                        cacheImage: true,
                        imageFit: BoxFit.cover,
                        borderColor: Colors.black,
                        borderWidth: 1,
                        elevation: 3,
                        radius: 20,
                        child: Image.network(
                          tekData.usrPhotoUrl,
                          fit: BoxFit.cover,
                        )
                        // ignore: unnecessary_null_comparison

                        ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.comment),
        onPressed: () {
          var yorumID = const Uuid().v1();

          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                reverse: true,
                child: Container(
                  color: Colors.grey,
                  height: Get.height * 0.8,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SbtTextFild3(
                            textEditingController: yorumController,
                            hintText: 'YorumEkle'),
                        ElevatedButton(
                          child: const Text('Close BottomSheet'),
                          onPressed: () async {
                            if (yorumController.text.isNotEmpty) {
                              var yorumTarih = Timestamp.now();
                              var yorumModel = YorumModel(
                                  usrPhotoUrl: baseFotoUrl,
                                  userID: widget.userID,
                                  yorumID: yorumID,
                                  yorum: yorumController.text.toString(),
                                  yorumTarih: yorumTarih);
                              await dbProviider.postYorumEkleme(
                                  widget.postID, yorumModel);
                              setState(() {});
                            } else {}

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                        context: context,
                                        userModel: widget.userModel)),
                                (route) => false);
                            yorumController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  resimAl() async {
    var db = Provider.of<ProfilResmiDB>(context, listen: false);
    var resimUrl = await db.resimcek();
    if (resimUrl != null) {
      baseFotoUrl = resimUrl;
      setState(() {});
    }
  }

  Future<void> yorumlariGetir() async {
    var dbProviider = Provider.of<PostDB>(context, listen: false);
    var gelenList = await dbProviider.yorumlariGetir(widget.postID);

    // ignore: unrelated_type_equality_checks
    if (gelenList!.isNotEmpty) {
      allYorumlar = gelenList;
    }
    setState(() {});
  }

  Future<String> fotoCek(String postID) async {
    var db = Provider.of<ProfilResmiDB>(context, listen: false);
    var documentReference = await FirebaseFirestore.instance
        .collection('tmpostlar')
        .doc(postID)
        .get();
    var data = documentReference.data();
    if (data != null) {
      var yorumList = data['yorumlar'];
      for (var element in yorumList) {
        YorumModel yorumModel = YorumModel.fromMap(element);
        String? resimURL = await db.idyeGoreResimCek(yorumModel.userID);
        if (resimURL != null) {
          baseFotoUrl = resimURL;
          return baseFotoUrl;
        }
        return baseFotoUrl;
      }
      setState(() {});
    }
    return baseFotoUrl;
  }
}
