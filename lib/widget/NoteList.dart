import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Note.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  @override
  Widget build(BuildContext context) {

    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    // if not connected to Firebase, show a loading indicator
    if (FirebaseAuth.instance.currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // if user is not login yet, show a login button
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      return Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/Login'),
          child: const Text('Login'),
        ),
      );
    }
    // if user is login, show a list of notes
    return StreamBuilder(
      stream: notes.where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return NoteWidget(
              titre: data['title'],
              description: data['content'],
              id: document.id,
              image_link : data['image'],
              reload: () {
                setState(() {});
              },
            );
          }).toList(),
        );
      },
    );
  }
}