import 'package:coffer_order/models/user.dart';
import 'package:coffer_order/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorSMS = '';
  
  //create user object based on Firebase User
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users>get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  //sing in anonymously
  Future signInAnon() async {
    try{
     UserCredential result = await _auth.signInAnonymously();
     User user = result.user;
     return _userFromFirebaseUser(user);

    } catch(e){
      print(e.toString());
      List<String> error = e.toString().split(']');
      errorSMS = error[1];
      return null;
    }
  }

  //register user with email and password
  Future registerWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('0', 'name', 100);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      List<String> error = e.toString().split(']');
      errorSMS = error[1];
      return null;
    }
  }

  //sign in user with email and password
  Future sigInWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      List<String> error = e.toString().split(']');
      errorSMS = error[1];
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      List<String> error = e.toString().split(']');
      errorSMS = error[1];
      return null;
    }
  }
}