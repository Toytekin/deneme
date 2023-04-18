import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:myapp/a_Sayfalar/login.dart';
import 'package:myapp/constant/snacbar.dart';
import 'package:myapp/widget/textfild.dart';
import 'package:provider/provider.dart';

import '../repo/login/repo_login.dart';

class SifremiUnuttumScreen extends StatelessWidget {
  const SifremiUnuttumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<MyLoginServices>(context, listen: false);

    var mailController = TextEditingController();
    const String text = 'Doğrulama göndereceğimiz mailinizi girin';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(context: context),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SbtTextFild(textEditingController: mailController, hintText: text),
            const SizedBox(height: 30),
            AnimatedButton(
              onPress: () async {
                await authProvider.resetPassword(mailController.text);
                mailController.clear();
                // ignore: use_build_context_synchronously
                SbtSnacbar.snacBarSucces(context, 'Mailinizi kontrol Ediniz');
              },
              height: Get.width / 6,
              width: Get.width / 3,
              text: 'Gönder',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.BOTTOM_CENTER_ROUNDER,
              backgroundColor: Colors.black,
              borderColor: Colors.white,
              borderWidth: 1,
            ),
          ],
        ),
      ),
    );
  }
}
