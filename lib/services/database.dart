import 'package:brewcrew/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brewcrew/models/brew_user.dart';


class DatabaseService {



  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection=Firestore.instance.collection('users');

  Future updateUserData( String sugars, String name, int strength) async{
    return await userCollection.document(uid).setData(
      {
        'sugars':sugars,
        'name': name,
        'strength':strength,
      }
    );

  }



  //brewlist from snapshots
  List<BrewUser> _brewUsersFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      print('fromsnapshot map ${doc.data}');
      print('next snapshot map doc is');
      return BrewUser(
        name: doc.data['name']?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );

    }).toList();
  }
    //userdata from doc napshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

    // get users stream
  Stream <List<BrewUser>>  get users { 
    return userCollection.snapshots()
    .map(_brewUsersFromSnapshot);
  }
  // get user doc stream
  Stream<UserData> get  userData{
    return userCollection.document(uid).snapshots().map(_userDataFromSnapShot);

  }


}