import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hidayah/src/ui/Quran/components/quran_translated_page_arguments.dart';
import 'package:hidayah/src/ui/Quran/components/search_bar_widget.dart';
import 'package:hidayah/src/ui/Quran/components/textStyle.dart';
import 'package:hidayah/src/ui/Quran/quran_screen.dart';
import 'package:hidayah/src/ui/more/text_style.dart';
import '../../../constants/text_style.dart';
import '../../../data/bloc/quran_request_bloc.dart';
import '../../../data/models/quran_request.dart';
import '../../../data/models/quran_request_response.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

import '../../../data/models/surah/surah_response.dart';
import '../../../data/models/surat_model.dart';

class QuranArabicTranslatedPage extends StatefulWidget {
  static const String id = 'quran_arabic_screen';

  // final int suratId;
  // final QuranTranslatedPageArguments arguments;
  const QuranArabicTranslatedPage({Key? key}) : super(key: key);

  @override
  State<QuranArabicTranslatedPage> createState() =>
      _QuranArabicTranslatedPageState();
}

class _QuranArabicTranslatedPageState extends State<QuranArabicTranslatedPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  List tabList = ["Arabic", "Translation"];
  int selectedTabIndex = 0;
  late TabController _tabController;

  ScrollController _scrollController = new ScrollController();
  List<SurahResponse> surahList = List.empty(growable: true);

  final String languageId = "12";
  final String suratId = "0";
  final String ayathNo = "0";
  final String juzId = "0";
  final String ayathPageNo = "0";
  final String ayathAutoIncrId = "0";
  final String searchText = "";
  final String limitFrom = "0";
  final String limitTo = "286";
  final String voiceTypeId = "8";

  bool loading = true;
  bool selectedIndex = false;

  final quranRequestBloc = QuranRequestBloc();
  Response? responseDetails;
  List<DisplayWholeQuranFiltered>? displayWholeQuranFiltered;

  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  // int? newSelectedIndex;
  bool callOneTime = true;
  int index = 0;
  bool startAndPause = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController =
        TabController(length: 2, vsync: this, initialIndex: selectedTabIndex);
    _tabController.addListener(() {
      setState(() {});
    });

    // void _handleTabSelection(){
    //   setState(() {
    //
    //   });
    // }

    // print("surahID${arguments.surathId}");
    // print("langId${widget.arguments.languageId}");
    // testRequestBloc.quranFetchFiltered(
    //   request: QuranRequest(
    //     langId: languageId,
    //     suratId: suratId,
    //     ayathNo: ayathNo,
    //     juzId: juzId,
    //     ayathPageNo: ayathPageNo,
    //     ayatAutoIncrId: ayathAutoIncrId,
    //     searchText: searchText,
    //     limitFrom: limitFrom,
    //     limitTo: limitTo,
    //     voiceTypeId: voiceTypeId,
    //   ),
    // );

    surahList.addAll(List<SurahResponse>.from(
        SuratModel.surahList.map((x) => SurahResponse.fromJson(x))));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    quranRequestBloc.quranFetchSCStreamListener.listen((event) {
      setState(() {
        loading = false;
        callOneTime = false;
        displayWholeQuranFiltered = event.displayWholeQuranFiltered;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused){
      audioPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as QuranTranslatedPageArguments;

    if (callOneTime) {
      print("SID:${arguments.surathId}");
      print("LID:${arguments.languageId}");
      quranRequestBloc.quranFetchFiltered(
        request: QuranRequest(
          langId:selectedTabIndex == 0 ? "3" : arguments.languageId,
          suratId: arguments.surathId,
          ayathNo: ayathNo,
          juzId: juzId,
          ayathPageNo: ayathPageNo,
          ayatAutoIncrId: ayathAutoIncrId,
          searchText: searchText,
          limitFrom: limitFrom,
          limitTo: limitTo,
          voiceTypeId: voiceTypeId,
        ),
      );
    }
    // final String audioUrl = displayWholeQuranFiltered![index].fileName;

    return Stack(
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
              radius: 1.9,
              focal: Alignment.topCenter,
              // focalRadius: 1.0,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_pattern.png'),
            ),
          ),
        ),
        SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child:loading ? Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),) : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SearchBarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, top: 3),
                    child: ListTile(
                      title: Text(
                        'Quran',
                        style: kQuranPageHeadlineTextStyle,
                      ),
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white.withOpacity(1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 346,
                          child: Image.asset("assets/images/quran.png"),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 10, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildQuranTranslatedPageCard(index),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: 400,
                  //   width: 346,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //   ),
                  //     ),
                  DefaultTabController(
                    initialIndex: 0,
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TabBar(

                                      labelPadding: EdgeInsets.all(2),
                                      isScrollable: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      controller: _tabController,
                                      indicator: BubbleTabIndicator(
                                        // padding: EdgeInsets.all(10),
                                        indicatorColor:
                                            Colors.white.withOpacity(1),
                                        indicatorHeight: 35,

                                        // insets: EdgeInsets.all(2),
                                        indicatorRadius: 50,
                                        tabBarIndicatorSize:
                                            TabBarIndicatorSize.tab,
                                      ),
                                      indicatorColor: Colors.transparent,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      labelColor: mainRedShadeForTitle,
                                      unselectedLabelColor:
                                          Colors.white.withOpacity(1),
                                      unselectedLabelStyle:
                                          kQuranPageTabHeaderStyle,
                                      onTap: (index) {
                                        setState(() {
                                          selectedTabIndex = index;
                                          _tabController.animateTo(index);

                                        });
                                        quranRequestBloc.quranFetchFiltered(
                                          request: QuranRequest(
                                            langId:selectedTabIndex == 0 ? "3" : arguments.languageId,
                                            suratId: arguments.surathId,
                                            ayathNo: ayathNo,
                                            juzId: juzId,
                                            ayathPageNo: ayathPageNo,
                                            ayatAutoIncrId: ayathAutoIncrId,
                                            searchText: searchText,
                                            limitFrom: limitFrom,
                                            limitTo: limitTo,
                                            voiceTypeId: voiceTypeId,
                                          ),
                                        );
                                       print(selectedTabIndex);
                                       print("tabController:${_tabController.index}");
                                       setState(() {
                                         loading = true;
                                       });

    },
                                      tabs: const [
                                        Tab(
                                          text: "Arabic",
                                        ),

                                        Tab(
                                          text: "Translation",
                                        ),

                                        // Tab(
                                        //   icon: ImageIcon(AssetImage(
                                        //       "assets/images/SETTINGS.png")),
                                        //   // text: "Arabic",
                                        // ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),

                              SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child:

                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(1),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: TabBarView(
                                    // dragStartBehavior: DragStartBehavior.start,
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _tabController,
                                    children: [

                                           buildArabicTab(),
                                     buildTranslationTab(),
                                     // buildTransilerationTab(),
                                    ],
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
            ),
          ),
        ),
      ],
    );
  }

  Widget buildArabicTab() {


    return
      ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount:
                int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
            itemBuilder: (BuildContext context, index) {
              print(
                int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
              );
              return

                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:


                Container(
                  child:

                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0).withOpacity(1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: CircleAvatar(
                                backgroundColor: mainRedShadeForTitle,
                                // radius: 10,
                                child: Text(
                                    displayWholeQuranFiltered![index]
                                        .ayatNumberInsurat,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             startAndPause ? Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),) : IconButton(
                                 splashRadius: 30,
                                 splashColor: mainRedShadeForTitle,

                                 icon: ImageIcon(
                                   AssetImage("assets/images/PLAY.png"),
                                   size: 25,
                                   color: Color(0xFF5D5D5D).withOpacity(1),
                                 ),
                                 onPressed: () async{
                                   // audioPlayer.stop();

                                  await audioPlayer.play(displayWholeQuranFiltered![index].fileName, isLocal: true);
                                 },
                               ),

                             IconButton(
                               splashColor: mainRedShadeForTitle,
                               icon: ImageIcon(
                                 AssetImage("assets/images/pause-button.png"),
                                 size: 25,
                                 color: Color(0xFF5D5D5D).withOpacity(1),
                               ),
                               onPressed: () async{
                                await audioPlayer.pause();

                                 // audioPlayer.play(audioUrl, isLocal: true);
                               },
                             ),
                             IconButton(
                               splashColor: mainRedShadeForTitle,
                               icon: ImageIcon(
                                 AssetImage("assets/images/stop-button.png"),
                                 size: 25,
                                 color: Color(0xFF5D5D5D).withOpacity(1),
                               ),
                               onPressed: () async{
                               await  audioPlayer.stop();

                                 // audioPlayer.play(audioUrl, isLocal: true);
                               },
                             ),
                           ],
                         ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right:8),
                              child: Text(
                                displayWholeQuranFiltered![index].ayatText,
                                softWrap: true,
                                textDirection: TextDirection.rtl,
                                // textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget buildTranslationTab() {
    return
      ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount:
                int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
            itemBuilder: (BuildContext context, index) {
              print(
                int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
              );
              return

                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:

                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0).withOpacity(1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: CircleAvatar(
                                backgroundColor: mainRedShadeForTitle,
                                // radius: 10,
                                child: Text(
                                    displayWholeQuranFiltered![index]
                                        .ayatNumber,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                startAndPause ? Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),) : IconButton(
                                  splashRadius: 30,
                                  splashColor: mainRedShadeForTitle,

                                  icon: ImageIcon(
                                    AssetImage("assets/images/PLAY.png"),
                                    size: 25,
                                    color: Color(0xFF5D5D5D).withOpacity(1),
                                  ),
                                  onPressed: () async{
                                    // audioPlayer.stop();

                                    await audioPlayer.play(displayWholeQuranFiltered![index].fileName, isLocal: true);
                                  },
                                ),

                                IconButton(
                                  splashColor: mainRedShadeForTitle,
                                  icon: ImageIcon(
                                    AssetImage("assets/images/pause-button.png"),
                                    size: 25,
                                    color: Color(0xFF5D5D5D).withOpacity(1),
                                  ),
                                  onPressed: () async{
                                    await audioPlayer.pause();

                                    // audioPlayer.play(audioUrl, isLocal: true);
                                  },
                                ),
                                IconButton(
                                  splashColor: mainRedShadeForTitle,
                                  icon: ImageIcon(
                                    AssetImage("assets/images/stop-button.png"),
                                    size: 25,
                                    color: Color(0xFF5D5D5D).withOpacity(1),
                                  ),
                                  onPressed: () async{
                                    await  audioPlayer.stop();

                                    // audioPlayer.play(audioUrl, isLocal: true);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              displayWholeQuranFiltered![index].ayatText,
                              softWrap: true,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget buildTransilerationTab() {
    return
      ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount:
                int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
            itemBuilder: (BuildContext context, index) {
              print(
                int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
              );
              return
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:

                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0).withOpacity(1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: CircleAvatar(
                                backgroundColor: mainRedShadeForTitle,
                                // radius: 10,
                                child: Text(
                                    displayWholeQuranFiltered![index]
                                        .ayatNumber,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                startAndPause ? Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),) : IconButton(
                                  splashRadius: 30,
                                  splashColor: mainRedShadeForTitle,

                                  icon: ImageIcon(
                                    AssetImage("assets/images/PLAY.png"),
                                    size: 25,
                                    color: Color(0xFF5D5D5D).withOpacity(1),
                                  ),
                                  onPressed: () async{
                                    // audioPlayer.stop();

                                    await audioPlayer.play(displayWholeQuranFiltered![index].fileName, isLocal: true);
                                  },
                                ),

                                IconButton(
                                  splashColor: mainRedShadeForTitle,
                                  icon: ImageIcon(
                                    AssetImage("assets/images/pause-button.png"),
                                    size: 25,
                                    color: Color(0xFF5D5D5D).withOpacity(1),
                                  ),
                                  onPressed: () async{
                                    await audioPlayer.pause();

                                    // audioPlayer.play(audioUrl, isLocal: true);
                                  },
                                ),
                                IconButton(
                                  splashColor: mainRedShadeForTitle,
                                  icon: ImageIcon(
                                    AssetImage("assets/images/stop-button.png"),
                                    size: 25,
                                    color: Color(0xFF5D5D5D).withOpacity(1),
                                  ),
                                  onPressed: () async{
                                    await  audioPlayer.stop();

                                    // audioPlayer.play(audioUrl, isLocal: true);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              displayWholeQuranFiltered![index].ayatText,
                              softWrap: true,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget buildQuranTranslatedPageCard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Last read",style: kQuranPageBoxSubTitleStyle1,),
        SizedBox(height: 20),
        Text(
          displayWholeQuranFiltered![index].suratEngName!,
          style: kQuranPageBoxTitleStyle1,
        ),
        Text(
          displayWholeQuranFiltered![index].suartEnglishTranslation!,
          style: kQuranPageBoxSubTitleStyle1,
        ),
        Divider(
          color: Colors.white.withOpacity(1),
          // indent: 50,
          endIndent: 230,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(displayWholeQuranFiltered![index].suartRevelationCity,
              style: kQuranPageBoxSubTitleStyle1),
        ),
      ],
    );
  }
}
