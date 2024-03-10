import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_formation/accueil.dart';
// import 'package:projet_formation/app_constant.dart';
import 'package:projet_formation/configration.dart';
import 'package:projet_formation/input_screen.dart';
import 'package:projet_formation/my_button.dart';

class login extends StatelessWidget {
  TextEditingController email= TextEditingController();
  TextEditingController password = TextEditingController();
  signIn(emailAddress, password, context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      if (credential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {  
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:  Text('Mauvais mot de passe fourni pour cet utilisateur.'),
        ));
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Container(
        margin: EdgeInsets.all(5),
        color: Color.fromARGB(209, 221, 218, 218),
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: AppBar().preferredSize.height * 2),
            Align(
              alignment: AlignmentDirectional.center,
              child: Icon(
                Icons.lock,size: 100,color: Colors.blue,
                 
              ),
            ),
            SizedBox(height: fullHeight(context) * 0.06),
            
            SizedBox(height: fullHeight(context) * 0.04),
            MyTextFiled(hint: 'Email', textEditingController: email,),
            SizedBox(height: fullHeight(context) * 0.02),
            MyTextFiled(hint: 'Password',   textEditingController:password,),
            SizedBox(height: fullHeight(context) * 0.01),
            Align(
                alignment: AlignmentDirectional.topEnd,
                 
                     ),
            SizedBox(height: fullHeight(context) * 0.04),
             MyBoutton(onPressed: () {
              print("******************");
            
              signIn(email.text,password.text,context);

            }, title: 'Se connecter'),
            SizedBox(height: fullHeight(context) * 0.09),
            Center(
     ),
          ],
        ),
      ),
      ));
  }
}