import 'package:flash_card_app/models/vocabulary.dart';
import 'package:flash_card_app/screen/home/dialog/edit_vocabulary_widget.dart';
import 'package:flash_card_app/service/firebase_service.dart';
import 'package:flash_card_app/utils/function_helper.dart';
import 'package:flutter/material.dart';

class VocabularyItem extends StatefulWidget {
  const VocabularyItem({Key? key, required this.vocabulary}) : super(key: key);
  final Vocabulary vocabulary;
  @override
  State<VocabularyItem> createState() => _VocabularyItemState();
}

class _VocabularyItemState extends State<VocabularyItem> {
  @override
  Widget build(BuildContext context) {
    var types = "";
    if (widget.vocabulary.type!.isNotEmpty) {
      types =
          "(${widget.vocabulary.type!.map((type) => type.toString()).join(", ")}): ";
    }
    var definition =
        types + "${upcaseFistCharactor(widget.vocabulary.definition ?? "")}";
    return Card(
      child: ListTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              upcaseFistCharactor(widget.vocabulary.word ?? ""),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
              overflow: TextOverflow.clip,
            ),
            const SizedBox(width: 8),
            Icon(
              widget.vocabulary.isRemembered == true
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: const Color.fromARGB(255, 20, 197, 4),
              size: 15,
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            definition,
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
            overflow: TextOverflow.clip,
          ),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  child: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 17,
                  ),
                  onTap: _editVocabulary,
                ),
                InkWell(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 17,
                  ),
                  onTap: _deleteVocabulary,
                ),
              ],
            ),
            InkWell(
              child: Icon(
                widget.vocabulary.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
                size: 31,
              ),
              onTap: () {
                FirebaseService().updateFavorite(widget.vocabulary.id,
                    widget.vocabulary.isFavorite ?? false);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteVocabulary() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete"),
            content: const Text("Are you sure to delete this word?"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text("Delete"),
                onPressed: () {
                  FirebaseService().deleteVocabulary(
                      widget.vocabulary.id!,
                      widget.vocabulary.uid!,
                      widget.vocabulary.isRemembered ?? false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _editVocabulary() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add new word"),
            content: EditVocabularyWidget(vocabulary: widget.vocabulary),
          );
        });
  }
}
