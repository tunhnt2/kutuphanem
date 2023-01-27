import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kutuphanem/screens/home.dart';
import 'package:kutuphanem/screens/login.dart';
import 'package:kutuphanem/services/auth.dart';

class Statut extends StatefulWidget {
  Statut({Key? key}) : super(key: key);

  @override
  State<Statut> createState() => _StatutState();
}

class _StatutState extends State<Statut> {

  User? user;
  AuthServices auth = AuthServices();

  late Future<bool> initFun;

  Future<bool> getUser() async {
    Future.delayed(Duration(seconds: 3));
    final userResult = await auth.user;
    print("getuser...");
    return userResult == null ? false : true;
  }

  @override
  void initState() {
    super.initState();
    initFun = getUser();
    
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder<bool>(
        future: initFun,
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data! ? HomePage() : LoginPage();
      },),
    );

  }
}