import 'package:flutter/material.dart';
import 'package:to_do_list/auth/authform.dart';

class AuthScreen  extends StatefulWidget{
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('Authentication'),backgroundColor:Colors.purple ,),
      body: AuthForm(),
    );
  }
}

