import 'package:ads/core/constant/color.dart';
import 'package:ads/core/constant/randevukartlari.dart';
import 'package:ads/core/constant/textstyle.dart';
import 'package:ads/core/models/randevumodel.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/page/akademisyen/randevu_onay.dart';
import 'package:ads/core/page/akademisyen/randevu_red.dart';
import 'package:ads/core/services/randevu_save.dart';
import 'package:flutter/material.dart';

class AkademisyenScreen extends StatefulWidget {
  final UserModel userModel;
  const AkademisyenScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<AkademisyenScreen> createState() => _AkademisyenScreenState();
}

class _AkademisyenScreenState extends State<AkademisyenScreen> {
  List<RandevuModel> onayliRandevular = [];
  List<RandevuModel> bekleyenliRandevular = [];

  var getRandevu = FrRandevuSave();

  @override
  void initState() {
    super.initState();
    randevuGetir();
  }

  Future<void> randevuGetir() async {
    var data =
        await getRandevu.getRandevularAkademisyenID(widget.userModel.userID);

    if (data == null) {
      onayliRandevular = [];
    } else {
      setState(() {
        for (var element in data) {
          if (element.onayDurumu == true) {
            onayliRandevular.add(element);
          } else {
            bekleyenliRandevular.add(element);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          child: Center(
            child: TabBarView(
              children: [
                //Onaylananları Listeleme

                ListView.builder(
                  itemCount: onayliRandevular.length,
                  itemBuilder: (context, index) {
                    var item = onayliRandevular[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RandevuRedScreen(
                                randevuModel: item,
                                userModel: widget.userModel,
                              ),
                            ),
                          );
                        },
                        child: RandevuKarti(item: item));
                  },
                ),
                //Bekleyenleri Listeleme
                ListView.builder(
                  itemCount: bekleyenliRandevular.length,
                  itemBuilder: (context, index) {
                    var item = bekleyenliRandevular[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RandevuOnayEkrani(
                                randevuModel: item,
                                userModel: widget.userModel,
                              ),
                            ),
                          );
                        },
                        child: RandevuKarti(item: item));
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: SbtColors.anaRenk,
          child: TabBar(
            labelStyle: SbtTextStyle().normalStyle,
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            tabs: const [
              Tab(
                text: 'Onaylanan R.',
              ),
              Tab(
                text: 'Bekleyen R.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
