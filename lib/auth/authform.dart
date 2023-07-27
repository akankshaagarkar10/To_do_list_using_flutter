// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class AuthForm extends StatefulWidget{
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //---------------------------------------------------------//
   final _formkey = GlobalKey<FormState>();
   var _email ='';
   var _password='';
   var _username='';
   bool isLoginPage = false;

  //--------------------------------------------------------//

   startauthentication(){
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(validity){
      _formkey.currentState?.save();
      submitform(_email,_password,_username);
    }
   }

   submitform(String email, String password, String username)async{
    final auth=FirebaseAuth.instance;
    UserCredential authResult;
    // AuthResult authResult;
    try{
      if(isLoginPage){
        authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else{
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username':username,
          'email':email
        });
      }
    } 
     on PlatformException catch (err) {
      var message = 'An error occured';
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
     }
    catch(err){
      print(err);
    }

   }


  //--------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          // Container(height:200,
          // child: Image.asset('assets/todo.png'),),
          Container(
            padding: EdgeInsets.only(left:10, right: 10, top: 10),
            child:Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(!isLoginPage)
//----------------------------textform field for email-----------------------------------------//
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('email'),
                    validator: (value){
                      if(value!.isEmpty || !value.contains('@')){
                        return 'Incorrect Email';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _email = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide()),
                        labelText: "Enter Email",
                      ),
                  ),
                   SizedBox(height:10),

//----------------------------textform field for email-----------------------------------------//


//--------------------------textformfield for password-------------------------------------------//
                   TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('password'),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Incorrect Password';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _password = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide()),
                        labelText: "Enter Password",
                      ),
                  ),
                   SizedBox(height:10),
//--------------------------textformfield for password-------------------------------------------//

//----------------------------textform field for username-----------------------------------------//
                     TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('username'),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Incorrect username';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _username = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide()),
                        labelText: "Enter Username",
                      ),
                  ),                 
//----------------------------textform field for username-----------------------------------------//
                   SizedBox(height:10), 
                  Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height:70,
                    child: MaterialButton(
                      child: isLoginPage? Text('Login',
                      style: TextStyle(fontFamily:'RobotoMono', fontSize: 16 ),)
                      :Text('SignUp', style: TextStyle(fontFamily:'RobotoMono', fontSize: 16 ),),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.
                        circular(10)),
                      color: Theme.of(context).
                      primaryColor,
                      onPressed:(){
                        startauthentication();
                      }) ),
                      SizedBox(height:10),
                      Container(child: TextButton(onPressed: (){
                        
                        setState((){
                          isLoginPage=!isLoginPage;

                        });
                      },child: isLoginPage
                      ?Text('Not a Member?', style:TextStyle(fontFamily:'RobotoMono', fontSize: 16 , color:Colors.white),)
                      : Text('Already a Member', style:TextStyle(fontFamily:'RobotoMono', fontSize: 16 , color:Colors.white))),)  
                ],
              ),
            ))
          ],
        ));
  }
}