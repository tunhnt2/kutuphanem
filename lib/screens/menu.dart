import 'package:flutter/material.dart';
import 'package:kutuphanem/model/db.dart';
import 'package:kutuphanem/model/user.dart';
import 'package:kutuphanem/screens/utils/getImage.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = UserModel.current;
    return Container(
      color: Colors.white,
      width: 250,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user!.userName ?? "yok"),
            accountEmail: Text(user.email ?? "yok"),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:
                    user.image != null ? NetworkImage(user.image!) : null,
                child: Stack(
                  children: [
                    if (user.image == null)
                      Center(
                          child: Icon(
                        Icons.person,
                        color: Colors.black,
                      )),
                    if (loading)
                      Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                    Positioned(
                      top: 38,
                      left: 13,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                        ),
                        onPressed: () async {
                          final data = await showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return GetImage();
                              });
                          if (data != null) {
                            loading = true;
                            setState(() {});
                            String? urlImage = await DBServices()
                                .uploadImage(data, path: "profil");
                            if (urlImage != null) {
                              UserModel.current?.image = urlImage;
                              bool isupdate = await DBServices()
                                  .updateUser(UserModel.current as UserModel);
                              if (isupdate) {
                                loading = false;
                                setState(() {});
                              }
                            }
                          }
                        },
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
