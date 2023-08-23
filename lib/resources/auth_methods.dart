import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piczo/models/user_model.dart' as model;
import 'package:piczo/resources/storage_methods.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get user details-----------------------------------------------------------
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    print("Current User =$currentUser");
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  /// SignUp User---------------------------------------------------------------
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured!!!";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // regsister user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        // make sure to run the image store methods before user uploads details
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("ProfilePic", file, false);

        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            photoUrl: photoUrl,
            followers: [],
            following: [],
            chattedUsers: []);
        // add user to database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
      if (err.code == 'invalid-email') {
        res = "The email address is badly formatted. Please try again.";
      } else if (err.code == 'weak-password') {
        res = "Password should be at least 6 characters";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// LogIn User ---------------------------------------------------------------
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Something went wrong! Please try again.";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        //UserCredential cred =
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Logged in successfully.";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "User not founded";
      } else if (e.code == 'wrong-password') {
        res = "Incorrect Password. Please try again";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// Sign out method-----------------------------------------------------------
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
