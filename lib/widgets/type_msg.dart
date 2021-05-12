import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TypeMsgWid extends StatefulWidget {
  @override
  _TypeMsgWidState createState() => _TypeMsgWidState();
}

class _TypeMsgWidState extends State<TypeMsgWid> {
  var _typedMessage = '';
  final _controller = new TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chats').add({
      'text': _typedMessage,
      'time': Timestamp.now(),
      'uid': user.uid,
      'username': userData['username'],
      'imageurl': userData['imageurl'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter a message'),
              onChanged: (value) {
                setState(() {
                  _typedMessage = value;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                if (_typedMessage.trim() == null)
                  return null;
                else {
                  return _sendMessage();
                }
              }),
        ],
      ),
    );
  }
}
