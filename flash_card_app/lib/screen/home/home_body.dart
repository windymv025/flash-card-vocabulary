import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flash_card_app/screen/home/components/vocabulary_list_view.dart';
import 'package:flash_card_app/screen/home/dialog/add_vocabulary_widget.dart';
import 'package:flash_card_app/screen/widget/menu_tab_widget.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: MenuTabWidget(),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () => _addNewWord(context),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text("Add new word")),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<DatabaseEvent>(
                      stream: FirebaseDatabase.instance
                          .ref("users")
                          .child(
                              FirebaseAuth.instance.currentUser?.uid ?? "000")
                          .onValue,
                      builder: (context, event) {
                        if (event.connectionState == ConnectionState.waiting) {
                          return const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        }
                        var data =
                            event.data!.snapshot.value as Map<Object?, Object?>;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  "${data["numberOfRemember"]} / ${data["numberOfVocabulary"]}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.lightbulb,
                              size: 25,
                              color: Color.fromARGB(255, 253, 199, 50),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
            const Expanded(
              child: VocabularyListView(),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewWord(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Add new word"),
            content: AddVocabularyWidget(),
          );
        });
  }
}
