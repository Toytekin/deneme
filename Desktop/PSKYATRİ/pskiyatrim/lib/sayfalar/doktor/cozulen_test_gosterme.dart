import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';

import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';

// ignore: must_be_immutable
class CozulenTestGosterme extends StatelessWidget {
  DanisanModel danisanModel;
  TestModel test;
  CozulenTestGosterme(
      {super.key, required this.danisanModel, required this.test});

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<VeriTabani>(context);

    return Scaffold(
      appBar: appbarAdmin(
        arkaplanRengi: Colors.deepOrange,
        appbarTitile: test.kategori,
        press: () {
          Navigator.of(context).pop();
        },
        appbarWidget: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(test.kategori),
                  content: const Text('Silinme işlemini onaylıyor musun ?'),
                  actions: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepOrange),
//                       onPressed: () async {
// //! *********************<< S İ L M E >>***************************************
//                         String drTc = dbProviderDr.tcAl();
//                          await dbProvider.gonderilenTestiSil(
//                              test, danisanModel, drTc);

//                          ignore: use_build_context_synchronously
//                         showTopSnackBar(
//                           animationDuration: const Duration(milliseconds: 1200),
//                           displayDuration: const Duration(milliseconds: 500),
//                           context,
//                           const CustomSnackBar.success(
//                             message: "Gönderilen Test Silindi",
//                           ),
//                         );
//                          ignore: use_build_context_synchronously
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => DoktorHomeSayfasi(
//                                     druser: danisanModel,
//                                   )),
//                         );
//                       },
//                       child: const Text(' SİL   '),
//                     ),
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
            icon: const Icon(Icons.delete)),
      ),
      body: FutureBuilder<List<TestModel>>(
        future: dbProvider.testGetir(danisanModel, test),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var oankiVeri = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        danisanModel.danTC.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        oankiVeri.gelenCevap,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
