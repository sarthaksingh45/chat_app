import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chats')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, index) => ChatBubble(
                snapshot.data.documents[index]['text'],
                snapshot.data.documents[index]['username'],
                snapshot.data.documents[index]['imageurl'],
                snapshot.data.documents[index]['uid'] ==
                    futureSnapshot.data.uid,
                key: ValueKey(snapshot.data.documents[index].documentID),
              ),
              itemCount: snapshot.data.documents.length,
            );
          },
        );
      },
    );
  }
}
