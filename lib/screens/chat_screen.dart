import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chat screen'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats/QmHcxlMM4GMLiKfSi9OQ/messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
            itemCount: documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/QmHcxlMM4GMLiKfSi9OQ/messages')
              .add({'text': 'This was added by clicking the button'});
          //     .snapshots()
          //     .listen((event) {
          //   event.docs.forEach((document) {
          //     print(document['text']);
          //   });
          //print(event.docs[0]['text']);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
