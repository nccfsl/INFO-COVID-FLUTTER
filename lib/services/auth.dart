import 'package:firebase_auth/firebase_auth.dart';
import 'package:info_covid/models/user.dart';
import 'package:info_covid/services/database.dart';

class Auth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // crea un User a partire da un FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth changes User stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser); // mappa i FirebaseUser in User e li utilizza nella Stream
  }

  // login email pw
  Future loginEmailPw(String email, String pw) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pw);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signupEmailPw(String codfisc, String email, String pw) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pw);
      FirebaseUser user = result.user;

      await Database(uid: user.uid).updateUserData(codfisc, email);
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // registrazione email pw codfisc

  // logout
  Future logOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {
      print(e.toString());
    }
  }

}