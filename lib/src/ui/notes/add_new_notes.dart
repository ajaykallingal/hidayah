import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hidayah/src/data/bloc/new_notes_bloc.dart';
import 'package:hidayah/src/data/models/new_notes/new_notes_request.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/home/textStyle/text_style.dart';
import 'package:hidayah/src/ui/notes/notes_screen.dart';

import '../prayer_times/text_style.dart';

class AddNewNotes extends StatefulWidget {
  const AddNewNotes({Key? key}) : super(key: key);
  static const String id = 'new_notes_screen';

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  TextEditingController notesTextEditingController = TextEditingController();
  final insertNewNotesBloc = NewNotesBloc();
  bool loading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    insertNewNotesBloc.insertNewNotesSCStreamListener.listen((event) {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
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
            child: Stack(
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        title: Text(
                          "New notes",
                          style: kPrayerTimeScreenHeaderStyle,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            TextEditingController().clear();
                            Navigator.popAndPushNamed(context, NotesScreen.id,)
                                .then((value) => {
                              insertNewNotesBloc.fetchUserNotes(
                                request: NewNotesRequest(
                                    notesId: "0",
                                    userId: ObjectFactory()
                                        .prefs
                                        .getUserId()
                                        .toString(),
                                    notes: notesTextEditingController.text),
                              ),
                            } );

                            // insertNewNotesBloc.fetchUserNotes(
                            //   request: NewNotesRequest(
                            //       notesId: "0",
                            //       userId: ObjectFactory()
                            //           .prefs
                            //           .getUserId()
                            //           .toString(),
                            //       notes: notesTextEditingController.text),
                            // );
                            // setState(() {
                            //       Navigator.pop(context);
                            //   // Navigator.pushNamed(context, NotesScreen.id).whenComplete(() => null)
                            // });
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      // SizedBox(height: 50),

                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(1),
                          ),
                          height: 560,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            

                            style: TextStyle(color: Colors.black),
                            // focusNode: FocusNode(),

                            controller: notesTextEditingController,
                            maxLines: 9999,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: "Type in your new notes",
                              // constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width,maxHeight: 500)
                            ),
                            scrollPadding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
