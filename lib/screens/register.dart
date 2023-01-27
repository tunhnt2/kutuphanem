import 'package:flutter/material.dart';
import 'package:kutuphanem/screens/utils/constant.dart';
import 'package:kutuphanem/screens/utils/loading.dart';
import 'package:kutuphanem/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthServices auth = AuthServices();
  String? email, password, confirmPassword, userName;
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView( 
            child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: keys,
            child: Column(
              children: [
                Text(
                  "Kayıt  Ol",
                  style: style,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (e) => userName = e,
                  validator: (e) => e!.isEmpty ? "Boş bırakılamaz!" : null,
                  decoration: InputDecoration(
                      hintText: "kullanıcı adınız", labelText: "Username"),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (e) => email = e,
                  validator: (e) => e!.isEmpty ? "Boş bırakılamaz!" : null,
                  decoration: InputDecoration(
                      hintText: "email adresiniz", labelText: "Email"),
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (e) => password = e,
                  validator: (e) => e!.isEmpty
                      ? "Boş bırakılamaz!"
                      : e.length < 6
                          ? "şifre uzunluğu 6 karakterden fazla olmalıdır!"
                          : null,
                  decoration: InputDecoration(
                      hintText: "*******", labelText: "Password"),
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (e) => confirmPassword = e,
                  validator: (e) => e!.isEmpty
                      ? "Boş bırakılamaz!"
                      : e.length < 6
                          ? "şifre uzunluğu 6 karakterden fazla olmalıdır!"
                          : null,
                  decoration: InputDecoration(
                      hintText: "*******", labelText: " Password Confirmation"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (keys.currentState!.validate()) {
                        laoding(context);
                        print(email! + " " + password!);
                        bool? register = await auth.signup(email!, password!, userName!);
                        if(register != null) {
                          Navigator.of(context).pop();
                          if (!register) Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text("Kayıt Ol")),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
