import 'package:flutter/material.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/repo/login/repo_login.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({super.key, required this.onPageBuilder});

  final Widget Function(
      BuildContext context, AsyncSnapshot<UserModel?> snapshot) onPageBuilder;

  @override
  Widget build(BuildContext context) {
    //? SINIFLARIMIZA ULAŞACAĞIMIZ BAĞLANTI
    final authServices = Provider.of<MyLoginServices>(context, listen: false);

    return StreamBuilder<UserModel?>(
      stream: authServices.screeChance,
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        final userData = snapshot.data;
        if (userData != null) {
          return MultiProvider(
            providers: [Provider.value(value: userData)],
            child: onPageBuilder(context, snapshot),
          );
        } else {
          return onPageBuilder(context, snapshot);
        }
      },
    );
  }
}
