import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
          child: Text(
            "Mes messages",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.jpg"),
          ),
          title: Text(
            "Teacher name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "message 1",
          ),
        ),
      ]),
    );
  }
}
