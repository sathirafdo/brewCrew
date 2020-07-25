import 'package:brewcrew/models/brew_user.dart';
import 'package:brewcrew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    print('textytext');
    
    final users = Provider.of<List<BrewUser>>(context);
    // print(users);
    // print(users.documents);

    // users.forEach((u){
    //   print(u.name);
    //   print(u.strength);
    //   print(u.sugars);
    // }) ;
    BrewTile placeHolderTile = BrewTile(brewuser: BrewUser(name: 'Loading', strength: 100, sugars: 'Loading'));
    
    return users==null ? Align(
      child: placeHolderTile,
      alignment: Alignment.topCenter,) 
      
      :ListView.builder(
      itemCount: users.length,
      itemBuilder:(context,index){
        return BrewTile(brewuser:users[index]);
      },

    );

  }
}