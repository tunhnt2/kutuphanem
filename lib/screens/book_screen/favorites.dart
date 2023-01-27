import 'package:flutter/material.dart';
import 'package:kutuphanem/model/urun.dart';
import 'package:provider/provider.dart';

import '../utils/urunCard.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final List<Urun> books = Provider.of<List<Urun>>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Favorilerim"),
      ),
      body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (ctx, i) {
            final book = books[i];
            return books == null ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ) : UrunCard(book: book) ;
          }),
    );
  }
}