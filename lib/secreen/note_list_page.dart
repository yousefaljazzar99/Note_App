import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/dark-mode.dart';
import 'package:notes/models/data-helper.dart';
import 'package:notes/models/dialog-helper.dart';
import 'package:notes/secreen/update_note_page.dart';
import 'package:provider/provider.dart';

import '../models/note-item.dart';
import 'add_note_page.dart';
import 'my_note_list_tile.dart';

class NoteListPage extends StatefulWidget {
  Function function;
  bool isDark;
//  NoteListPage(this.function, this.isDark);
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NoteItem>>(
        future: DataHelper.getAllWithTruncatedContent(),
        builder: (context, AsyncSnapshot<List<NoteItem>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color.fromARGB(255, 85, 0, 255),
                title: Text("My Note".tr()),
                actions: [
                  PopupMenuButton(
                      // add icon, by default "3 dot" icon
                      icon: Icon(Icons.settings),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  color: Colors.black,
                                ),
                                Text("Change Language".tr()),
                              ],
                            ),
                          ),
                          // PopupMenuItem<int>(
                          //   value: 1,
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         Icons.dark_mode,
                          //         color: Colors.black,
                          //       ),
                          //       Text("Dark Mode".tr()),
                          //     ],
                          //   ),
                          // ),
                          PopupMenuItem<int>(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  color: Colors.black,
                                ),
                                Text("Exit".tr()),
                              ],
                            ),
                          ),
                        ];
                      },
                      onSelected: (value) {
                        if (value == 0) {
                          if (context.locale.toString() == 'ar') {
                            context.setLocale(Locale('en'));
                          } else {
                            context.setLocale(Locale('ar'));
                          }
                        }
                        // else if (value == 1) {
                        //   print("Settings menu is selected.");
                        // }
                        else if (value == 2) {
                          Navigator.of(context).pop();
                        }
                      }),
                  // Switch(
                  //     value: Provider.of<DarkMode>(context).isDark,
                  //     onChanged: Provider.of<DarkMode>(context).changeTheme),
                  // IconButton(
                  //     onPressed: () {
                  //       // Provider.of<DarkMode>(context).changeLanguage(context);
                  //       if (context.locale.toString() == 'ar') {
                  //         context.setLocale(Locale('en'));
                  //       } else {
                  //         context.setLocale(Locale('ar'));
                  //       }
                  //     },
                  //     icon: Icon(Icons.language))
                ],
              ),
              body: _buildNoteList(snapshot.data),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 85, 0, 255),
                onPressed: () {
                  _navigateToAddNotePage(context);
                },
                child: const Icon(Icons.note_alt),
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(), body: _buildLoadingScreen(context));
          }
        });
  }

  Widget _buildLoadingScreen(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          const CircularProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey,
          ),
          Container(
              margin: const EdgeInsets.only(top: 15),
              child: Text("Loading".tr())),
        ],
      ),
    ));
  }

  _navigateToAddNotePage(BuildContext context) async {
    final NoteItem result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage()),
    );

    if (result != null && result.title.isNotEmpty) {
      setState(() {});
    }
  }

  Widget _buildNoteList(List<NoteItem> notes) {
    if (notes.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: 170,
            ),
            Image.asset('assets/images/note.png'),
            Center(
                child: Text(
              "No Notes :(".tr(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Text('You have no task to do'.tr())
          ],
        ),
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return MyNoteListTile(
            note: notes[index],
            onTap: () async {
              final NoteItem result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UpdateNotePage(noteId: notes[index].id)),
              );

              setState(() {});
            },
          );
        });
  }
}
