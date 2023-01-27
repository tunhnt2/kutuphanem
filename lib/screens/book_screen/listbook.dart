import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kutuphanem/model/db.dart';
import 'package:kutuphanem/screens/book_screen/addBook.dart';
import 'package:kutuphanem/screens/book_screen/favorites.dart';
import 'package:kutuphanem/screens/utils/urunCard.dart';
import 'package:provider/provider.dart';

import '../../model/urun.dart';

class BookList extends StatefulWidget {
  BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final List<Urun> books = Provider.of<List<Urun>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kitap Listesi",
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => StreamProvider<List<Urun>>.value(
                          value: DBServices().getFavUrun,
                          initialData: [],
                          child: Favorites(),
                        )));
              }),
              icon: Icon(FontAwesomeIcons.heart))
        ],
      ),
      body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (ctx, i) {
            final book = books[i];
            return books == null
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  )
                : UrunCard(book: book);
          }),
    );
  }
}
