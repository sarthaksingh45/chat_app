import 'package:chat_app/widgets/chat_msg.dart';
import 'package:chat_app/widgets/type_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [Icon(Icons.logout), Text('LogOut')],
                  ),
                ),
                value: 'logout',
              ),
            ],
            icon: Icon(Icons.more_vert),
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: ChatMessages()),
            TypeMsgWid(),
          ],
        ),
      ),
    );
  }
}
