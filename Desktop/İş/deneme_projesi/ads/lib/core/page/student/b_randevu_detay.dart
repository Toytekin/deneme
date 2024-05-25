import 'package:ads/core/constant/secilen_akademiisyen.dart';
import 'package:ads/core/constant/text_field.dart';
import 'package:ads/core/constant/textstyle.dart';
import 'package:ads/core/models/randevumodel.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/page/student/giris_ogrenci.dart';
import 'package:ads/core/services/randevu_save.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

class RandevuOlustur extends StatefulWidget {
  final UserModel userModel;
  final UserModel userModelAkademisyen;
  const RandevuOlustur({
    super.key,
    required this.userModel,
    required this.userModelAkademisyen,
  });

  @override
  State<RandevuOlustur> createState() => _RandevuOlusturState();
}

class _RandevuOlusturState extends State<RandevuOlustur> {
  var titleController = TextEditingController();
  var mesajController = TextEditingController();

  var saveRandevu = FrRandevuSave();

  DateTime selectedDate = DateTime.now();
  String? selectedOption = '0';
  void onOptionChanged(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _tarihFormatlama(DateTime date) {
    String formattedDate = DateFormat('dd.MM.yyyy').format(date);
    return formattedDate;
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
            child: SingleChildScrollView(
          child: Column(
            children: [
              SecilenAkad(userName: widget.userModelAkademisyen.userName),
              SbtTextField(controller: titleController, label: 'Başlık'),
              SbtTextFieldMesaj(
                controller: mesajController,
                label: 'Mesaj',
                icon: const Icon(Icons.message),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Randevu tarihi : ',
                    style: SbtTextStyle().midumStyle,
                  ),
                  Text(
                    _tarihFormatlama(selectedDate),
                    style: SbtTextStyle().midumStyleBold,
                  ),
                  IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(
                      Icons.date_range,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ListTile(
                title: const Text('Online Görüşme'),
                leading: Radio<String>(
                  value: '1',
                  groupValue: selectedOption,
                  onChanged: onOptionChanged,
                ),
              ),
              ListTile(
                title: const Text('Yüzyüze Görüşme'),
                leading: Radio<String>(
                  value: '0',
                  groupValue: selectedOption,
                  onChanged: onOptionChanged,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        mesajController.text.isNotEmpty) {
                      //id oluşturma paketinden geliyor. UUİD
                      var id = const Uuid().v1();

                      var randevuModel = RandevuModel(
                          ogrenciMail: widget.userModel.userMail,
                          ogrenciName: widget.userModel.userName,
                          akademisyenName: widget.userModelAkademisyen.userName,
                          randevuID: id,
                          ogrenciID: widget.userModel.userID,
                          akademisyenID: widget.userModelAkademisyen.userID,
                          tarih: _tarihFormatlama(selectedDate),
                          baslik: titleController.text,
                          gorusmeTuru: int.parse(selectedOption!),
                          mesaj: mesajController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OgrenciGiris(userModel: widget.userModel)),
                      );
                      await saveRandevu.randevuEkle(randevuModel);
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message:
                              "Tüm alanların dolu olduğuna emin olduktan sonra tekrar dene.",
                        ),
                      );
                    }
                  },
                  child: const Text('Kaydet'))
            ],
          ),
        )),
      ),
    );
  }
}
