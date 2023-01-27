import 'package:flutter/material.dart';
import 'package:kutuphanem/screens/home.dart';
import 'package:kutuphanem/screens/register.dart';
import 'package:kutuphanem/screens/utils/constant.dart';
import 'package:kutuphanem/screens/utils/loading.dart';
import 'package:kutuphanem/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthServices auth = AuthServices();
  String? email, password;
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: keys,
                child: Column(
              children: [
                Text(
                  "Giriş",
                  style: style,
                ),
                SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (e) => email = e,
                    validator: (e) => e!.isEmpty?"Boş bırakılamaz!":null,
                    decoration: InputDecoration(
                      hintText: "email adresiniz",
                      labelText: "Email" 
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (e) => password = e,
                    validator: (e) => e!.isEmpty?"Boş bırakılamaz!":e.length<6?"şifre uzunluğu 6 karakterden fazla olmalıdır!" : null,
                    decoration: InputDecoration(
                      hintText: "*******",
                      labelText: "Password" 
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: () async{
                    if(keys.currentState!.validate()) {
                      laoding(context);
                      print(email! + " " + password!);
                      bool? login = await auth.signin(email!, password!);
                      if(login != null) {
                        Navigator.of(context).pop();
                        if(!login) print("email veya sifre hatali");
                        else Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                      }
                    }
                  }, child: Text("Giriş Yap")),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hesabın yok mu?"),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => RegisterPage()));
                      },
                      child: Text(
                        "Kayıt Ol",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Colors.red.withOpacity(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            ),
                            side: BorderSide(color: Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
        ),
      )),
    );
  }
}
