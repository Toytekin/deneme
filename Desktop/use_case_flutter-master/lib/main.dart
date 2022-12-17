import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:use_case_flutter/core/init/main_build.dart';
import 'package:use_case_flutter/product/generation/colors.gen.dart';
import 'package:use_case_flutter/use_case/global_management/provider/global_manage_provider.dart';
import 'package:use_case_flutter/use_case/special_search/special_search_view.dart';

void main() => runApp(
      Provider(
        create: (context) => GlobalManagerProvider(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      builder: MainBuild.build,
      theme: ThemeData.light().copyWith(
        errorColor: ColorName.orange,
      ),
      home: const SpecialSearchView(),
    );
  }
}