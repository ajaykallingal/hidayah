import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/delete_note_bloc.dart';
import 'package:hidayah/src/data/bloc/user_notes_show_bloc.dart';
import 'package:hidayah/src/data/models/delete_notes/delete_notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/notes/add_new_notes.dart';
import 'package:hidayah/src/ui/notes/edit_note.dart';
import 'package:hidayah/src/ui/notes/edit_note_arguments.dart';

import '../Quran/components/textStyle.dart';
import '../prayer_times/text_style.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const String id = 'notes_screen';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final userNotesBloc = UserNotesShowBloc();
  final deleteNoteBloc = DeleteNoteBloc();

  // final deleteUserNotes = DeleteN
  bool loading = false;
  List<ResponseOfNote>? noteResponse = List.empty(growable: true);
  final String userId = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userId = ObjectFactory().prefs.getUserId().toString();
    print("ID:${userId}");
    userNotesBloc.fetchUserNotes(
        request:
            NotesRequest(userId: ObjectFactory().prefs.getUserId().toString()));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    userNotesBloc.notesFetchSCStreamListener.listen((event) {
      final userId = ObjectFactory().prefs.getUserId().toString();
      // userNotesBloc.fetchUserNotes(request: NotesRequest(userId: "5"));
      //

      noteResponse = event.responseOfNotes;
      // userNotesBloc.fetchUserNotes(request: NotesRequest(userId: "5"));
      loading = false;
    });

    deleteNoteBloc.deleteNotesSCStreamListener.listen((event) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            elevation: 8,
            primary: mainRedShadeForTitle,
            fixedSize: Size(50, 50),
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddNewNotes.id);
          },
          child: ImageIcon(AssetImage("assets/images/new note.png"))),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                colors: [
                  Color(0xffE80000),
                  Color(0xff382424),
                ],
                radius: 1.6,
                focal: Alignment.topCenter,
                // focalRadius: 1.5,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg_pattern.png'),
              ),
            ),
          ),
          SafeArea(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          ListTile(
                            leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white.withOpacity(1),
                              ),
                            ),
                            title: Text(
                              "Notes",
                              style: kPrayerTimeScreenHeaderStyle,
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              color: Colors.white.withOpacity(1),
                              height: 570,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: StreamBuilder<NotesResponse>(
                                  stream:
                                      userNotesBloc.notesFetchSCStreamListener,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 200),
                                          Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    "assets/images/no note.png"),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "There is no note available!\nTap the add new notes icon.",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),

                                        ],
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.white.withOpacity(1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: 570,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: ListView.builder(
                                                        itemCount: snapshot.data!.responseOfNotes!.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                index) {
                                                          return Dismissible(
                                                            direction:
                                                                DismissDirection
                                                                    .endToStart,
                                                            background: Icon(
                                                                Icons.delete),
                                                            key: Key(
                                                                noteResponse![
                                                                        index]
                                                                    .notes),
                                                            onDismissed:
                                                                (direction) {
                                                              setState(() {
                                                                deleteNoteBloc
                                                                    .deleteNote(
                                                                  request: DeleteNotesRequest(
                                                                      notesId: noteResponse![
                                                                              index]
                                                                          .notesId),
                                                                );
                                                                noteResponse!
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              // Then show a snackbar.
                                                              // ScaffoldMessenger.of(context)
                                                              //     .showSnackBar(SnackBar(content: Text('${noteResponse![index].notes} dismissed')));
                                                            },
                                                            child: ListTile(
                                                              horizontalTitleGap:
                                                                  30,
                                                              title: GestureDetector(
                                                                onTap: (){
                                                                  Navigator.pushNamed(context, EditNote.id,
                                                                    arguments: EditNoteArguments(
                                                                        noteText: snapshot.data!.responseOfNotes![index].notes,
                                                                      noteId: snapshot.data!.responseOfNotes![index].notesId,
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  snapshot.data!.responseOfNotes![index].notes,
                                                                  softWrap: true,
                                                                  style:
                                                                      kQuranPageTabContentTitleStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ),

                            // :
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
