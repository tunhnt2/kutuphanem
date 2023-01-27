import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kutuphanem/model/db.dart';
import 'package:kutuphanem/model/user.dart';
import 'package:kutuphanem/screens/book_screen/addBook.dart';
import 'package:kutuphanem/screens/book_screen/addMovie.dart';
import 'package:kutuphanem/screens/book_screen/listbook.dart';
import 'package:kutuphanem/screens/book_screen/listmovie.dart';
import 'package:kutuphanem/screens/menu.dart';
import 'package:kutuphanem/screens/utils/constant.dart';
import 'package:kutuphanem/screens/utils/sliders.dart';
import 'package:provider/provider.dart';

import '../model/urun.dart';
import '../services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  UserModel? userm;
  AuthServices auth = AuthServices();

  List imgs = [];
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 250));
    final curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animation = Tween<double>(begin: 0, end: 1).animate(curve);
  }

  get getCarouselImage async {
    final img = await DBServices().getCarouselImage;
    print(img);
    setState(() {
      imgs = img!;
    });
  }

  Future<void> getUser() async {
    final user = await auth.user;
    final userResult = await DBServices().getUser(user!.uid);
    setState(() {
      userm = userResult;
      UserModel.current = userResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    getCarouselImage;
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await myDialog(context, ok: () async { // burada showDiaiog'u extract ettim
                                await auth.signOut();
                                setState(() {});
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pop(); // neden iki kere yapmak zorunda kalıyorum bir kodda tek seferde çıkış yapabiliyordu??????????
                              }, title: "çıkış yap", content: "çıkış yapmak istiyor musun?");
                },
                icon: Icon(FontAwesomeIcons.powerOff),
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Sliders(imgs: imgs), // Slider extract ettim
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => StreamProvider<List<Urun>?>.value(
                              value: DBServices().getUrun,
                              initialData: null,
                              child: BookList(),
                            )));
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.green,
                    child: Icon(
                      FontAwesomeIcons.book,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => StreamProvider<List<Urun>?>.value(
                              value: DBServices().getUrun,
                              initialData: null,
                              child: MovieList(),
                            )));
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.lightBlue,
                    child: Icon(
                      FontAwesomeIcons.film,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionBubble(
        backGroundColor: Colors.lightBlue,
        items: [
          Bubble(
              title: "kitap",
              titleStyle: style.copyWith(fontSize: 16, color: Colors.white),
              iconColor: Colors.white,
              bubbleColor: Colors.green,
              icon: FontAwesomeIcons.book,
              onPress: () {
                _animationController.reverse();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => AddBook()));
              }),
          Bubble(
              title: "film",
              titleStyle: style.copyWith(fontSize: 16, color: Colors.white),
              iconColor: Colors.white,
              bubbleColor: Colors.lightBlue,
              icon: FontAwesomeIcons.film,
              onPress: () {
                _animationController.reverse();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => AddMovie()));
              })
        ],
        onPress: _animationController.isCompleted
            ? _animationController.reverse
            : _animationController.forward,
        animation: _animation,
        iconColor: Colors.white,
        animatedIconData: AnimatedIcons.add_event,
      ),
    );
  }
}
