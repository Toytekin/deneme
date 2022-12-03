import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/sayfalar/doktor/doctor_home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DrTestlerimSayfasi extends StatelessWidget {
  DanisanModel drUser;

  DrTestlerimSayfasi({super.key, required this.drUser});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VeriTabani>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<TestModel>>(
            future: provider.kategoriGetir(drUser),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var oankiVeri = snapshot.data![index];

                    return InkWell(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(oankiVeri.kategori),
                            content: const Text(
                                'Silinme işlemini onaylıyor musun ?'),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange),
                                onPressed: () {
//? *********************<< S İ L M E >>***************************************

                                  // ignore: use_build_context_synchronously
                                  showTopSnackBar(
                                    animationDuration:
                                        const Duration(milliseconds: 1200),
                                    displayDuration:
                                        const Duration(milliseconds: 500),
                                    context,
                                    const CustomSnackBar.success(
                                      message: "Test Silindi",
                                    ),
                                  );
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        DoktorHomeSayfasi(druser: drUser),
                                  ));
                                },
                                child: const Text(' SİL   '),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('VAZGEÇ'),
                              )
                            ],
                          ),
                        );
                      },
                      child: Card(
                          child: ListTile(
                              title: Text(
                        oankiVeri.kategori,
                      ))),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const CircularProgressIndicator();
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
