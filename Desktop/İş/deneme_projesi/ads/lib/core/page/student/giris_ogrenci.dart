import 'package:ads/core/constant/akademisyen_builder.dart';
import 'package:ads/core/constant/randevukart_ogrenci.dart';
import 'package:ads/core/models/randevumodel.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/page/student/a_akademisyen_liste.dart';
import 'package:ads/core/page/student/messaj.dart';
import 'package:ads/core/services/randevu_save.dart';
import 'package:ads/core/services/save_user.dart';
import 'package:flutter/material.dart';

class OgrenciGiris extends StatefulWidget {
  final UserModel userModel;
  const OgrenciGiris({
    super.key,
    required this.userModel,
  });

  @override
  State<OgrenciGiris> createState() => _OgrenciGirisState();
}

class _OgrenciGirisState extends State<OgrenciGiris> {
  List<RandevuModel> allRandevu = [];
  List<UserModel> allAkademisyen = [];

  var getRandevu = FrRandevuSave();
  var frSaveUser = FrSaveUser();
  @override
  void initState() {
    super.initState();
    randevuGetir();
    akademisyenleriCek();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 46, 27, 154), // İlk renk
                Color.fromARGB(255, 222, 205, 161), // İkinci renk
              ],
            ),
          ),
          child: TabBarView(
            children: [
              //RAndevüler
              randevulerEkrani(),
              hocalariListele(widget.userModel),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.white,
          child: TabBar(
            tabs: [
              Tab(
                text: 'Randevular',
              ),
              Tab(
                text: 'Akademisyenler',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                80.0), // Kare şeklinde yapmak için köşe yarıçapını ayarlayın
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AkademisyenListeleme(userModel: widget.userModel)),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Center randevulerEkrani() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RANDEVULAR',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MessajScreen(userModel: widget.userModel)),
                      );
                    },
                    icon: const Icon(
                      Icons.message,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allRandevu.length,
              itemBuilder: (context, index) {
                var item = allRandevu[index];
                return RandevuKartiOgrenci(item: item);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> randevuGetir() async {
    var data =
        await getRandevu.getRandevularByOgrenciID(widget.userModel.userID);

    if (data == null) {
      allRandevu = [];
    } else {
      setState(() {
        allRandevu = data;
      });
    }
  }

  Widget hocalariListele(UserModel userModel) {
    return ListView.builder(
      itemCount: allAkademisyen.length,
      itemBuilder: (context, index) {
        var item = allAkademisyen[index];

        return AkademiisyenBuilder(item: item);
      },
    );
  }

  Future<void> akademisyenleriCek() async {
    var data = await frSaveUser.getAllAkademisyen();
    if (data == null) {
      allAkademisyen = [];
    } else {
      for (var element in data) {
        if (element.ogrnciBolum == widget.userModel.ogrnciBolum) {
          allAkademisyen.add(element);
        }
      }
      setState(() {});
    }
  }
}
