import 'dart:io';
import 'package:kutuphanem/model/urun.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kutuphanem/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DBServices {
  final CollectionReference usercol = 
      FirebaseFirestore.instance.collection("users");
    
  final CollectionReference carouselcol = 
      FirebaseFirestore.instance.collection("carousel");

      final CollectionReference uruncol = 
      FirebaseFirestore.instance.collection("urun");

  Future saveUser(UserModel user) async{
    try {
      await usercol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUser(String id) async{
    try {
      final data = await usercol.doc(id).get();
      final data2 = data.data() as Map<String, dynamic>;
      final user = UserModel.fromJson(data2);
      return user;
    } catch (e) {
      return false;
    }
  }

  Future updateUser(UserModel user) async{
    try {
        await usercol.doc(user.id).update(
        user.toMap()
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> uploadImage(File file, {String? path}) async{
    FirebaseStorage storage = FirebaseStorage.instance;
    var time = DateTime.now().toString();
    var ext = Path.basename(file.path).split(".")[1].toString();
    String image = path! + "_" + time + "." +ext;
    try {
       Reference ref = storage.ref().child(path + "/" + image);
       UploadTask upload = ref.putFile(file);
       TaskSnapshot taskSnapshot = await upload;
       return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<List?> get getCarouselImage async{
    try {
      final data = await carouselcol.doc("4KEaoACA7UJ4eq8sszTY").get();
      
      return (data.data() as Map)["imgs"]; // data.data()["imgs"] hata veriyordu map yapınca düzeldi neden??
    } catch (e) {
      return null;
    }
  }

  Future saveUrun(Urun book) async{
    try {
      await uruncol.doc().set(book.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future updateUrun(Urun book) async{
    try {
      await uruncol.doc(book.id).update(book.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteUrun(String id) async{
    try {
      await uruncol.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }



  Stream<List<Urun>>? get getUrun {
    return uruncol.snapshots().map((urun) {
            return urun.docs
              .map((e) => Urun.fromJson(e.data() as Map<String,dynamic>, id: e.id)).toList();});
    }

  Stream<List<Urun>>? get getFavUrun {
    final user = FirebaseAuth.instance.currentUser;
    return uruncol.where("favorites", arrayContains: user!.uid).snapshots().map((urun) {
            return urun.docs
              .map((e) => Urun.fromJson(e.data() as Map<String,dynamic>, id: e.id)).toList();});
    }
}

