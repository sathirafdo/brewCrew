import 'package:flutter/material.dart';
import 'package:brewcrew/models/brew_user.dart';

class BrewTile extends StatelessWidget {
  final BrewUser brewuser;

  BrewTile({this.brewuser});
  
    @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8),
      child: Card(
        color: Colors.brown[50],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading:CircleAvatar(
            backgroundImage: AssetImage('images/c.png'),
            radius: 25,
            backgroundColor: Colors.brown[brewuser.strength],
          ),
          title: Text(brewuser.name),
          subtitle: Text('Takes ${brewuser.sugars} sugars'),
        ),
      ),
    );
  }
}