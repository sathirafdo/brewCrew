import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/authenticate/authenticate.dart';
import 'package:brewcrew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
   
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ;

    print('yo yo in the wrapper.  user id ${user==null ? null : user.uid}');

    //return home or authenticate
    if(user==null){
      print('You arent even logged in now.Whats thehold up ?? log in!!! -wraper');
      
      return Authenticate();
    }
    else{
      print('you are a user welcome -wrapper');
      return Home();
    }
  }
}