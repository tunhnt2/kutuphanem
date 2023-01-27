import 'package:firebase_auth/firebase_auth.dart';
import 'package:kutuphanem/model/db.dart';
import 'package:kutuphanem/model/user.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signinAnonimous() async {
    try {
      final result = await auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> get user async{
    final user = await FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<bool?> signup(String email, String password, String userName) async{
    try {
      final result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if(result.user != null) {
        await DBServices().saveUser(UserModel(id: result.user?.uid, email: email, userName: userName));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

Future<bool?> signin(String email, String password) async{
    try {
      final result = await auth.signInWithEmailAndPassword(email: email, password: password);
      if(result.user != null) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
  Future signOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      return null;
    }
  }
}