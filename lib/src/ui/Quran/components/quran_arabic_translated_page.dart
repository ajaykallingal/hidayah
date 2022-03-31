import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hidayah/src/ui/Quran/components/quran_translated_page_arguments.dart';
import 'package:hidayah/src/ui/Quran/components/search_bar_widget.dart';
import 'package:hidayah/src/ui/Quran/components/textStyle.dart';
import 'package:hidayah/src/ui/Quran/quran_screen.dart';
import 'package:hidayah/src/ui/more/text_style.dart';
import '../../../constants/text_style.dart';
import '../../../data/bloc/test_request_bloc.dart';
import '../../../data/models/quran_request.dart';
import '../../../data/models/quran_request_response.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
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
    with SingleTickerProviderStateMixin {
  List tabList = ["Arabic", "Translation", "Transilertaion"];
  int selectedTabIndex = 0;
  late TabController _tabController;

  ScrollController _scrollController = new ScrollController();

  final String languageId = "12";
  final String suratId = "2";
  final String ayathNo = "0";
  final String juzId = "0";
  final String ayathPageNo = "0";
  final String ayathAutoIncrId = "0";
  final String searchText = "";
  final String limitFrom = "10";
  final String limitTo = "20";
  final String voiceTypeId = "8";

  bool loading = true;
  bool selectedIndex = false;

  final testRequestBloc = TestRequestBloc();
  Response? responseDetails;
  List<DisplayWholeQuranFiltered>? displayWholeQuranFiltered;

  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  // int? newSelectedIndex;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: selectedTabIndex);
    _tabController.addListener(() {
      setState(() {

      });
    });

    // void _handleTabSelection(){
    //   setState(() {
    //
    //   });
    // }

    print("index${suratId}");
    // print("langId${widget.arguments.languageId}");
    testRequestBloc.quranFetchFiltered(
      request: QuranRequest(
        langId: languageId,
        suratId: suratId,
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    testRequestBloc.quranFetchSCStreamListener.listen((event) {
      setState(() {
        loading = false;
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
  Widget build(BuildContext context) {
    String audioUrl = "https://luan.xyz/files/audio/nasa_on_a_mission.mp3";

    return Stack(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SearchBarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, top: 3),
                    child: ListTile(
                      title:  Text(
          'Quran',
          style: kQuranPageHeadlineTextStyle,
        ),
                      leading:   IconButton(
            onPressed: (){
             Navigator.pushNamed(context, QuranScreen.id);
            },
            icon: Icon(Icons.arrow_back,color: Colors.white.withOpacity(1),),
        ),
                    ),
                    // Row(
                    //
                    //   children: [
                    //     IconButton(
                    //         onPressed: (){
                    //           Navigator.pop(context);
                    //         },
                    //         icon: Icon(Icons.arrow_back,color: Colors.white.withOpacity(1),),
                    //     ),
                    //     // SizedBox(width: 40),
                    //     Text(
                    //       'Quran',
                    //       style: kQuranPageHeadlineTextStyle,
                    //     ),
                    //
                    //   ],
                    // ),
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
                            // buildQuranPageCard(index),
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
                    initialIndex: selectedTabIndex,
                    length: 3,
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

                                      physics: BouncingScrollPhysics(),
                                      controller: _tabController,
                                      indicator: BubbleTabIndicator(

                                        // padding: EdgeInsets.all(10),
                                        indicatorColor: Colors.white.withOpacity(1),
                                        indicatorHeight: 35,

                                        // insets: EdgeInsets.all(2),
                                        indicatorRadius: 50,
                                        tabBarIndicatorSize: TabBarIndicatorSize
                                            .tab,
                                      ),
                                      indicatorColor: Colors.transparent,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      labelColor: mainRedShadeForTitle,
                                      unselectedLabelColor: Colors.white.withOpacity(1),
                                      unselectedLabelStyle: kQuranPageTabHeaderStyle,
                                      onTap: (index) {
                                        selectedTabIndex = index;
                                      },
                                      tabs: [

                                        Tab(

                                          text: "Arabic",
                                        ),

                                        Tab(
                                          text: "Translation",
                                        ),
                                        Tab(
                                          text: "Transileration",
                                        ),
                                        // Tab(
                                        //   icon: ImageIcon(AssetImage(
                                        //       "assets/images/SETTINGS.png")),
                                        //   // text: "Arabic",
                                        // ),


                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                       showModalBottomSheet(
                                           context: context,
                                           elevation: 5,
                                           backgroundColor: Colors.white.withOpacity(1),

                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                             
                                           ),
                                           builder: (BuildContext context){
                                             return Container(
                                               height: MediaQuery.of(context).size.height / 2.1,
                                               child: Column(
                                                 children: [
                                                   SizedBox(height: 20),
                                                  Text("Font Settings"),

                                             //    FlutterToggleTab(
                                             //        labels: ['Display','Audio'],
                                             //        selectedLabelIndex:  (index) {
                                             //
                                             // print("Selected Index $index");
                                             // },
                                             //        selectedTextStyle: kQuranPageTabHeaderStyle,
                                             //        unSelectedTextStyle: kQuranPageTabContentSubTitleStyle,
                                             //        selectedIndex: _selectedIndex,
                                             //      // icons: [ImageIcon(AssetImage("assets/images/DISPLAY.png"))],
                                             //    ),
                                                 ],
                                               ),

                                             );
                                           }
                                       );
                                      },
                                      icon: ImageIcon(AssetImage("assets/images/SETTINGS.png"),color: Colors.white.withOpacity(1),)
                                  ),
                                ],
                              ),
                              Container(

                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(1),

                                    borderRadius: BorderRadius.circular(20)),
                                // foregroundDecoration: BoxDecoration(
                                //   color: Colors.white.withOpacity(1),
                                //
                                //   borderRadius: BorderRadius.circular(20),
                                // ),

                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: _tabController,
                                  children: [
                                    loading
                                        ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                        : buildArabicTab(audioUrl),

                                    loading ?
                                    ListView.builder(
                                      itemCount:
                                      displayWholeQuranFiltered!.length ,
                                      itemBuilder:
                                          (BuildContext context, index) {

                                        return Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                width:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF0F0F0)
                                                      .withOpacity(1),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(7.0),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                        mainRedShadeForTitle,
                                                        // radius: 10,
                                                        child: Text(
                                                            displayWholeQuranFiltered![
                                                            index]
                                                                .ayatNumber,
                                                            style: TextStyle(
                                                                fontSize:
                                                                12)),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: ImageIcon(
                                                        AssetImage(
                                                            "assets/images/PLAY.png"),
                                                        size: 25,
                                                        color: Color(
                                                            0xFF5D5D5D)
                                                            .withOpacity(1),
                                                      ),
                                                      onPressed: () {
                                                        print(audioUrl);

                                                        audioPlayer.play(
                                                            audioUrl,
                                                            isLocal: true);
                                                        audioPlayer.stop();
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      displayWholeQuranFiltered!.length.toString(),

                                                      // displayWholeQuranFiltered![
                                                      // index]
                                                      //     .ayatText,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ) : Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),),

                                    ListView.builder(
                                      itemBuilder: (BuildContext context,
                                          index) {
                                        return ListTile(
                                          title: Text(
                                            "data",
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                          leading: ImageIcon(
                                            AssetImage(
                                                "assets/images/READ_QURAN.png"),
                                            color: mainRedShadeForTitle,
                                          ),
                                          trailing: ImageIcon(
                                            AssetImage(
                                              "assets/images/HEART_STROKE.png",
                                            ),
                                            color: mainRedShadeForTitle,
                                          ),
                                        );
                                      },
                                      itemCount: 10,
                                      scrollDirection: Axis.vertical,
                                      controller: _scrollController,
                                      physics: BouncingScrollPhysics(),
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


                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ListView buildArabicTab(String audioUrl) {
    return ListView.builder(
       physics: BouncingScrollPhysics(),
      itemCount:
      displayWholeQuranFiltered!.length,
      itemBuilder:
          (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Container(
            child: Column(
              children: [
                Container(
                  width:
                  MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0)
                        .withOpacity(1),
                    borderRadius:
                    BorderRadius.circular(
                        8),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets
                            .all(7.0),
                        child: CircleAvatar(
                          backgroundColor:
                          mainRedShadeForTitle,
                          // radius: 10,
                          child: Text(
                              displayWholeQuranFiltered![
                              index]
                                  .ayatNumber,
                              style: TextStyle(
                                  fontSize:
                                  12)),
                        ),
                      ),
                      IconButton(
                        icon: ImageIcon(
                          AssetImage(
                              "assets/images/PLAY.png"),
                          size: 25,
                          color: Color(
                              0xFF5D5D5D)
                              .withOpacity(1),
                        ),
                        onPressed: () {
                          print(audioUrl);

                          audioPlayer.play(
                              audioUrl,
                              isLocal: true);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        displayWholeQuranFiltered![
                        index]
                            .ayatText,
                        softWrap: true,
                        style: TextStyle(
                            color:
                            Colors.black),
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
}
