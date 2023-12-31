import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/auth/authscreen.dart';
import 'package:to_do_list/screens/home.dart';
import 'dart:ui';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, usersnapshot){
        if(usersnapshot.hasData){
          return Home();
        }
        else{
          return AuthScreen();
        }
      }, ),
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(brightness: Brightness.dark,
      primaryColor:Colors.purple),
    );
    
  }
}

