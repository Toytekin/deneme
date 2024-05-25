import 'package:ads/core/models/mesaj_model.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/services/randevu_save.dart';
import 'package:flutter/material.dart';

class MessajScreen extends StatefulWidget {
  final UserModel userModel;
  const MessajScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<MessajScreen> createState() => _MessajScreenState();
}

class _MessajScreenState extends State<MessajScreen> {
  List<MessajModel> allMesajlar = [];

  var firebase = FrRandevuSave();

  @override
  void initState() {
    super.initState();
    mesajlariCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Bildirimlerin',
          style: TextStyle(fontSize: 18),
        ),
      ),
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
        child: ListView.builder(
          itemCount: allMesajlar.length,
          itemBuilder: (context, index) {
            var item = allMesajlar[index];
            return Card(
              child: ListTile(
                title: Text(item.messaj),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> mesajlariCek() async {
    var data = await firebase.mesajlariCek(widget.userModel.userID);

    if (data == null) {
      allMesajlar = [];
    } else {
      debugPrint(data.length.toString());
      debugPrint(widget.userModel.userID);

      setState(() {
        allMesajlar = data;
      });
    }
  }
}
