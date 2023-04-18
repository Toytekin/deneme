import 'package:flutter/material.dart';
import 'package:myapp/a_Sayfalar/home/home.dart';
import 'package:myapp/a_Sayfalar/login.dart';

import '../../model/user_model.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key, required this.snapshot});

  final AsyncSnapshot<UserModel?> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.active) {
      return snapshot.hasData
          ? HomeScreen(
              context: context,
              userModel: snapshot.data!,
            )
          : LoginScreen(context: context);
    } else {
      return const ErrorPage();
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('HATA'),
      ),
    );
  }
}
