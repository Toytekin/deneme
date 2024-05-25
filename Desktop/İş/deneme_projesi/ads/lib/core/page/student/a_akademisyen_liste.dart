import 'package:ads/core/constant/randevu.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/page/student/b_randevu_detay.dart';
import 'package:ads/core/services/save_user.dart';
import 'package:flutter/material.dart';

class AkademisyenListeleme extends StatefulWidget {
  final UserModel userModel;
  const AkademisyenListeleme({
    super.key,
    required this.userModel,
  });

  @override
  State<AkademisyenListeleme> createState() => _AkademisyenListelemeState();
}

class _AkademisyenListelemeState extends State<AkademisyenListeleme> {
  List<UserModel> allAkademisyen = [];
  var frSaveUser = FrSaveUser();

  @override
  void initState() {
    super.initState();
    akademisyenleriCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                ],
              )),
              const RandevuText(),
              const RandevuTextSub(),
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: allAkademisyen.length,
                  itemBuilder: (context, index) {
                    var item = allAkademisyen[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RandevuOlustur(
                              userModel: widget.userModel,
                              userModelAkademisyen: item,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(item.userName),
                          subtitle: Text(item.userMail),
                          leading: ClipOval(
                            child: Image.asset(
                              resimCek(item.userMail),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
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

  String resimCek(String hocaMail) {
    switch (hocaMail) {
      case ' firdevsdurnagol@beykent.edu.tr':
        return 'assets/image/firdevs.jpeg';

      case 'ugurguvenadar@beykent.edu.tr':
        return 'assets/image/ugur.jpeg';

      case ' mukaddesgundogdu@beykent.edu.tr':
        return 'assets/image/mukaddes.jpeg';
      //
      case ' ozlemguzelyazici@beykent.edu.tr':
        return 'assets/image/ozlem.jpeg';

      case 'ahsenerden@beykent.edu.tr':
        return 'assets/image/ahsen.jpeg';

      default:
        return 'assets/image/ahsen.jpeg';
    }
  }
}
