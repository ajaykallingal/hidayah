import 'package:flutter/material.dart';
import 'package:hidayah/src/data/bloc/user_notes_show_bloc.dart';

import '../../data/bloc/new_notes_bloc.dart';
import '../../data/models/new_notes/new_notes_request.dart';
import '../../shared_pref/object_factory.dart';
import '../prayer_times/text_style.dart';
import 'edit_note_arguments.dart';
import 'notes_screen.dart';

class NoteViewScreen extends StatefulWidget {
  const NoteViewScreen({Key? key}) : super(key: key);
  static const String id = 'notes_view_screen';


  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  TextEditingController noteController = TextEditingController();
  final userNotesBloc = UserNotesShowBloc();
  bool loading = true;





  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userNotesBloc.notesFetchSCStreamListener.listen((event) {
      Navigator.pushReplacementNamed(context, NotesScreen.id);
      loading = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as EditNoteArguments;
    noteController = TextEditingController(text: arguments.noteText);
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, NotesScreen.id);
                          },
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        title: Text(
                          "Edit notes",
                          style: kPrayerTimeScreenHeaderStyle,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            TextEditingController().clear();

                            userNotesBloc.insertNewNotes(
                              request: NewNotesRequest(
                                  notesId: arguments.noteId,
                                  userId: ObjectFactory()
                                      .prefs
                                      .getUserId()
                                      .toString(),
                                  notes: noteController.text
                              ),
                            );
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
                          child: const Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          borderRadius: const BorderRadius.all(Radius.circular(10))

                        ),
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 20),
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height / 1.25,
                        width: MediaQuery.of(context).size.width,
                        child:  TextField(

                          style: const TextStyle(color: Colors.black),
                          controller: noteController,
                          showCursor: true,


                          // textInputAction: TextInputActionne,
                          decoration: const InputDecoration(

                            hintText: "Insert your message",
                            border: InputBorder.none,
                          ),
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: 99999,
                          // autofocus: true,
                          onTap: (){
                            // FocusManager.instance.primaryFocus?.unfocus();

                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ),
    ],
      ),

    );
  }
}
