import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kutuphanem/screens/utils/urunCard.dart';
import 'package:provider/provider.dart';
import '../../model/db.dart';
import '../../model/urun.dart';
import 'favorites.dart';
import 'package:kutuphanem/screens/book_screen/addMovie.dart';

class MovieList extends StatefulWidget {
  MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    final List<Urun> movies = Provider.of<List<Urun>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Film Listesi"),
        backgroundColor: Colors.lightBlue,
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
          itemCount: movies.length,
          itemBuilder: (ctx, i) {
            final movie = movies[i];
            return movies == null
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  )
                : UrunCard(
                    book: movie,
                    type: UrunTip.movie,
                  );
          }),
    );
  }
}
