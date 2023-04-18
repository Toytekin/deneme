import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/a_Sayfalar/home/user_setting.dart';
import 'package:myapp/a_Sayfalar/post_paylasma.dart';
import 'package:myapp/constant/home_cart.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/model/yorum_model.dart';
import 'package:myapp/repo/post/post_db.dart';
import 'package:provider/provider.dart';

import '../../repo/login/db_user.dart';
import '../../repo/login/repo_login.dart';
import '../../repo/profilresmi/profil_db.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  BuildContext context;
  UserModel userModel;

  HomeScreen({super.key, required this.context, required this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? kullanilacakUser;
  String? resimIndirmeBaglantisi;
  String? resimUrl;
  bool? begendim;

  List<UserModel> usureList = [];

  String userName = '';
  @override
  void initState() {
    super.initState();
    tumPostlariGetir();

    getir();
    resimKontrol();
    setState(() {});
  }

  getir() async {
    //! postmodele göre user çekme işlemi yap
    var userVarmi = await DbUser().yeniUser(widget.userModel);
    // ignore: unnecessary_null_comparison
    if (userVarmi != null) {
      kullanilacakUser = userVarmi;
      userName = userVarmi.name;
    } else {
      kullanilacakUser = widget.userModel;
      userName = widget.userModel.name;
    }
    setState(() {});
  }

  YorumModel? yorum1;
  resimKontrol() async {
    var photoDB = ProfilResmiDB();

    resimIndirmeBaglantisi = await photoDB.resimcek();
  }

  tumPostlariGetir() async {
    var db = Provider.of<PostDB>(context, listen: false);

    List<UserModel> gelenUserlar = await db.tumUserlariGetir();
    if (gelenUserlar.isNotEmpty) {
      usureList = gelenUserlar;
    }
  }

  @override
  Widget build(BuildContext context) {
    var services = Provider.of<MyLoginServices>(context, listen: false);
    var providerPost = Provider.of<PostDB>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserSettingsScreen(id: widget.userModel),
            ));
          },
          icon: const Icon(Icons.person_2_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await services.signOuth();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: providerPost.db.collection('tmpostlar').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          debugPrint(snapshot.toString());
          if (snapshot.hasError) {
            return Text('Bir hata oluştu: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var document = snapshot.data!.docs[index];
              var userProfilPhoto = document['userProfilPhoto'];

              return SbtHomeCart(
                  userModel: kullanilacakUser != null
                      ? kullanilacakUser!
                      : widget.userModel,
                  userName: document['userName'],
                  postID: document['postID'],
                  postLikeID: document['postLikeID'],
                  begendim: false,
                  linkImgPost: document['photoUrl'],
                  linkImgUser: userProfilPhoto,
                  begeniSayisi: document['begeniSayisi'].toString(),
                  kullnici: userName,
                  sarkiAdi: document['title'],
                  yorumSayisi: '25');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PostPaylasmaScreen(userModel: kullanilacakUser!),
          ));
        },
        child: const FaIcon(FontAwesomeIcons.music),
      ),
    );
  }

  String? resimcek(provideProfil, String userID) {
    for (var i = 0; i < usureList.length; i++) {
      if (usureList[i].id == userID) {
        return usureList[i].photoUrl;
      }
    }
    return null;
  }
}
