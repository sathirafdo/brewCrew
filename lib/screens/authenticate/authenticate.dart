import 'package:brewcrew/screens/authenticate/register.dart';
import 'package:brewcrew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn=true;

  @override
  Widget build(BuildContext context) {


    void toggleView(){
      setState((){
        showSignIn = !showSignIn;
        }
        );
    }

      if (showSignIn){
        print('Switched to sign in');
        
        return SignIn(toggleViewFunction:toggleView);
      }
      else{
        print('Switched to register');
        return Register(toggleViewFunction:toggleView);
      }
      

  }
}