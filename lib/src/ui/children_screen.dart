import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment_app/src/controllers/auth_controller.dart';

class ChildrenScreen extends StatelessWidget {
  final _auth = Get.find<AuthController>();
  late Stream<QuerySnapshot> _childrenStream;
  ChildrenScreen({Key? key}) : super(key: key) {
    _childrenStream = FirebaseFirestore.instance
        .collection('children')
        .where('parent_id', isEqualTo: _auth.user?['uid'])
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes enfants"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _childrenStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  dense: true,
                  leading: Icon(Icons.escalator_warning_rounded),
                  title: Text(data['first_name'] + " " + data['last_name']),
                  subtitle: Text(
                      "${_parseGender(data['gender'])}, ${data['age']} ans"),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  _parseGender(gender) {
    return gender == "male" ? "garçon" : "file";
  }
}
