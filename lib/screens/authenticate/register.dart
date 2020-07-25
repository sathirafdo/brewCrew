import 'package:brewcrew/shared/contants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleViewFunction;

  Register({this.toggleViewFunction});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final AuthService _auth =AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: Text('Sign up in to bre crew'),
        elevation: 0.0 ,
        actions: <Widget>[
          FlatButton.icon(
            color: Colors.brown[300],
            onPressed: (){
              widget.toggleViewFunction();
            },

            icon: Icon(
              Icons.account_circle
            ),
            label:Text('Sign-in'))
        ],

      ),
    body: Container(
      padding:EdgeInsets.symmetric(
        horizontal:50.0,
        vertical:20,
      ),

      child:Form(
        key: _formKey	,

        child:Column(

          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              validator: (val)=>val.isEmpty ? 'Enter an email' : null,
              decoration: textInputDecoration.copyWith(hintText:'Email'),
              onChanged: (val){
                setState(()=> email=val);
              },
            ),
            SizedBox(
              height:20.0
            ),
            TextFormField(
              validator: (val)=>val.length<6 ? 'Enter a password 6+ chars long' : null,
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
                if (_formKey.currentState.validate()){

                  //show loading when loading
                  setState(()=>loading=true);
                  await Future.delayed(const Duration(seconds: 3));
                  print('from validated.Going for registering');

                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                  if (result==null ){
                    print('Problably an error... I dont know but probably');
                    
                    setState(() { 
                      error='Please make sure that the email is valid/not used before' ;
                      
                      loading=false;

                    });
                  }

                }
                else{
                  print('errors are there in the form');

                }
              
              },
              child: Text(
                'Sign up',
                 style:TextStyle(
                   color: Colors.white
                  )
              ),
              color: Colors.pink[400],

            
            ),

            SizedBox(
              height:20.0
            ),
            Text(
              '$error',
              style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
              ),
            ),


          ],

        )
         ),
      
      
      


    ),
    );
  }
}