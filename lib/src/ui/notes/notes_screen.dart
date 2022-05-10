import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/user_notes_show_bloc.dart';
import 'package:hidayah/src/data/models/notes/notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/notes/add_new_notes.dart';

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
    userNotesBloc.fetchUserNotes(request: NotesRequest(userId: ObjectFactory().prefs.getUserId().toString()));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    userNotesBloc.notesFetchSCStreamListener.listen((event) {


      setState(() {
        final userId = ObjectFactory().prefs.getUserId().toString();
        // userNotesBloc.fetchUserNotes(request: NotesRequest(userId: "5"));
        //

        noteResponse = event.responseOfNotes;
        // userNotesBloc.fetchUserNotes(request: NotesRequest(userId: "5"));
        loading = false;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return   Stack(
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
          child: loading ?
          const Center(child:  CircularProgressIndicator(color: Colors.white,),) :
          Stack(
            children: [
              Material(
                type: MaterialType.transparency,
                child:

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
                        noteResponse!.isEmpty
                            ?
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            color: Colors.white,
                            height: 560,
                            width: MediaQuery.of(context).size.width,
                            child: StreamBuilder<NotesResponse>(
                              stream: userNotesBloc.notesFetchSCStreamListener,
                              builder: (context, snapshot) {
                                if(!snapshot.hasData || snapshot.data == null) {
                                  return Column(

                                  children: [
                                    SizedBox(height: 200),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                            image: AssetImage("assets/images/no note.png"),
                                        ),
                                      ),

                                    ),
                                    Text("There is no note available!\nTap the add new notes icon.",style: TextStyle(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 190,right: 10),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            elevation: 8,
                                            primary: mainRedShadeForTitle,
                                            fixedSize: Size(50, 50),
                                          ),
                                            onPressed: (){
                                            Navigator.pushNamed(context, AddNewNotes.id);
                                            },
                                            child: ImageIcon(AssetImage("assets/images/new note.png"))
                                        ),
                                      ),
                                    )

                                  ],
                                );

                                }
                                else{
                                  return   Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        height: 560,
                                        width: MediaQuery.of(context).size.width,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: StreamBuilder<NotesResponse>(
                                                  stream: userNotesBloc.notesFetchSCStreamListener,
                                                  builder: (context, snapshot) {
                                                    return ListView.builder(
                                                      itemCount: snapshot.data!.responseOfNotes!.length,
                                                      itemBuilder: (BuildContext context, index) {
                                                        return ListTile(
                                                          horizontalTitleGap: 30,

                                                          title: Text(
                                                            snapshot.data!.responseOfNotes![index].notes,
                                                            softWrap: true,
                                                            style: kQuranPageTabContentTitleStyle,
                                                          ),

                                                          leading: Container(
                                                            constraints: const BoxConstraints(
                                                                maxWidth: 50, maxHeight: 50),
                                                            decoration: const BoxDecoration(
                                                                image: DecorationImage(
                                                                  // alignment: Alignment.centerLeft,

                                                                    fit: BoxFit.contain,
                                                                    image: AssetImage(
                                                                        "assets/images/list_tile_leading.png"))),
                                                          ),

                                                          // color: mainRedShadeForTitle,
                                                        );
                                                      },
                                                      scrollDirection: Axis.vertical,
                                                      // controller: _scrollController,
                                                      physics: BouncingScrollPhysics(),
                                                    );
                                                  }
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      shape: CircleBorder(),
                                                      elevation: 8,
                                                      primary: mainRedShadeForTitle,
                                                      fixedSize: Size(50, 50),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushNamed(context, AddNewNotes.id);

                                                    },
                                                    child: ImageIcon(AssetImage(
                                                        "assets/images/new note.png"))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }

                              }

                            ),
                            )


                        ) : Container(),


                      ],

                    ),


              ),
            ],
          ),
        ),
      ],
    );
  }



}
