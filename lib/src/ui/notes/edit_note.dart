import 'package:flutter/material.dart';
import 'package:hidayah/src/data/bloc/new_notes_bloc.dart';

import '../../data/bloc/user_notes_show_bloc.dart';
import '../../data/models/new_notes/new_notes_request.dart';
import '../../shared_pref/object_factory.dart';
import '../prayer_times/text_style.dart';
import 'edit_note_arguments.dart';

class EditNote extends StatefulWidget {
  static const String id = 'edit_notes_screen';

  const EditNote({Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final userNotesBloc = UserNotesShowBloc();
 TextEditingController editNotesController = TextEditingController();
 bool loading = false;

 @override
 void didChangeDependencies() {
   // TODO: implement didChangeDependencies
   super.didChangeDependencies();
   userNotesBloc.notesFetchSCStreamListener.listen((event) {
    Navigator.of(context).pop();
     loading = false;
   });
 }



  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as EditNoteArguments;
    editNotesController = TextEditingController(text: arguments.noteText);
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
                    children: const [
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
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
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
                                  notes: editNotesController.text),
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


                            style: const TextStyle(color: Colors.black),
                            // focusNode: FocusNode(),

                            controller:  editNotesController,
                            maxLines: 9999,
                            keyboardType: TextInputType.multiline,
                            decoration:  const InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintStyle: TextStyle(color: Colors.black),
                              // hintText: "Type in your notes",
                              // constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width,maxHeight: 500)
                            ),
                            scrollPadding: const EdgeInsets.all(20),
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
