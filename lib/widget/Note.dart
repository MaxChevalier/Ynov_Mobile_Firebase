import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NoteWidget extends StatelessWidget {
  final String titre;
  final String description;
  final String id;
  final String image_link;
  Function reload;

  NoteWidget(
      {required this.titre,
      required this.description,
      required this.id,
      required this.image_link,
      required this.reload});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(2.5),
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFC07CC0)),
                left: BorderSide(color: Color(0xFFC07CC0)),
                right: BorderSide(color: Color(0xFFC07CC0)),
                bottom: BorderSide(color: Color(0xFFC07CC0)),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Color.fromARGB(255, 255, 237, 255),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.5),
              child: Row(
                children: [
                  if (image_link != '')
                    Image.network(
                      image_link,
                      width: 100,
                      height: 100,
                    ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          titre,
                        ),
                        Text(
                          description,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/EditNote', arguments: {
                          'id': id,
                          'title': titre,
                          'content': description,
                        }).then((value) => reload());
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        removenote();
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            )));
  }

  void removenote() {
    FirebaseStorage.instance.refFromURL(image_link).delete();
    FirebaseFirestore.instance.collection('notes').doc(id).delete();
    reload();
  }
}
