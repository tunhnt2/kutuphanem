import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kutuphanem/model/db.dart';
import 'package:kutuphanem/screens/book_screen/bookDetails.dart';
import 'package:kutuphanem/screens/utils/constant.dart';
import 'package:kutuphanem/screens/utils/loading.dart';

import '../../model/urun.dart';

class UrunCard extends StatelessWidget {
  UrunCard({Key? key, required this.book, this.type = UrunTip.book})
      : super(key: key);
  Urun book;
  UrunTip type;
  Icon favIcon = Icon(
                          Icons.favorite,
                          size: 20,
                        );

  @override
  Widget build(BuildContext context) {
    final useruid =FirebaseAuth.instance.currentUser!.uid;
    if (type == UrunTip.book) {
      if(book.favorites!.contains(useruid)) {
        favIcon = Icon(
                          FontAwesomeIcons.solidHeart,
                          size: 20,
                          color: Colors.red,
                        );
      } else {
        favIcon = Icon(
                          FontAwesomeIcons.heart,
                          size: 20,
                          color: Colors.grey,
                        );
      }
      return book.type == UrunTip.book
          ? Card(
            shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => BookDetail(urun: book)));
                },
                subtitle: Text(book.isim.toString()),
                leading: Container(
                  child: Image(
                    height: 70,
                    width: 50,
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(book.images!.first),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        myDialog(
                          context,
                          title: book.isim.toString() + " sileceksiniz",
                          content:
                              "gerçekten silmek istediğinize emin misiniz? ",
                          ok: () async {
                            laoding(context);
                            bool delete = await DBServices()
                                .deleteUrun(book.id.toString());
                            if (delete != null) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          },
                        );
                      },
                    ),Positioned(
                      top: 55,
                      right: 20,
                      child: IconButton(
                        icon: favIcon,
                        onPressed: () async{
                          if(book.favorites!.contains(useruid)) 
                            book.favorites!.remove(useruid);
                          else 
                            book.favorites!.add(useruid);
                          await DBServices().updateUrun(book);
                        },
                      ),
                    ),
                  ],
                ),
                title: Text(book.tur.toString()),
              ),
            )
          : Container();
    } else {
      if(book.favorites!.contains(useruid)) {
        favIcon = Icon(
                          FontAwesomeIcons.solidHeart,
                          size: 20,
                          color: Colors.red,
                        );
      } else {
        favIcon = Icon(
                          FontAwesomeIcons.heart,
                          size: 20,
                          color: Colors.grey,
                        );
      }
      return book.type == UrunTip.movie
          ? Card(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue)),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => BookDetail(urun: book)));
                },
                subtitle: Text(book.isim.toString()),
                leading: Container(
                  child: Image(
                    height: 70,
                    width: 50,
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(book.images!.first),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        myDialog(
                          context,
                          title: book.isim.toString() + " sileceksiniz",
                          content:
                              "gerçekten silmek istediğinize emin misiniz? ",
                          ok: () async {
                            laoding(context);
                            bool delete = await DBServices()
                                .deleteUrun(book.id.toString());
                            if (delete != null) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          },
                        );
                      },
                    ),Positioned(
                      top: 55,
                      right: 20,
                      child: IconButton(
                        icon: favIcon,
                        onPressed: () async{
                          if(book.favorites!.contains(useruid)) 
                            book.favorites!.remove(useruid);
                          else 
                            book.favorites!.add(useruid);
                          await DBServices().updateUrun(book);
                        },
                      ),
                    ),
                  ],
                ),
                title: Text(book.tur.toString()),
              ),
            )
          : Container();
    }
  }
}
