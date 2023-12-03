import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateNote extends StatefulWidget {

  const UpdateNote({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController _controllertitle = TextEditingController();
  TextEditingController _controllercontent = TextEditingController();

  String id = '';
  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {

    Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    id = arg['id'];
    title = arg['title'];
    content = arg['content'];

    _controllertitle.text = title;
    _controllercontent.text = content;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Note'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: _controllertitle,
              decoration: const InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()
                ),
              
            ),
            TextField(
              controller: _controllercontent,
              decoration: const InputDecoration(
                  labelText: 'Content', border: OutlineInputBorder()
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async {
                  // test if the user is the owner of the note
                  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('notes').doc(id).get();
                  if (doc['uid'] != FirebaseAuth.instance.currentUser!.uid) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vous n\'êtes pas le propriétaire de cette note')));
                    return;
                  }
                  // update the note and show error if not successful
                  try {
                    await FirebaseFirestore.instance.collection('notes').doc(id).update({
                      'title': _controllertitle.text,
                      'content': _controllercontent.text,
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Une erreur est survenue')));
                    return;
                  }
                  Navigator.pop(context);
                },
                child: const Text('Update Task'))
            )
          ],
        ),
      )),
    );
  }
}
