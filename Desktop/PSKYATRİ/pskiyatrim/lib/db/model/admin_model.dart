class AdminModel {
  String mail;
  String sifre;

  static toMap(AdminModel user) {
    Map<String, dynamic> userMap = {
      'mail': user.mail, // Stokes and Sons
      'sifre': user.sifre,
    };
    return userMap;
  }

  factory AdminModel.frommap(Map<String, dynamic> map) {
    return AdminModel(
      mail: map['mail'],
      sifre: map['sifre'],
    );
  }

  AdminModel({required this.mail, required this.sifre});
}
