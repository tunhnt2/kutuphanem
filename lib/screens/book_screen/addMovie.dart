import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kutuphanem/model/urun.dart';

import '../../model/db.dart';
import '../utils/getImage.dart';
import '../utils/loading.dart';

class AddMovie extends StatefulWidget {
  AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final key = GlobalKey<FormState>();
  late String isim, tur, fiyat, detay;
  Urun movie = Urun();
  List<File> images = [];

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movie.type = UrunTip.movie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("film ekle"),
        backgroundColor: Colors.lightBlue,
        actions: [Icon(FontAwesomeIcons.film)],
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
                      hintText: "filmin ismi",
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
                      hintText: "filmin türü",
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
                      hintText: "filmin fiyatı",
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
                      hintText: "filmin detayları",
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
                        if(data != null) { // kamera ikonuna basıp geri geldiğimizde hata aldığımız için
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
                        color: Colors.lightBlue,
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
                        movie.isim = isim;
                        movie.tur = tur;
                        movie.fiyat = fiyat;
                        movie.detay = detay;
                        movie.images = [];
                        for (var i = 0; i < images.length; i++) {
                          String? urlImage = await DBServices()
                                .uploadImage(images[i], path: "movies");
                          if(urlImage != null) {
                            movie.images?.add(urlImage);
                          }
                          if(images.length == movie.images?.length) {
                            bool save = await DBServices().saveUrun(movie);
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
                            MaterialStateProperty.all(Colors.lightBlue)),
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
