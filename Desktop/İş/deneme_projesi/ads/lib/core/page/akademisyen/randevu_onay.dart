import 'package:ads/core/constant/textstyle.dart';
import 'package:ads/core/models/mesaj_model.dart';
import 'package:ads/core/models/randevumodel.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/page/akademisyen/d_g_akd.dart';
import 'package:ads/core/services/randevu_save.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class RandevuOnayEkrani extends StatefulWidget {
  final UserModel userModel;
  final RandevuModel randevuModel;

  const RandevuOnayEkrani({
    super.key,
    required this.randevuModel,
    required this.userModel,
  });

  @override
  State<RandevuOnayEkrani> createState() => _RandevuOnayEkraniState();
}

var saveRandevu = FrRandevuSave();

class _RandevuOnayEkraniState extends State<RandevuOnayEkrani> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AkademisyenScreen(userModel: widget.userModel)),
            );
          },
          icon: const Icon(Icons.home, color: Colors.white),
        ),
      ),
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.height / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bilgiler(),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _sendEmail();
                      },
                      label: const Text(
                        'Mail Yolla',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Mesajınız'),
                                content: TextField(
                                  maxLines: 5,
                                  controller: _textFieldController,
                                  decoration: const InputDecoration(),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Vazgeç'),
                                    onPressed: () {
                                      FocusScope.of(context)
                                          .unfocus(); // Odak kaldırılıyor
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () async {
                                      if (_textFieldController
                                          .text.isNotEmpty) {
                                        await _randevuOnayla();
                                        FocusScope.of(context)
                                            .unfocus(); // Odak kaldırılıyor
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AkademisyenScreen(
                                              userModel: widget.userModel,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Onayla'))
                  ],
                ))
              ],
            )),
      ),
    );
  }

  Card bilgiler() {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.randevuModel.ogrenciName,
            style: SbtTextStyle().largeStyleBoldSiyah,
          ),
          Column(
            children: [
              Text(widget.randevuModel.baslik),
              Text(widget.randevuModel.mesaj),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.randevuModel.tarih),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _randevuOnayla() async {
    var id = const Uuid().v1();
    var mesaj = MessajModel(
        mesajID: id,
        ogrenciID: widget.randevuModel.ogrenciID,
        messaj: _textFieldController.text.toString());

    await saveRandevu.randevuOnayMesajYolla(mesaj);
    await saveRandevu.toggleOnayDurumu(widget.randevuModel.randevuID, true);

    _textFieldController.clear();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.randevuModel.ogrenciMail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );
    launchUrl(emailLaunchUri);
  }
}
