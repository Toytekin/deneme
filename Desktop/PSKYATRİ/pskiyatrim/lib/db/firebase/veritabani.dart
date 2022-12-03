import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';

class VeriTabani {
  FirebaseFirestore users = FirebaseFirestore.instance;

  Future<Stream> getAllUserStream() async {
    var snapshot = users.collection('users').doc().snapshots();
    return snapshot;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTestGetir(
      DanisanModel danisanModel, TestModel testModel) {
    var snapshot = users
        .collection('users')
        .doc(danisanModel.danTC)
        .collection(testModel.kategori)
        .doc()
        .snapshots();

    List<TestModel> tumListem = [];
    snapshot.forEach((element) {
      var f = element.data();
      var data = TestModel.frommap(f!);
      tumListem.add(data);
    });

    return snapshot;
  }

  Future<List<DanisanModel>> getAllUsers() async {
    var querySnapshot = await users.collection('users').get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable
    List<DanisanModel> tumKullanicilar = [];
    for (var tekData in data) {
      DanisanModel userm = DanisanModel.frommap(tekData.data());
      tumKullanicilar.add(userm);
    }
    return tumKullanicilar;
  }

  Future<List<DanisanModel>> getAllDoktor() async {
    var querySnapshot = await users.collection('psikolog').get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable
    List<DanisanModel> tumKullanicilar = [];
    for (var tekData in data) {
      DanisanModel userm = DanisanModel.frommap(tekData.data());
      tumKullanicilar.add(userm);
    }
    return tumKullanicilar;
  }

  userDanisanDelete(DanisanModel danisanModel) async {
    await users.collection('users').doc(danisanModel.danTC).delete();
  }

  kategoriDelete(TestModel testModel) async {
    await users
        .collection('kategoriler')
        .doc(testModel.kategori + testModel.gonderenDrTc)
        .delete();
  }

  quizDelete(TestModel testModel, DanisanModel danisanModel) async {
    await users
        .collection('quiz')
        .doc('Deneme Testim15499302306')
        .collection('test')
        .doc()
        .delete();
  }

//! ************************<<< gonderilenTestiSil SİLL >>>********************************************
  gonderilenTestiSil(
      TestModel testModel, DanisanModel danisanModel, String drTc) async {
    await users
        .collection('danisankategoriler')
        .doc(testModel.testCozenID + drTc + testModel.kategori)
        .delete();
  }

  testEkle(TestModel testModel, DanisanModel danisanModel) async {
    await users
        .collection('quiz')
        .doc(testModel.kategori + danisanModel.danTC.toString())
        .collection('test')
        .doc()
        .set(TestModel.toMap(testModel));
    await users
        .collection('kategoriler')
        .doc(testModel.kategori + danisanModel.danTC.toString())
        .set(TestModel.toMap(testModel));
  }

//! ************************<<<Doktors HERŞEY SİLL >>>********************************************
  doktorHerseySil(DanisanModel danisanModel) async {
    await users.collection('psikolog').doc(danisanModel.danTC).delete();
//? ************************<<<Doktoron altındakileri sil >>>********************************************
    var querySnapshot = await users.collection('users').get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable

    for (var tekData in data) {
      DanisanModel allData = DanisanModel.frommap(tekData.data());

      if (allData.drTC == danisanModel.danTC) {
        await users.collection('users').doc(allData.danTC).delete();
      }
    }
    //? ************************<<<Doktoron altındakileri sil >>>********************************************
    var querySnapshotdanisankategoriler =
        await users.collection('danisankategoriler').get();
    var datadanisankategoriler = querySnapshotdanisankategoriler.docs;

    // ignore: unused_local_variable

    for (var tekData in datadanisankategoriler) {
      TestModel allData = TestModel.frommap(tekData.data());

      if (allData.gonderenDrTc == danisanModel.danTC) {
        await users
            .collection('danisankategoriler')
            .doc(allData.testCozenID + allData.gonderenDrTc + allData.kategori)
            .delete();
      }
    }
    //? ************************<<<Doktoron altındakileri kategori ve testlerini sil >>>********************************************
    var querySnapshotkategoriler = await users.collection('kategoriler').get();
    var datakategoriler = querySnapshotkategoriler.docs;

    // ignore: unused_local_variable

    for (var tekData in datakategoriler) {
      TestModel allData = TestModel.frommap(tekData.data());

      if (allData.gonderenDrTc == danisanModel.danTC) {
        await users
            .collection('kategoriler')
            .doc(allData.kategori + allData.gonderenDrTc)
            .delete();
        await users
            .collection('quiz')
            .doc(allData.kategori + danisanModel.danTC.toString())
            .collection('test')
            .doc()
            .delete();
      }
    }
  }

//! ************************<<<Doktors Sivi Ekleme >>>********************************************
  doktorSiviEkle(DoktorModel doktorModel) async {
    await users
        .collection('sivi')
        .doc(doktorModel.danTC)
        .collection('text')
        .doc(doktorModel.danTC)
        .set(DoktorModel.toMap(doktorModel));
  }

  Future<DoktorModel> doktorSiviGetir(String tc) async {
    var querySnapshot =
        await users.collection('sivi').doc(tc).collection('text').doc(tc).get();
    var data = querySnapshot.data();
    var convertData = DoktorModel.frommap(data!);
    return convertData;

    // ignore: unused_local_variable
  }

  Future<List<TestModel>> kategoriGetir(DanisanModel danisanModel) async {
    var querySnapshot = await users.collection('kategoriler').get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable
    List<TestModel> tumKullanicilar = [];
    for (var tekData in data) {
      TestModel allData = TestModel.frommap(tekData.data());

      if (allData.gonderenDrTc == danisanModel.danTC) {
        tumKullanicilar.add(allData);
      }
    }
    return tumKullanicilar;
  }

  Future<List<TestModel>> danisanKategoriGetir(
      DanisanModel danisanModel) async {
    var querySnapshot = await users.collection('danisankategoriler').get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable
    List<TestModel> tumKullanicilar = [];
    for (var tekData in data) {
      TestModel allData = TestModel.frommap(tekData.data());

      if (allData.gonderenDrTc == danisanModel.danTC) {
        tumKullanicilar.add(allData);
      }
    }
    return tumKullanicilar;
  }

  danisanTestGonder(TestModel testModel, DanisanModel danisanModel) async {
    await users
        .collection('danisankategoriler')
        .doc(danisanModel.danTC! + testModel.gonderenDrTc + testModel.kategori)
        .set(TestModel.toMap(testModel));
    //Deneme
    //Deneme
    //Deneme

    var querySnapshot = await users
        .collection('quiz')
        .doc(testModel.kategori + testModel.gonderenDrTc)
        .collection('test')
        .get();
    var data = querySnapshot.docs;

//! KİŞİYE AİT TESTİN GETİRİLMESİ
    // ignore: unused_local_variable
    List<TestModel> tumKullanicilar = [];
    for (var tekData in data) {
      TestModel testim = TestModel.frommap(tekData.data());

      await users
          .collection('users')
          .doc(danisanModel.danTC)
          .collection(testModel.kategori)
          .doc(testim.soruIdm)
          .set(TestModel.toMap(testim));
    }
  }

  danisanCevapAl(DanisanModel danisanModel, TestModel testModel) async {
    await users
        .collection('users')
        .doc(danisanModel.danTC)
        .collection(testModel.kategori)
        .doc(testModel.soruIdm)
        .set(TestModel.toMap(testModel));
  }

  Future<List<TestModel>> testGetir(
      DanisanModel danisanModel, TestModel testModel) async {
    var querySnapshot = await users
        .collection('users')
        .doc(danisanModel.danTC)
        .collection(testModel.kategori)
        .get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable
    List<TestModel> tumKullanicilar = [];
    for (var tekData in data) {
      TestModel testim = TestModel.frommap(tekData.data());
      if (testim.kategori == testModel.kategori) {
        tumKullanicilar.add(testim);
      }
    }
    return tumKullanicilar;
  }

  Future<List<TestModel>> danisanTestGetir(DanisanModel danisanModel) async {
    var querySnapshot = await users.collection('danisankategoriler').get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable
    List<TestModel> tumKullanicilar = [];
    for (var tekData in data) {
      TestModel allData = TestModel.frommap(tekData.data());

      if (allData.testCozenID == danisanModel.danTC) {
        tumKullanicilar.add(allData);
      }
    }
    return tumKullanicilar;
  }
}
