import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController controllertitle = TextEditingController();
  TextEditingController controllercontent = TextEditingController();

  FilePickerResult? _image;
  UploadTask? _uploadTask;

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image,);
    if (result == null) return;
    // check if is image
    final image_extensions = ['png', 'jpg', 'jpeg'];
    if (!image_extensions.contains(result.files.single.extension)) return;
    setState(() {
      _image = result;
    });
  }

  Future uploadImage() async {
    if (_image == null) return '';

    final path = 'notes/${FirebaseAuth.instance.currentUser!.uid}/${DateTime.now()}.png';
    final image = File(_image!.files.single.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    _uploadTask = ref.putFile(image);

    final snapshot = await _uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: controllertitle,
              decoration: const InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()
                ),
            ),
            TextField(
              controller: controllercontent,
              decoration: const InputDecoration(
                  labelText: 'Content', border: OutlineInputBorder()
                ),
            ),
            Text('Ajouter une image'),
            if (_image != null) Image.file(File(_image!.files.single.path!)),
            ElevatedButton(
              onPressed: () async {
                await selectImage();
              },
              child: const Text('Add Image')
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance.collection('notes').add({
                    'title': controllertitle.text,
                    'content': controllercontent.text,
                    'uid': FirebaseAuth.instance.currentUser!.uid,
                    'image': await uploadImage(),
                  });
                  Navigator.pop(context);
                },
                child: const Text('Add Task'))
            )
          ],
        ),
      )),
    );
  }
}
