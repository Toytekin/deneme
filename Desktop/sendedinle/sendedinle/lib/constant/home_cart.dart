import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/a_Sayfalar/home/begenenler_sayfasi.dart';
import 'package:myapp/a_Sayfalar/home/yorumlar.dart';
import 'package:myapp/model/post_like_model.dart';
import 'package:myapp/model/user_model.dart';
import 'package:provider/provider.dart';

import '../model/yorum_model.dart';
import '../repo/post/post_db.dart';

// ignore: must_be_immutable
class SbtHomeCart extends StatefulWidget {
  UserModel userModel;
  String postLikeID;
  String postID;
  String? linkImgUser;
  String? linkImgPost;
  bool begendim;
  String userName;
  String kullnici;
  String sarkiAdi;
  String begeniSayisi;
  String yorumSayisi;

  SbtHomeCart({
    super.key,
    required this.userModel,
    required this.userName,
    required this.postID,
    required this.postLikeID,
    required this.begendim,
    required this.linkImgPost,
    required this.linkImgUser,
    required this.begeniSayisi,
    required this.kullnici,
    required this.sarkiAdi,
    required this.yorumSayisi,
  });

  @override
  State<SbtHomeCart> createState() => _SbtHomeCartState();
}

class _SbtHomeCartState extends State<SbtHomeCart> {
  List<YorumModel> allYorumlar = [];
  @override
  void initState() {
    super.initState();
    begeniDurum();
    yorumlariGetir();
    setState(() {});
  }

  bool likebool = false;
  @override
  Widget build(BuildContext context) {
    var providerPost = Provider.of<PostDB>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: [
          profilResmi(),
          const SizedBox(height: 20),
          InkWell(
            onDoubleTap: () async {
              if (likebool == true) {
                PostLikeModel postLikeModel = PostLikeModel(
                    likeid: widget.postLikeID,
                    postID: widget.postID,
                    userID: providerPost.firebaseAuth.currentUser!.uid,
                    begendim: false);
                await kaydet(providerPost, postLikeModel);
              } else {
                PostLikeModel postLikeModel2 = PostLikeModel(
                    likeid: widget.postLikeID,
                    postID: widget.postID,
                    userID: providerPost.firebaseAuth.currentUser!.uid,
                    begendim: true);
                await kaydet(providerPost, postLikeModel2);
              }

              //? Buraya bakacam

              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black, width: 2)),
              width: Get.width,
              height: Get.width,
              child: widget.linkImgPost != null
                  ? Image.network(
                      widget.linkImgPost!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("asset/sendedinle.jpeg"),
            ),
          ),
          const SizedBox(height: 20),
          Text(widget.sarkiAdi),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    var userID = providerPost.firebaseAuth.currentUser!.uid;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => YorumlarScreen(
                        userModel: widget.userModel,
                        userPhotoUrl: widget.linkImgUser!,
                        postID: widget.postID,
                        userID: userID,
                      ),
                    ));
                  },
                  icon: const FaIcon(FontAwesomeIcons.comment),
                  label: Text(allYorumlar.length.toString())),
              const SizedBox(width: 25),
              TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BegenenlerSayfasi(postID: widget.postID),
                    ));
                  },
                  icon: Icon(likebool == false
                      ? Icons.favorite_border
                      : Icons.favorite),
                  label: Text(widget.begeniSayisi))
            ],
          )
        ],
      ),
    );
  }

  Row profilResmi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(widget.userName),
        const SizedBox(width: 20),
        CircularProfileAvatar(
          '',
          cacheImage: true,
          imageFit: BoxFit.cover,
          borderColor: Colors.black,
          borderWidth: 2,
          elevation: 10,
          radius: 20,
          child:
              // ignore: unnecessary_null_comparison
              widget.linkImgUser != null
                  ? Image.network(
                      widget.linkImgUser!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("asset/sendedinle.jpeg"),
        ),
      ],
    );
  }

  Future<void> kaydet(PostDB providerPost, PostLikeModel postLikeModel) async {
    if (likebool == true) {
      await providerPost.begenArttirAzalt(postLikeModel, false);
      likebool = false;
    } else if (likebool == false) {
      await providerPost.begenArttirAzalt(postLikeModel, true);
      likebool = true;
    }
  }

  Future<void> begeniDurum() async {
    var db = Provider.of<PostDB>(context, listen: false);
    var dbID = db.firebaseAuth.currentUser!.uid;
    var begeni = await db.begeniGetir(widget.postID, dbID);
    likebool = begeni;
  }

  Future<void> yorumlariGetir() async {
    var dbProviider = Provider.of<PostDB>(context, listen: false);
    var gelenList = await dbProviider.yorumlariGetir(widget.postID);

    // ignore: unrelated_type_equality_checks
    if (gelenList!.isNotEmpty) {
      allYorumlar = gelenList;
    }
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }
}
