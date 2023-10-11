import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  static const routeName = '/Content';
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _todoController = TextEditingController();
  List<String> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _todoController,
        ),
        const SizedBox(
          height: 32,
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance.collection("tasks").add(
              {
                "title": _todoController.text,
              },
            );
          },
          child: const Text('Task erstellen'),
        ),
        const SizedBox(
          height: 64,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final docsCount = snapshot.data?.docs.length;
              if (docsCount == 0) {
                return const Text('Keine Tasks vorhanden');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: docsCount,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data?.docs[index]['title']),
                    );
                  },
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
