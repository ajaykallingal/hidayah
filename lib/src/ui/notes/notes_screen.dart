import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/delete_note_bloc.dart';
import 'package:hidayah/src/data/bloc/user_notes_show_bloc.dart';
import 'package:hidayah/src/data/models/delete_notes/delete_notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/home/home_screen.dart';
import 'package:hidayah/src/ui/notes/add_new_notes.dart';
import 'package:hidayah/src/ui/notes/edit_note_arguments.dart';
import 'package:hidayah/src/ui/notes/note_view_screen.dart';

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
  // final deleteNoteBloc = DeleteNoteBloc();

  // final deleteUserNotes = DeleteN
  bool loading = true;
  List<ResponseOfNote>? noteResponse = List.empty(growable: true);
  final String userId = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userId = ObjectFactory().prefs.getUserId().toString();
    print("ID:$userId");
    userNotesBloc.fetchUserNotes(
        request:
            NotesRequest(userId: ObjectFactory().prefs.getUserId().toString()));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //
    // userNotesBloc.notesFetchSCStreamListener.listen((event) {
    // setState((){
    //   noteResponse = event.responseOfNotes;
    //   loading = false;
    // });
    //
    // });

    // deleteNoteBloc.deleteNotesSCStreamListener.listen((event) {
    //   setState(() {
    //
    //     loading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            elevation: 8,
            primary: mainRedShadeForTitle,
            fixedSize: const Size(50, 50),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AddNewNotes.id);
          },
          child: const ImageIcon(AssetImage("assets/images/new note.png"))),
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
            child:  Stack(
                    children: [
                      Column(
                        children: [
                          ListTile(
                            leading: IconButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, HomeScreen.id, (route) => false);
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
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 570,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: StreamBuilder<NotesResponse>(
                                  stream:
                                      userNotesBloc.notesFetchSCStreamListener,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Align(alignment:Alignment.bottomCenter, child: CircularProgressIndicator(color: mainRedShadeForTitle,strokeWidth: 2,));
                                    }
                                  else if (snapshot.data!.responseOfNotes!.isEmpty) {
                                      return Column(
                                        children: [
                                          const SizedBox(height: 200),
                                          Container(
                                            height: 90,
                                            width: 90,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    "assets/images/no note.png"),
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            "There is no note available!\nTap the add new notes icon.",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      );
                                    }
                                    else {
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
                                                        itemCount: snapshot
                                                            .data!
                                                            .responseOfNotes!
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                index) {
                                                          return ListTile(
                                                            contentPadding: EdgeInsets.zero,
                                                            horizontalTitleGap:
                                                                30,
                                                            title:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                  context,
                                                                  NoteViewScreen
                                                                      .id,
                                                                  arguments:
                                                                      EditNoteArguments(
                                                                    noteText: snapshot
                                                                        .data!
                                                                        .responseOfNotes![
                                                                            index]
                                                                        .notes,
                                                                    noteId: snapshot
                                                                        .data!
                                                                        .responseOfNotes![
                                                                            index]
                                                                        .notesId,
                                                                  ),
                                                                ).then((value) => userNotesBloc.fetchUserNotes(
                                                                    request: NotesRequest(
                                                                        userId: ObjectFactory()
                                                                            .prefs
                                                                            .getUserId()
                                                                            .toString())));
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(7),
                                                                height: 65,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // image: widget.favImageWidget,
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          1.0),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                              .grey[
                                                                          350]!,
                                                                      offset: const Offset(
                                                                          4.0,
                                                                          4.0),
                                                                      blurRadius:
                                                                          15.0,
                                                                      spreadRadius:
                                                                          1.0,
                                                                    ),
                                                                    const BoxShadow(
                                                                      color: Colors
                                                                          .white,
                                                                      offset: Offset(
                                                                          -4.0,
                                                                          -4.0),
                                                                      blurRadius:
                                                                          15.0,
                                                                      spreadRadius:
                                                                          1.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child: Text(
                                                                        snapshot
                                                                            .data!
                                                                            .responseOfNotes![
                                                                                index]
                                                                            .notes,
                                                                        softWrap:
                                                                            true,
                                                                        style:
                                                                            kQuranPageTabContentTitleStyle,
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                AlertDialog(
                                                                                  alignment: Alignment.center,
                                                                                  title: Text(
                                                                                    "Delete Note",
                                                                                    style: kCalendarAddEventStyle,
                                                                                  ),
                                                                                  content:  Text("Do you wish to delete this note?",style: TextStyle(color: Colors.black),),
                                                                                  shape: RoundedRectangleBorder(side: BorderSide(color: lightGreyShadeForText), borderRadius: const BorderRadius.all(Radius.circular(10))),
                                                                                  elevation: 10,
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        // print(_selectedDay)
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: Text(
                                                                                        "Cancel",
                                                                                        style: kCalendarAddEventButtonStyle,
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        setState(() {
                                                                                          userNotesBloc.deleteNote(
                                                                                              request: DeleteNotesRequest(
                                                                                            notesId: snapshot.data!.responseOfNotes![index].notesId, userId: ObjectFactory().prefs.getUserId().toString(),
                                                                                          )
                                                                                          );
                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                          Navigator.pop(context);
                                                                                          loading =  true;
                                                                                        });
                                                                                      },
                                                                                      child: Text(
                                                                                        "Confirm",
                                                                                        style: kCalendarAddEventButtonStyle,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .delete),
                                                                    ),
                                                                  ],
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
