import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/NoteList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    if (FirebaseAuth.instance.currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TPF Firebase'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/Register');
                      setState(() {});
                    },
                    child: const Text('Register'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/Login');
                      setState(() {});
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
              Expanded(
                child: Text('You are not connected'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TPF Firebase'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are connected as ' + FirebaseAuth.instance.currentUser!.email!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    // logout
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      setState(() {});
                    },
                    child: const Text('Logout'),
                  )
                ],
              ),
              Expanded(
                child: NoteList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/CreateNote');
            setState(() {});
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
