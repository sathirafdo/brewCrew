import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/models/user_data.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/contants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey =GlobalKey<FormState>();
  final List<String> sugars= ['0','1','2','3','4'];
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
  final user = Provider.of<User>(context) ;
  
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData){
          UserData userData = snapshot.data;

        return Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your brew settings',
                style: TextStyle(
                  fontSize:18.0,
                  fontWeight:FontWeight.bold
                ),),
                SizedBox(
                  height:10,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val)=>val.isEmpty ? 'Please Enter a name': null,
                  onChanged: (val)=>setState(()=>_currentName=val),
                ),
                SizedBox(height:20),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars ,

                  onChanged: (val) => setState(() => _currentSugars = val ),
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                      );
                      }).toList(), 
                  ),
                  Slider(
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown,
                    min:100,
                    max:900,
                    divisions: 8,

                    value: (_currentStrength ?? 100).toDouble(),
                    onChanged: (val)=>setState(()=> _currentStrength=val.round())
                    ),

                //slider

                //buttom

                RaisedButton(
                  onPressed: ()async{
                    if (_formkey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars?? userData.sugars,
                        _currentName?? userData.name,
                        _currentStrength?? userData.strength);

                    }
                    print(' updated with these  $_currentName - $_currentStrength - $_currentSugars');
                    Navigator.pop(context);
                  },

                  child: Text('Update',
                  style:TextStyle(
                  color:Colors.white,
                  fontWeight:FontWeight.w300
                  )),
                  color: Colors.pink[400],
                  ),


            ],
          ),
        );}

        else{
          return Loading();

        }
      }
    );
  }
}