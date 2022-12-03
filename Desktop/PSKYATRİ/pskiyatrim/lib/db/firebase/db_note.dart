import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/note_model.dart';

class DbNote {
  FirebaseFirestore users = FirebaseFirestore.instance;

//? ************************<<  K A Y D E  T  >>************************************
  // ignore: non_constant_identifier_names
  DbNoteEkle(NoteModel noteModel, DanisanModel danisanModel) async {
    await users
        .collection('users')
        .doc(danisanModel.danTC)
        .collection('note')
        .doc(noteModel.noteID)
        .set(NoteModel.toMap(noteModel));
  }

//? ************************<< G E T İ  R M E >>************************************
  Future<List<NoteModel>> notlariGetir(
    DanisanModel danisanModel,
  ) async {
    // Sorgu alanı
    var querySnapshot = await users
        .collection('users')
        .doc(danisanModel.danTC)
        .collection('note')
        .get();
    var data = querySnapshot.docs;

    // ignore: unused_local_variable
    List<NoteModel> tumNotlar = [];
    for (var tekData in data) {
      NoteModel testim = NoteModel.fromMap(tekData.data());

      tumNotlar.add(testim);
    }
    return tumNotlar;
  }

//? *********************<< S İ L M E >>***************************************

  noteSil(DanisanModel danisanModel, NoteModel noteModel) async {
    await users
        .collection('users')
        .doc(danisanModel.danTC)
        .collection('note')
        .doc(noteModel.noteID)
        .delete();
  }
}
