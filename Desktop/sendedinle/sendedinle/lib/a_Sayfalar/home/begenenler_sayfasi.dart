import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/repo/post/post_db.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BegenenlerSayfasi extends StatefulWidget {
  String postID;
  BegenenlerSayfasi({super.key, required this.postID});

  @override
  State<BegenenlerSayfasi> createState() => _BegenenlerSayfasiState();
}

class _BegenenlerSayfasiState extends State<BegenenlerSayfasi> {
  List<UserModel> allUsers = [];

  @override
  void initState() {
    super.initState();
    begenenleriGetir();
  }

  Future<void> begenenleriGetir() async {
    var db = Provider.of<PostDB>(context, listen: false);
    List<UserModel> gelenUserList = await db.tumBegenileriGetir(widget.postID);
    if (gelenUserList.isNotEmpty) {
      allUsers = gelenUserList;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: allUsers.isEmpty
            ? const Center(
                child: Text('Henüz Beğenen Yok'),
              )
            : ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  var tekData = allUsers[index];
                  return Card(
                    child: ListTile(
                      leading: CircularProfileAvatar(
                        '',
                        cacheImage: true,
                        imageFit: BoxFit.cover,
                        borderColor: Colors.black,
                        borderWidth: 0.1,
                        elevation: 3,
                        radius: 25,
                        child: Image.network(
                          tekData.photoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(tekData.name),
                      subtitle: Text(tekData.mail),
                    ),
                  );
                },
              ));
  }
}
