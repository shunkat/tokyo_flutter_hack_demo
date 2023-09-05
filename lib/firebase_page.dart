import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePage extends StatefulWidget {
  FirebasePage({Key? key}) : super(key: key);

  @override
  State<FirebasePage> createState() => _FirebasePageState();
}

class _FirebasePageState extends State<FirebasePage> {
  // Firestore instance for performing operations
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Formの値を保存するTextEditingController
  TextEditingController _body = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final notes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    title: const Text('Edit a Note'),
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                    children: [
                                      TextFormField(
                                        controller: _body,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await _firestore
                                                .collection('notes')
                                                .doc(notes[index].id)
                                                .update({'body': _body.text});
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Update'))
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          )),
                      IconButton(
                        onPressed: () async {
                          await _firestore
                              .collection('notes')
                              .doc(notes[index].id)
                              .delete();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(notes[index]['body']),
                subtitle: Text(notes[index]['created_at'] != null
                    ? notes[index]['created_at'].toDate().toString()
                    : ''),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const Text('Add a Note'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  children: [
                    TextFormField(
                      controller: _body,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await _firestore.collection('notes').add({
                            'body': _body.text,
                            'created_at': Timestamp.fromDate(DateTime.now())
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
