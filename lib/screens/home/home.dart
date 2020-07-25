import 'package:brewcrew/models/brew_user.dart';
import 'package:brewcrew/screens/home/brew_list.dart';
import 'package:brewcrew/screens/home/settings_form.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(
              vertical:20.0,
              horizontal:60.0,
            ),
            child: SettingsForm()
          );
        }
        );
    }

    return StreamProvider<List<BrewUser>>.value(
      value: DatabaseService().users ,

        child: Scaffold(
        backgroundColor: Colors.brown[40],

        appBar: AppBar(
          title:Text('Brew Crew Home'),
          backgroundColor: Colors.brown[400],
          elevation: 5.0 ,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async{
                print('you pressed the person');
                await _auth.mySignOut();
                print('signed out');
                
              },
              icon: Icon(Icons.person,
              color: Colors.brown[600],),
              label: Text('logout')),
              IconButton(
                icon:Icon(Icons.settings) ,
                onPressed: () {
                  print('Toggled the sheet');
                  _showSettingsPanel();
                },
                ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                image:DecorationImage(image: AssetImage('images/bg.jpg'),
                fit: BoxFit.cover)
              ),
              child: BrewList()
              ),
          )),
      ),
    );
  }
}