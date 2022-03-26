import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as database;
import 'package:flash_card_app/models/vocabulary.dart';

class FirebaseService {
  deleteVocabulary(String id, String uid, bool isRemember) async {
    await FirebaseFirestore.instance.collection("vocabularies").doc(id).update({
      "isDeleted": true,
    });
    await database.FirebaseDatabase.instance
        .ref("users")
        .child(uid)
        .runTransaction((Object? value) {
      if (value == null) {
        return database.Transaction.abort();
      }
      var _user = Map<String, dynamic>.from(value as Map);
      _user["numberOfVocabulary"] = (_user["numberOfVocabulary"] ?? 1) - 1;
      if (isRemember) {
        _user["numberOfRemember"] = (_user["numberOfRemember"] ?? 1) - 1;
      }
      return database.Transaction.success(_user);
    });
  }

  updateFavorite(String? id, bool isFavorite) async {
    await FirebaseFirestore.instance.collection("vocabularies").doc(id).update({
      "isFavorite": !isFavorite,
    });
  }

  addNewVocabulary(Vocabulary vocabulary, String uid) async {
    await FirebaseFirestore.instance
        .collection("vocabularies")
        .doc(vocabulary.id)
        .set(vocabulary.toJson());

    await database.FirebaseDatabase.instance
        .ref("users")
        .child(uid)
        .runTransaction((Object? value) {
      if (value == null) {
        return database.Transaction.abort();
      }
      var _user = Map<String, dynamic>.from(value as Map);
      _user["numberOfVocabulary"] = (_user["numberOfVocabulary"] ?? 0) + 1;

      return database.Transaction.success(_user);
    });
  }

  editVocabulary(Vocabulary vocabulary) async{
    await FirebaseFirestore.instance
        .collection("vocabularies")
        .doc(vocabulary.id)
        .update(vocabulary.toJson());
  }

  rememberVocabulary(String id) async {
    await FirebaseFirestore.instance
        .collection("vocabularies")
        .doc(id)
        .update({
      "isRemembered": true,
    });
    await database.FirebaseDatabase.instance
        .ref("users")
        .child(FirebaseAuth.instance.currentUser?.uid ?? "000")
        .runTransaction((Object? value) {
      if (value == null) {
        return database.Transaction.abort();
      }
      var _user = Map<String, dynamic>.from(value as Map);
      _user["numberOfRemember"] = (_user["numberOfRemember"] ?? 0) + 1;
      return database.Transaction.success(_user);
    });
  }

  forgotVocabulary(String id) async {
    await FirebaseFirestore.instance
        .collection("vocabularies")
        .doc(id)
        .update({
      "isRemembered": false,
    });
    await database.FirebaseDatabase.instance
        .ref("users")
        .child(FirebaseAuth.instance.currentUser?.uid ?? "000")
        .runTransaction((Object? value) {
      if (value == null) {
        return database.Transaction.abort();
      }
      var _user = Map<String, dynamic>.from(value as Map);
      _user["numberOfRemember"] = (_user["numberOfRemember"] ?? 1) - 1;
      return database.Transaction.success(_user);
    });
  }
}
