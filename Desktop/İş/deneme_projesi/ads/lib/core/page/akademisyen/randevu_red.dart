import 'package:ads/core/constant/textstyle.dart';
import 'package:ads/core/models/randevumodel.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/page/akademisyen/d_g_akd.dart';
import 'package:ads/core/services/randevu_save.dart';
import 'package:flutter/material.dart';

class RandevuRedScreen extends StatefulWidget {
  final UserModel userModel;
  final RandevuModel randevuModel;

  const RandevuRedScreen({
    super.key,
    required this.randevuModel,
    required this.userModel,
  });

  @override
  State<RandevuRedScreen> createState() => _RandevuRedScreenState();
}

var saveRandevu = FrRandevuSave();

class _RandevuRedScreenState extends State<RandevuRedScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            width: size.height / 2,
            height: size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bilgiler(),
                ElevatedButton(
                    onPressed: () {
                      _randevuOnayla();
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AkademisyenScreen(
                            userModel: widget.userModel,
                          ),
                        ),
                      );
                    },
                    child: const Text('Red'))
              ],
            )),
      ),
    );
  }

  Card bilgiler() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }

  _randevuOnayla() async {
    await saveRandevu.toggleOnayDurumu(widget.randevuModel.randevuID, false);
  }
}
