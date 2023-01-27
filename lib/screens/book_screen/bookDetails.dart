import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kutuphanem/screens/utils/sliders.dart';

import '../../model/urun.dart';
import '../utils/constant.dart';

class BookDetail extends StatelessWidget {
  BookDetail({Key? key, required this.urun, this.color = Colors.green})
      : super(key: key);

  final Urun urun;
  Color color;

  @override
  Widget build(BuildContext context) {
    color = urun.type == UrunTip.book ? Colors.green : Colors.lightBlue;
    IconData icon = urun.type == UrunTip.book ? FontAwesomeIcons.book : FontAwesomeIcons.film;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(urun.isim.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Sliders(imgs: urun.images as List<dynamic>),
          SizedBox(height: 10,),
               Divider(color:Colors.black), // flutterda bug buldum amk
          item(urun.isim.toString(), icon),
             Divider(color:Colors.black),
          item(urun.tur.toString(), icon),
             Divider(color:Colors.black),
          item(urun.fiyat.toString() + "TL", icon),
             Divider(color:Colors.black),
          item(urun.detay.toString(), icon),
             Divider(color:Colors.black),
       
          ],
        ),
      ),
    );
  }


  // extract yaptığım 
  ListTile item(String title,IconData icon) {
    return ListTile(
          leading: Icon(icon, color: color,),
          title: Text(title, style: style.copyWith(fontSize: 20),),
        );
  }
}
