import 'package:flutter/material.dart';
import 'package:haritaapp/a_sayfalar/patron/gidilecek_yerler.dart';
import 'package:hive/hive.dart';

import '../../model/user.dart';

class PatronHomeScreen extends StatefulWidget {
  double lat;
  double lan;
  PatronHomeScreen({super.key, required this.lan, required this.lat});

  @override
  State<PatronHomeScreen> createState() => _PatronHomeScreenState();
}

class _PatronHomeScreenState extends State<PatronHomeScreen> {
  // ignore: non_constant_identifier_names
  final String api_key = 'AIzaSyCXLzd9Wt1o_7bulhqUYA8S_SWi6mmclAU';

  @override
  void initState() {
    super.initState();

    kisileriGetir();
  }

  List<User> allUser = [];

  var userBox = Hive.box<User>('kisiDB');
  void kisileriGetir() {
    for (var element in userBox.values) {
      allUser.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Home'),
        ),
        body: allUser.isNotEmpty
            ? ListView.builder(
                itemCount: allUser.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GidilecekYerler(
                          lan: widget.lan,
                          lat: widget.lat,
                          userkey: index,
                          user: allUser[index],
                        ),
                      ));
                    },
                    title: Text(allUser[index].name),
                    subtitle: index == 0
                        ? Text('Enlem : ${widget.lat}- Boylam : ${widget.lan}')
                        : null,
                  ));
                },
              )
            : Container());
  }
}
