import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseuser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null; 
  }

  // auth chnage user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    // .map((FirebaseUser user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }


  // sign in anon
  Future signInAnon() async{
try{
  print('anon sign in try');
  AuthResult result = await _auth.signInAnonymously();
  FirebaseUser user = result.user;
  return _userFromFirebaseUser(user);
}
catch(e){
  print(e.toString());
  print('anon sign in catch');
  return null;
}
  }

  // sigm with email
  Future  signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult  result= await _auth.signInWithEmailAndPassword(email: email, password: password );
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e){
      
      print(e.message);
      print('error occurred man. They say we you cant sign up lu');
      return null;
      
      
    }
  }


  //register with email pass
  Future registerWithEmailAndPassword( String email, String password)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email , password: password);
            FirebaseUser user =result.user;
            await DatabaseService(uid:user.uid).updateUserData('0', 'New Crew member', 100);

            return _userFromFirebaseUser(user);

    }
    catch(e){
      print(e);
      print('regiter eroor occured');
      return null;
    }

  }

  // msign out
  Future mySignOut() async{
    try{
      return await _auth.signOut();

    }
    catch(e){
      print('logout exception $e');
      return null;
      
    }
  }


}