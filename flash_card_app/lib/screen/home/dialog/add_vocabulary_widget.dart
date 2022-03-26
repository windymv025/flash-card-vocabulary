import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card_app/models/vocabulary.dart';
import 'package:flash_card_app/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddVocabularyWidget extends StatefulWidget {
  const AddVocabularyWidget({Key? key}) : super(key: key);

  @override
  State<AddVocabularyWidget> createState() => _AddVocabularyWidgetState();
}

class _AddVocabularyWidgetState extends State<AddVocabularyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _listTypeWord = <String>[];
  String? newWord;
  String? definition;
  String? ipa;
  String? example;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "New word (*)",
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter word";
                }
                return null;
              },
              onSaved: (value) {
                newWord = value?.trim();
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Definition (*)",
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter definition";
                }
                return null;
              },
              onSaved: (value) {
                definition = value?.trim();
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "IPA",
              ),
              onSaved: (value) {
                ipa = value?.trim();
              },
            ),
            TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                labelText: "Example",
              ),
              onSaved: (value) {
                example = value?.trim();
              },
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Type word",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Spacer(),
              ],
            ),
            StreamBuilder<List<String>>(
              stream: FirebaseFirestore.instance
                  .collection("typeOfWork")
                  .snapshots()
                  .map((querySnapshot) => querySnapshot.docs
                      .map((doc) => doc.data()["name"].toString())
                      .toList()),
              builder: (context, snapshot) {
                return Wrap(
                  runSpacing: 4,
                  spacing: 4,
                  children: snapshot.data == null
                      ? []
                      : snapshot.data!
                          .map(
                            (String type) => FilterChip(
                              label: Text(
                                type,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                              selected: _listTypeWord.contains(type),
                              selectedColor: Colors.red,
                              backgroundColor: const Color(0xFf28ae8f),
                              showCheckmark: false,
                              onSelected: (bool value) {
                                setState(() {
                                  if (value) {
                                    _listTypeWord.add(type);
                                  } else {
                                    _listTypeWord.remove(type);
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Submit"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseService().addNewVocabulary(
          Vocabulary(
            uid: FirebaseAuth.instance.currentUser?.uid ?? "000",
            id: const Uuid().v1(),
            word: newWord,
            definition: definition,
            ipa: ipa,
            example: example,
            isFavorite: false,
            isRemembered: false,
            type: _listTypeWord,
          ),
          FirebaseAuth.instance.currentUser?.uid ?? "000");

      Navigator.pop(context);
    }
  }
}
