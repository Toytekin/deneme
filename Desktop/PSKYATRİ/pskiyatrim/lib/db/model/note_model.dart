class NoteModel {
  String noteID;
  String drTC;
  String danisanTC;
  String noteBasligi;
  String note;

  NoteModel(
      {required this.noteID,
      required this.drTC,
      required this.danisanTC,
      required this.noteBasligi,
      required this.note});

  static Map<String, dynamic> toMap(NoteModel noteModel) {
    Map<String, dynamic> noteMap = {
      "noteID": noteModel.noteID,
      "drTC": noteModel.drTC,
      "danisanTC": noteModel.danisanTC,
      "noteBasligi": noteModel.noteBasligi,
      "note": noteModel.note,
    };
    return noteMap;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      noteID: map['noteID'],
      drTC: map['drTC'],
      danisanTC: map['danisanTC'],
      noteBasligi: map['noteBasligi'],
      note: map['note'],
    );
  }
}
