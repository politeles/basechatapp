import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chat screen'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(8),
          child: const Text('This works'),
        ),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/QmHcxlMM4GMLiKfSi9OQ/messages')
              .snapshots()
              .listen((event) {
            event.docs.forEach((document) {
              print(document['text']);
            });
            //print(event.docs[0]['text']);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
