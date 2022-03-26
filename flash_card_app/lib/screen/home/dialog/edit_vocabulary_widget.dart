import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_card_app/models/vocabulary.dart';
import 'package:flash_card_app/service/firebase_service.dart';
import 'package:flutter/material.dart';

class EditVocabularyWidget extends StatefulWidget {
  const EditVocabularyWidget({
    Key? key,
    required this.vocabulary,
  }) : super(key: key);
  final Vocabulary vocabulary;
  @override
  State<EditVocabularyWidget> createState() => _EditVocabularyWidgetState();
}

class _EditVocabularyWidgetState extends State<EditVocabularyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _listTypeWord = <String>[];

  @override
  void initState() {
    super.initState();
    _listTypeWord.addAll(widget.vocabulary.type ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.vocabulary.word,
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
                widget.vocabulary.word = value?.trim();
              },
            ),
            TextFormField(
              initialValue: widget.vocabulary.definition,
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
                widget.vocabulary.definition = value?.trim();
              },
            ),
            TextFormField(
              initialValue: widget.vocabulary.ipa,
              decoration: const InputDecoration(
                labelText: "IPA",
              ),
              onSaved: (value) {
                widget.vocabulary.ipa = value;
              },
            ),
            TextFormField(
              initialValue: widget.vocabulary.example,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: "Example",
              ),
              onSaved: (value) {
                widget.vocabulary.example = value?.trim();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.vocabulary.type = _listTypeWord;
      await FirebaseService().editVocabulary(widget.vocabulary);

      Navigator.pop(context);
    }
  }
}
