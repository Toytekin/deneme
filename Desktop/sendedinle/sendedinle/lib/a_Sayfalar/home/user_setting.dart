import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/a_Sayfalar/home/home.dart';
import 'package:myapp/constant/snacbar.dart';
import 'package:myapp/repo/login/db_user.dart';
import 'package:myapp/widget/textfild.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:provider/provider.dart';
import '../../model/user_model.dart';
import '../../repo/profilresmi/profil_db.dart';

// ignore: must_be_immutable
class UserSettingsScreen extends StatefulWidget {
  UserModel id;
  UserSettingsScreen({super.key, required this.id});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  var adController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  File? dosya;
  String? resimIndirmeBaglantisi;
  String? gelenHintText;
  UserModel? userModel;
  bool tiklandi = false;

  @override
  void initState() {
    super.initState();
    resimKontrol();
  }

  resimKontrol() async {
    var photoDB = Provider.of<ProfilResmiDB>(context, listen: false);
    userModel = await DbUser().yeniUser(widget.id);

    resimIndirmeBaglantisi = await photoDB.resimcek();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var userDB = Provider.of<DbUser>(context, listen: false);
    var photoDB = Provider.of<ProfilResmiDB>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: userModel != null ? Text(userModel!.name) : const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ***************<<PROFİL RESMİ>>******************

            CircularProfileAvatar(
              '',
              cacheImage: true,
              imageFit: BoxFit.cover,
              borderColor: Colors.black,
              borderWidth: 2,
              elevation: 10,
              onTap: () async {
                await picImage();
              },
              radius: 50,
              child: dosya != null
                  ? Image.file(dosya!, fit: BoxFit.cover)
                  : resimIndirmeBaglantisi != null
                      ? Image.network(
                          resimIndirmeBaglantisi!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("asset/user.png"),
            ),
            // ***************<<TEXTFİELD>>******************
            const SizedBox(height: 3),
            SbtTextFild(
                textEditingController: adController,
                hintText: userModel != null ? userModel!.name : ''),
            const SizedBox(height: 3),
            // ***************<< KAYDETME >>******************
            tiklandi == false
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    child: const Text('Kaydet'),
                    onPressed: () async {
                      setState(() {
                        tiklandi = true;
                      });
                      if (dosya != null && adController.text.isNotEmpty) {
                        var resimUrl = await photoDB.resimYukle(dosya!);

                        UserModel eklenecekUser = UserModel(
                            name: adController.text.toString(),
                            id: userModel!.id,
                            mail: userModel!.mail,
                            photoUrl: resimUrl!);
                        await userDB.saveUser(eklenecekUser);
                        adController.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                  context: context, userModel: userModel!),
                            ),
                            (route) => false);
                        tiklandi = false;
                      } else {
                        SbtSnacbar.snacBarError(context,
                            'Resim sectiğine ve isim belirlediğine emin ol.Resme tıkla ! resim sec.');
                        tiklandi = false;
                        setState(() {});
                      }
                    },
                  )
                : const CircularProgressIndicator(
                    color: Colors.black,
                  )
          ],
        ),
      ),
    );
  }

  Future<void> picImage() async {
    var photo = await imagePicker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      setState(() {
        dosya = File(photo.path);
      });
    } else {
      return;
    }
  }
}
