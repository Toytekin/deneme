import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/provider/soru_sayisi.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class PuanlamaWidget extends StatefulWidget {
  DanisanModel danisanModel;
  TestModel test;
  PuanlamaWidget({super.key, required this.test, required this.danisanModel});

  @override
  State<PuanlamaWidget> createState() => _PuanlamaWidgetState();
}

class _PuanlamaWidgetState extends State<PuanlamaWidget> {
  String gelenCevap = '';

  double slideValue = 100.0;

  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final soruSayisiProvider =
        Provider.of<SoruSayisiProvider>(context, listen: true);
    final dbProvider = Provider.of<VeriTabani>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: MediaQuery.of(context).size.width - 20,
          height: 200,
          child: Center(child: Text(widget.test.soru)),
        ),
        const SizedBox(height: 10),
        Slider(
          activeColor: Colors.red,
          max: 100.0,
          divisions: 10,
          label: '$slideValue',
          value: slideValue,
          onChanged: (value) {
            setState(() {
              slideValue = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () async {
                gelenCevap = slideValue.toString();
                if (gelenCevap == '') {
                  showTopSnackBar(
                    animationDuration: const Duration(milliseconds: 1200),
                    displayDuration: const Duration(milliseconds: 500),
                    context,
                    const CustomSnackBar.info(
                      message: " Cevap Vermediniz Sanırım",
                    ),
                  );
                } else {
                  var testModel = TestModel(
                      kategori: widget.test.kategori,
                      gonderenDrTc: widget.test.gonderenDrTc,
                      soru: widget.test.soru,
                      aSikki: widget.test.aSikki,
                      bSikki: widget.test.bSikki,
                      cSikki: widget.test.cSikki,
                      dSikki: widget.test.dSikki,
                      eSikki: widget.test.eSikki,
                      cevap: widget.test.cevap,
                      gelenCevap: gelenCevap,
                      tip: widget.test.tip,
                      testCozenID: widget.test.testCozenID,
                      soruIdm: widget.test.soruIdm);
                  soruSayisiProvider.cevapVer();
                  await dbProvider.danisanCevapAl(
                      widget.danisanModel, testModel);
                  // ignore: use_build_context_synchronously
                  showTopSnackBar(
                    animationDuration: const Duration(milliseconds: 1200),
                    displayDuration: const Duration(milliseconds: 500),
                    context,
                    const CustomSnackBar.success(
                      message: " Kaydedildi",
                    ),
                  );
                }
              },
              child: const Text('KAYDET')),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Container SoruAlani(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width - 20,
      height: 200,
      child: Center(child: Text(widget.test.soru)),
    );
  }
}
