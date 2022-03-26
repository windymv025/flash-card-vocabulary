import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

import '../../../constants/enums.dart';
import '../../../models/vocabulary.dart';
import '../../../service/firebase_service.dart';
import '../../../utils/function_helper.dart';

class LearningPageBody extends StatefulWidget {
  const LearningPageBody({Key? key, required this.type}) : super(key: key);
  final TypeLearning type;
  @override
  State<LearningPageBody> createState() => _LearningPageBodyState();
}

class _LearningPageBodyState extends State<LearningPageBody> {
  final _flipCardController = FlipCardController();
  int totalVocabularies = 0;
  int currentVocabulary = 0;
  final _vocabularies = <Vocabulary>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    var ref = FirebaseFirestore.instance
        .collection("vocabularies")
        .where("isDeleted", isEqualTo: false);
    if (widget.type == TypeLearning.forgotten) {
      ref = ref.where("isRemembered", isEqualTo: false);
    } else if (widget.type == TypeLearning.favorite) {
      ref = ref.where("isFavorite", isEqualTo: true);
    }
    ref.get().then((event) {
      if (event.docs.isNotEmpty) {
        setState(() {
          _vocabularies.clear();
          for (var doc in event.docs) {
            _vocabularies.add(Vocabulary.fromJson(doc.data()));
          }
          _vocabularies.shuffle();
          totalVocabularies = _vocabularies.length;
          currentVocabulary = totalVocabularies != 0 ? 1 : 0;
        });
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_vocabularies.isEmpty) {
      return Center(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                Row(
                  children: [
                    Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.home_rounded,
                            size: 30, color: Colors.red),
                      ),
                    ),
                    const Spacer(),
                    Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          "$currentVocabulary / $totalVocabularies",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: Center(child: Text("No data"))),
              ],
            )),
      );
    }
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          children: [
            Row(
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.home_rounded,
                        size: 30, color: Colors.red),
                  ),
                ),
                const Spacer(),
                Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "$currentVocabulary / $totalVocabularies",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              constraints: const BoxConstraints(maxHeight: 400),
              child: Card(
                child: FlipCard(
                  controller: _flipCardController,
                  direction: FlipDirection.HORIZONTAL,
                  front: _buildFront(),
                  back: _buildBack(),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: const Icon(
                        Icons.skip_previous_rounded,
                        size: 35,
                      ),
                      onTap: () => _previousVocabulary(),
                    ),
                    if (_vocabularies[currentVocabulary - 1].isRemembered ==
                        false)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.red,
                              size: 50,
                            ),
                            onTap: () => _forgotVocabulary(),
                          ),
                          const Text("Forgot",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red)),
                        ],
                      ),
                    if (_vocabularies[currentVocabulary - 1].isRemembered ==
                        true)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: 50,
                            ),
                            onTap: () => _rememberVocabulary(),
                          ),
                          const Text(
                            "Remember",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    InkWell(
                      child: const Icon(
                        Icons.skip_next_rounded,
                        size: 35,
                      ),
                      onTap: () => _nextVocabulary(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _vocabularies[currentVocabulary - 1].word ?? "",
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          if (_vocabularies[currentVocabulary - 1].ipa != null &&
              _vocabularies[currentVocabulary - 1].ipa!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "/${_vocabularies[currentVocabulary - 1].ipa}/",
                style: const TextStyle(fontSize: 20),
              ),
            ),
        ],
      )),
    );
  }

  Widget _buildBack() {
    var vocabulary = _vocabularies[currentVocabulary - 1];
    var types = "";
    if (vocabulary.type!.isNotEmpty) {
      types = "(${vocabulary.type!.map((type) => type.toString()).join(", ")})";
    }
    var definition = "${upcaseFistCharactor(vocabulary.definition ?? "")}";
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                definition,
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                types,
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              if (vocabulary.example != null && vocabulary.example!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Ex: ${vocabulary.example ?? ""}",
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.clip,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _previousVocabulary() {
    setState(() {
      if (currentVocabulary > 1) {
        currentVocabulary--;
      } else {
        _vocabularies.shuffle();
        currentVocabulary = totalVocabularies;
      }
    });
    _flipCardController.controller!.reset();
  }

  _nextVocabulary() {
    setState(() {
      if (currentVocabulary < totalVocabularies) {
        currentVocabulary++;
      } else {
        _vocabularies.shuffle();
        currentVocabulary = 1;
      }
    });

    _flipCardController.controller!.reset();
  }

  _forgotVocabulary() async {
    await FirebaseService()
        .rememberVocabulary(_vocabularies[currentVocabulary - 1].id!);

    setState(() {
      _vocabularies[currentVocabulary - 1].isRemembered = true;
      _nextVocabulary();
    });
  }

  _rememberVocabulary() async {
    await FirebaseService()
        .forgotVocabulary(_vocabularies[currentVocabulary - 1].id!);
    setState(() {
      _vocabularies[currentVocabulary - 1].isRemembered = false;
    });
  }
}
