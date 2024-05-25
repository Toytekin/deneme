import 'package:ads/core/constant/textstyle.dart';
import 'package:ads/core/models/hoca_model.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:flutter/material.dart';

class AkademiisyenBuilder extends StatelessWidget {
  final UserModel item;
  const AkademiisyenBuilder({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            //AD
            Text(
              item.userName,
              style: SbtTextStyle().normalStyleBold,
            ),
            //Uzmanlık Alanı
            Text(
              item.ogrnciBolum,
              style: SbtTextStyle().midumStyle,
            ),
            //Mail
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(item.userMail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
