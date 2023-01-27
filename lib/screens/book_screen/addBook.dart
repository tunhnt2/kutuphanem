import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kutuphanem/model/urun.dart';
import 'package:kutuphanem/screens/utils/loading.dart';

import '../../model/db.dart';
import '../utils/getImage.dart';

class AddBook extends StatefulWidget {
  AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final key = GlobalKey<FormState>();
  late String isim, tur, fiyat, detay;
  Urun book = Urun();
  List<File> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    book.type = UrunTip.book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("kitap ekle"),
        backgroundColor: Colors.green,
        actions: [Icon(FontAwesomeIcons.book)],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (e) => e!.isEmpty ? "bu alanı doldurun" : null,
                  onChanged: (e) => isim = e,
                  decoration: InputDecoration(
                      hintText: "kitabın ismi",
                      labelText: "isim",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (e) => e!.isEmpty ? "bu alanı doldurun" : null,
                  onChanged: (e) => tur = e,
                  decoration: InputDecoration(
                      hintText: "kitabın türü",
                      labelText: "tür",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (e) => e!.isEmpty ? "bu alanı doldurun" : null,
                  onChanged: (e) => fiyat = e,
                  decoration: InputDecoration(
                      hintText: "kitabın fiyatı",
                      labelText: "fiyat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (e) => e!.isEmpty ? "bu alanı doldurun" : null,
                  onChanged: (e) => detay = e,
                  maxLines: 5,
                  decoration: InputDecoration(
                      // kitap detayları ortada gözüküyor daha sonra buna bak
                      hintText: "kitabın detayları",
                      labelText: "detay",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: [
                    for (int i = 0; i < images.length; i++)
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.4)),
                          margin: EdgeInsets.only(right: 3, bottom: 5),
                          height: 70,
                          width: 70,
                          child: Stack(
                            children: [
                              Image.file(images[i]),
                              Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(FontAwesomeIcons.circleMinus,
                                      color: Colors.white),
                                  onPressed: () {
                                    // burada remove yerine removeAt kullanımı
                                    setState(() {
                                      images.removeAt(i);
                                    });
                                  },
                                ),
                              )
                            ],
                          )),
                    InkWell(
                      onTap: () async {
                        final data = await showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return GetImage();
                            });
                        if (data != null) {
                          // kamera ikonuna basıp geri geldiğimizde hata aldığımız için
                          setState(() {
                            images.add(data);
                          });
                        }
                      },
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.circlePlus,
                          color: Colors.white,
                        ),
                        color: Colors.green,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () async{
                      if (key.currentState!.validate() && images.length > 0) {
                        laoding(context);
                        book.isim = isim;
                        book.tur = tur;
                        book.fiyat = fiyat;
                        book.detay = detay;
                        book.uid = FirebaseAuth.instance.currentUser!.uid;
                        book.images = [];
                        for (var i = 0; i < images.length; i++) {
                          String? urlImage = await DBServices()
                                .uploadImage(images[i], path: "books");
                          if(urlImage != null) {
                            book.images?.add(urlImage);
                          }
                          if(images.length == book.images?.length) {
                            bool save = await DBServices().saveUrun(book);
                            if(save) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          }
                         }
                      } else {
                        print("lütfen tüm alanları doldurun");
                      }
                    },
                    child: Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
