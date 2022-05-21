import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment_app/src/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final _auth = Get.find<AuthController>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              accountEmail: Text(
                "${_auth.user?['email']}",
                style: TextStyle(color: Colors.grey),
              ),
              accountName: Text(
                "${_auth.user?['first_name']} ${_auth.user?['last_name']}",
                style: TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.family_restroom_rounded),
              title: const Text('Mes enffants'),
              onTap: () => Get.toNamed("/children"),
            ),
            ListTile(
              leading: Icon(Icons.chat_rounded),
              dense: true,
              title: const Text('Mes message'),
              onTap: () => Get.toNamed("/messages"),
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              dense: true,
              title: const Text('Se deconnecter'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Bienvenu",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "${_auth.user?['first_name']} ${_auth.user?['last_name']}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              if (_auth.user?['role'] == UserSpace.parent.name)
                _buildParentView(),
              if (_auth.user?['role'] == UserSpace.teacher.name)
                _buildTeacherView(),
            ],
          ),
        ),
      ),
    );
  }

  _buildParentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: ListTile(
            dense: true,
            leading: Icon(
              Icons.family_restroom_rounded,
              size: 32.0,
              color: Colors.blue[200],
            ),
            title: Text("Mes enfants"),
            subtitle: Text("3 fils et 5 garçons"),
            trailing: IconButton(
              icon: Icon(Icons.group_add_rounded),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  _buildTeacherView() {}
}
