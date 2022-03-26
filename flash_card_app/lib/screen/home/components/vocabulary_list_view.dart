import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card_app/models/vocabulary.dart';
import 'package:flutter/material.dart';

import 'vocabulary_item.dart';

class VocabularyListView extends StatefulWidget {
  const VocabularyListView({Key? key}) : super(key: key);

  @override
  State<VocabularyListView> createState() => _VocabularyListViewState();
}

class _VocabularyListViewState extends State<VocabularyListView> {
  final ScrollController _scrollController = ScrollController();
  int _limit = 25;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Vocabulary>?>(
      stream: FirebaseFirestore.instance
          .collection("vocabularies")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .where("isDeleted", isEqualTo: false)
          .limit(_limit)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Vocabulary.fromJson(doc.data()))
              .toList()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error loading data"),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var vocabularies = snapshot.data!;
        vocabularies.sort((a, b) {
          if (a.isRemembered == false && b.isRemembered == true) {
            return -1;
          }
          if (a.isRemembered == true && b.isRemembered == false) {
            return 1;
          }

          return a.word!.compareTo(b.word!);
        });
        return ListView.builder(
          controller: _scrollController,
          itemCount: vocabularies.length,
          itemBuilder: (context, index) {
            return VocabularyItem(vocabulary: vocabularies[index]);
          },
        );
      },
    );
  }

  void _loadMore() {
    setState(() {
      _limit += 25;
    });
  }
}
