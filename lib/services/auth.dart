import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/services/database.dart';

abstract class AuthBase {
  User get currentUser;
  Future signInWithGoogle();
  Future signInWithFacebook();
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebaseUser
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }


  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (!(user.emailVerified)) {
        return 2;
      } else {
        return _userFromFirebaseUser(user);
      }
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      if (e.code == 'wrong-password') {
        return 1;
      }
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String nome,DateTime data) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      String typeUser = 'Client';
      //create a document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(nome, data, typeUser);
      user.sendEmailVerification();
      return  _userFromFirebaseUser(user);
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      if (e.code == 'email-already-in-use') {
        return 1;
      }
    }
  }
  Future registerProfessionalWithEmailAndPassword(
      String email, String password, String nome,DateTime data) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      String typeUser = 'Professional';
      //create a document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserDataProfessional(nome, data, typeUser);
      user.sendEmailVerification();
      return  _userFromFirebaseUser(user);
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      if (e.code == 'email-already-in-use') {
        return 1;
      }
    }
  }
  Future registerCompanyWithEmailAndPassword(
      String email, String password, String nome,DateTime data) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      String typeUser = 'Company';
      //create a document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserDataCompany(nome, data, typeUser);
      user.sendEmailVerification();
      return  _userFromFirebaseUser(user);
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      if (e.code == 'email-already-in-use') {
        return 1;
      }
    }
  }



  //sing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Reset password
  Future sendPasswordResetEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //sign in with google
  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
        User user = userCredential.user;
        if (userCredential.additionalUserInfo.isNewUser) {
          String nome = user.displayName.toString(), typeUser = 'Client';
          DateTime data = DateTime.now();
          await DatabaseService(uid: user.uid).updateUserData(nome, data, typeUser);
          //User logging in for the first time
          // Redirect user to tutorial
        }

        return userCredential;
      }
    }
  }

  //sign in with facebook
  Future signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _auth.signInWithCredential(FacebookAuthProvider.credential(accessToken.token));
        User user = userCredential.user;
        if (userCredential.additionalUserInfo.isNewUser) {
          String nome = user.displayName.toString(), typeUser = 'Client';
          DateTime data = DateTime.now();
          await DatabaseService(uid: user.uid).updateUserData(nome, data, typeUser);//User logging in for the first time
          // Redirect user to tutorial
        }
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }
}



