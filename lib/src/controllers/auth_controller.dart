import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserSpace {
  teacher,
  parent,
}

class AuthController extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _loading = RxBool(false);
  final _isAuthenticaited = RxBool(false);

  static Map<String, dynamic>? _user;

  bool get isLoading => _loading.isTrue;
  Map<String, dynamic>? get user => _user;

  login(String username, String password,
      [UserSpace space = UserSpace.parent]) async {
    try {
      _loading(true);
      final credential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      Get.log('Login successful');
      _user = await _findUser(credential.user!.uid, space);
      if (_user == null) {
        return _showErrorSnackBar();
      }
      _user?['role'] = space.name;
      _user?['uid'] = credential.user!.uid;
      _loading(false);
      Get.offAndToNamed("/home");
    } on FirebaseAuthException catch (e) {
      _loading(false);
      if (e.code == 'user-not-found') {
        Get.log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.log('Wrong password provided for that user.');
      }
      _showErrorSnackBar();
    }
  }

  _findUser(String uid, UserSpace space) async {
    try {
      final collection = space == UserSpace.teacher ? "teachers" : "parents";
      Get.log("user_id : $uid");
      final user = await _db.collection(collection).doc(uid).get();
      Get.log("Found a user in db : ${user.data()}");
      return user.data();
    } catch (e) {
      Get.log('No user found in this user space');
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.redAccent,
        title: "Erreur d'authetification",
        message: "Email ou mot de passe errouné",
        duration: Duration(seconds: 3),
      ));
    }
  }

  _showErrorSnackBar() {
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.redAccent,
      title: "Erreur d'authetification",
      message: "Email ou mot de passe errouné",
      duration: Duration(seconds: 3),
    ));
  }
}
