import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/contants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 

class SignIn extends StatefulWidget {

  final Function toggleViewFunction;
  
  SignIn({this.toggleViewFunction});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth =AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error='';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],

      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: Text('Sign in to bre crew'),
        elevation: 0.0 ,
        actions: <Widget>[
          FlatButton.icon(
            color: Colors.brown[300],
            onPressed: (){
              widget.toggleViewFunction();
            } 
            ,
            icon: Icon(
              Icons.account_circle
            ),
            label:Text('Sign-up'))
        ],

      ),
    body: Container(
      padding:EdgeInsets.symmetric(
        horizontal:50.0,
        vertical:20,
      ),
      child:Form(
        key: _formkey,
        child:Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              // initialValue:'sd@sd.lk',
              validator: (val)=>val==null? 'Enter a Email you idiot' : null,
              decoration: textInputDecoration.copyWith(hintText:'Email'),
              

              onChanged: (val){
                setState(()=> email=val);
              },
            ),
            SizedBox(
              height:20.0
            ),
            TextFormField(
              // initialValue:'123123',
              validator: (val)=>val.length<6? 'Seriously ? a password less than 7 chars?' : null,
              decoration: textInputDecoration.copyWith(hintText:'Password'),

              obscureText: true,
              onChanged:(val){
                setState(()=> password=val);
                
              }
            ),
            SizedBox(
              height:20.0
            ),
            RaisedButton(
              onPressed: () async{
                print('$email  -  $password');
                if (_formkey.currentState.validate()){
                  //show loading when loading
                  setState(()=>loading=true);
                  await Future.delayed(const Duration(seconds: 3));
                  print('from validated.Going for registering');

                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                  if (result==null ){
                    print('Problably an error... I dont know but probably an email issue');
                    //remove loading screen
                    //show the error
                    setState((){
                      error='Invalid username or password';
                      loading=false;
                      });
                  }

                }
                else{
                  print('errors are there in the form');

                }
              
              },
              child: Text(
                'Sign in',
                 style:TextStyle(
                   color: Colors.white
                  )
              ),
              color: Colors.pink[400],

            
            ),
             SizedBox(
              height:10.0
            ),
            Text(
              '$error',
              style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
              ),
            ),

            SizedBox(
              height:10.0
            ),
          Text('OR',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(
            height:20,
          ),
          
          //anon sign in
          RaisedButton(
            color: Colors.pink[50],
        child: Text('Sign in anonymously'),
        onPressed: () async {
          print('anon sign in button clicked');
          dynamic result =await _auth.signInAnon();
          print(result);
          if(result == null){
            print('user can\'t signed in ');
          }
          else{
            print('signed in');

            print(result.uid);
              }
              
            },
          ),

          ],

        )
         )
      
      
      


    ),
    );
  }
}