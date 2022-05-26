import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hidayah/src/constants/font_family.dart';
import 'package:hidayah/src/ui/Quran/components/my_audio_player.dart';
import 'package:hidayah/src/ui/Quran/components/page_manager.dart';
import 'package:hidayah/src/ui/Quran/components/quran_translated_page_arguments.dart';
import 'package:hidayah/src/ui/Quran/components/search_bar_widget.dart';
import 'package:hidayah/src/ui/Quran/components/textStyle.dart';
import 'package:hidayah/src/ui/Quran/quran_screen.dart';
import 'package:hidayah/src/ui/more/text_style.dart';
import 'package:provider/provider.dart';
import '../../../constants/text_style.dart';
import '../../../data/bloc/quran_request_bloc.dart';
import '../../../data/models/quran_request.dart';
import '../../../data/models/quran_request_response.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

import '../../../data/models/surah/surah_response.dart';
import '../../../data/models/surat_model.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
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

  // AudioCache audioCache = AudioCache();
  // late final AudioPlayer audioPlayer;
  // late final StreamSubscription progressSubscription;

  bool callOneTime = true;
  int index = 0;
  bool isPaused = false;
  bool isPlaying = false;
  bool showAudioPlayer = false;
  int currentIndex = 0;

  // final progressStreamController = StreamController<double>();
  // Stream<double> get progressStream => progressStreamController.stream;
  // Stream<PlayerState> get stateStream => audioPlayer.onPlayerStateChanged;

  // Future<void> init()async{
  //   audioPlayer = await AudioCache().play(fileName)
  // }

  // late final Duration totalDuration;
  // late final Duration position;
  // late final String audioState;
  late final PageManager _pageManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageManager = PageManager();
///audioplayers package
    // audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    // audioCache.loadedFiles;
    // audioPlayer.setReleaseMode(ReleaseMode.STOP);
// audioPlayer!.onPlayerCompletion.listen((event) {
//   setState(() {
//     if()
//   });
// });
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
    _tabController.dispose();
    _pageManager.dispose();
    super.dispose();

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _pageManager.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final footer = showAudioPlayer ? createAudioPlayer() : null;
    final arguments = ModalRoute.of(context)!.settings.arguments
        as QuranTranslatedPageArguments;

    if (callOneTime) {
      print("SID:${arguments.surathId}");
      print("LID:${arguments.languageId}");
      quranRequestBloc.quranFetchFiltered(
        request: QuranRequest(
          langId: selectedTabIndex == 0 ? "3" : arguments.languageId,
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

    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        backgroundColor: Colors.white.withOpacity(1),
        buttonColor: mainRedShadeForTitle,
      ),
      child: Scaffold(
        // extendBody: true,
        extendBodyBehindAppBar: true,
        persistentFooterButtons: footer,
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
                child: CustomScrollView(
                  shrinkWrap: true,
                  anchor: 0.0,
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: Container(),
                      // leading: IconButton(
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //   },
                      //   icon: Icon(
                      //     Icons.arrow_back_sharp,
                      //     color: Colors.white.withOpacity(1),
                      //   ),
                      // ),
                      backgroundColor: Colors.transparent,
                      title: Text(
                        'Quran',
                        style: kQuranPageHeadlineTextStyle,
                      ),
                      pinned: true,
                      // floating: true,
                      // pinned: true,

                      expandedHeight: 250,
                      flexibleSpace: FlexibleSpaceBar(

                        background: Column(
                          children: [
                            ListTile(
                              // title: Text(
                              //   'Quran',
                              //   style: kQuranPageHeadlineTextStyle,
                              // ),
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
                            Container(
                              height: 120,
                              width: 346,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage("assets/images/quran.png"),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(arguments.surahName,style: kQuranPageBoxTitleStyle1,),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 27),
                                      child: Text(arguments.totalVerse,style: kQuranPageBoxSubTitleStyle1,textAlign: TextAlign.center,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize:
                            Size(MediaQuery.of(context).size.width, 38),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              // height: 70,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TabBar(
                                      labelPadding: EdgeInsets.all(2),
                                      isScrollable: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      controller: _tabController,
                                      indicator: BubbleTabIndicator(
                                        // padding: EdgeInsets.all(10),
                                        indicatorColor: Colors.white.withOpacity(1),

                                        indicatorHeight: 35,

                                        // insets: EdgeInsets.all(2),
                                        indicatorRadius: 50,
                                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                      ),
                                      indicatorColor: Colors.transparent,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      labelColor: mainRedShadeForTitle,
                                      unselectedLabelColor:
                                          Colors.white.withOpacity(1),
                                      unselectedLabelStyle: kQuranPageTabHeaderStyle,
                                      onTap: (index) {
                                        setState(() {
                                          selectedTabIndex = index;
                                          // _tabController.animateTo(index);
                                        });
                                        quranRequestBloc.quranFetchFiltered(
                                          request: QuranRequest(
                                            langId: selectedTabIndex == 0
                                                ? "3"
                                                : arguments.languageId,
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
                                        print(
                                            "tabController:${_tabController.index}");
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
                            ),
                          ),
                        ),
                      ),

                      //               ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          DefaultTabController(
                            initialIndex: 0,
                            length: 2,
                            child: Stack(
                              children: [
                                loading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: mainRedShadeForTitle,
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(8),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: TabBarView(
                                                  // dragStartBehavior: DragStartBehavior.start,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  controller: _tabController,
                                                  children: [
                                                    buildArabicTab(),
                                                    buildTranslationTab(),
                                                    // buildTransilerationTab(),
                                                  ],
                                                ),
                                              ),
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

                // loading ? Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),) : SingleChildScrollView(
                //  physics: BouncingScrollPhysics(),
                //  child: Column(
                //    crossAxisAlignment: CrossAxisAlignment.start,
                //    children: [
                //      // SearchBarWidget(),
                //      Padding(
                //        padding: const EdgeInsets.only(left: 3, top: 3),
                //        child: ListTile(
                //          title: Text(
                //            'Quran',
                //            style: kQuranPageHeadlineTextStyle,
                //          ),
                //          leading: IconButton(
                //            onPressed: () {
                //              Navigator.pop(context);
                //            },
                //            icon: Icon(
                //              Icons.arrow_back,
                //              color: Colors.white.withOpacity(1),
                //            ),
                //          ),
                //        ),
                //      ),
                //      SizedBox(height: 8),
                //      Stack(
                //        children: [
                //          Padding(
                //            padding: const EdgeInsets.all(8.0),
                //            child: Container(
                //              height: 120,
                //              width: 346,
                //              child: Image.asset("assets/images/quran.png"),
                //            ),
                //          ),
                //          Padding(
                //            padding:
                //                const EdgeInsets.only(left: 25, right: 10, top: 25),
                //            child: Column(
                //              crossAxisAlignment: CrossAxisAlignment.start,
                //              children: [
                //                buildQuranTranslatedPageCard(index),
                //              ],
                //            ),
                //          ),
                //        ],
                //      ),
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
                //               DefaultTabController(
                //                 initialIndex: 0,
                //                 length: 2,
                //                 child: Column(
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.only(left: 15, right: 15),
                //                       child: Column(
                //                         children: [
                //                           Row(
                //                             children: [
                //                               Expanded(
                //                                 child: TabBar(
                //
                //                                   labelPadding: EdgeInsets.all(2),
                //                                   isScrollable: false,
                //                                   physics: NeverScrollableScrollPhysics(),
                //                                   controller: _tabController,
                //                                   indicator: BubbleTabIndicator(
                //                                     // padding: EdgeInsets.all(10),
                //                                     indicatorColor:
                //                                         Colors.white.withOpacity(1),
                //                                     indicatorHeight: 35,
                //
                //                                     // insets: EdgeInsets.all(2),
                //                                     indicatorRadius: 50,
                //                                     tabBarIndicatorSize:
                //                                         TabBarIndicatorSize.tab,
                //                                   ),
                //                                   indicatorColor: Colors.transparent,
                //                                   indicatorSize: TabBarIndicatorSize.tab,
                //                                   labelColor: mainRedShadeForTitle,
                //                                   unselectedLabelColor:
                //                                       Colors.white.withOpacity(1),
                //                                   unselectedLabelStyle:
                //                                       kQuranPageTabHeaderStyle,
                //                                   onTap: (index) {
                //                                     setState(() {
                //                                       selectedTabIndex = index;
                //                                       _tabController.animateTo(index);
                //
                //                                     });
                //                                     quranRequestBloc.quranFetchFiltered(
                //                                       request: QuranRequest(
                //                                         langId:selectedTabIndex == 0 ? "3" : arguments.languageId,
                //                                         suratId: arguments.surathId,
                //                                         ayathNo: ayathNo,
                //                                         juzId: juzId,
                //                                         ayathPageNo: ayathPageNo,
                //                                         ayatAutoIncrId: ayathAutoIncrId,
                //                                         searchText: searchText,
                //                                         limitFrom: limitFrom,
                //                                         limitTo: limitTo,
                //                                         voiceTypeId: voiceTypeId,
                //                                       ),
                //                                     );
                //                                    print(selectedTabIndex);
                //                                    print("tabController:${_tabController.index}");
                //                                    setState(() {
                //                                      loading = true;
                //                                    });
                //
                // },
                //                                   tabs: const [
                //                                     Tab(
                //                                       text: "Arabic",
                //                                     ),
                //
                //                                     Tab(
                //                                       text: "Translation",
                //                                     ),
                //
                //                                     // Tab(
                //                                     //   icon: ImageIcon(AssetImage(
                //                                     //       "assets/images/SETTINGS.png")),
                //                                     //   // text: "Arabic",
                //                                     // ),
                //                                   ],
                //                                 ),
                //                               ),
                //
                //                             ],
                //                           ),
                //
                //                           SingleChildScrollView(
                //                             physics: BouncingScrollPhysics(),
                //                             child:
                //
                //                             Container(
                //                               margin: EdgeInsets.all(8),
                //                               padding: EdgeInsets.all(8),
                //                               decoration: BoxDecoration(
                //                                   color: Colors.white.withOpacity(1),
                //                                   borderRadius: BorderRadius.circular(20)),
                //                               height: MediaQuery.of(context).size.height,
                //                               width: MediaQuery.of(context).size.width,
                //                               child: TabBarView(
                //                                 // dragStartBehavior: DragStartBehavior.start,
                //                                 physics: NeverScrollableScrollPhysics(),
                //                                 controller: _tabController,
                //                                 children: [
                //
                //                                        buildArabicTab(),
                //                                  buildTranslationTab(),
                //                                  // buildTransilerationTab(),
                //                                 ],
                //                               ),
                //                             ),
                //                           ),
                //
                //                         ],
                //                       ),
                //                     ),
                //     ],
                //   ),
                // ),

                // ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildArabicTab() {
    return Stack(
      children: [
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount:
              int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
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
                                      .ayatNumberInsurat,
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     startAndPause
                          //         ? Center(
                          //             child: CircularProgressIndicator(
                          //               color: mainRedShadeForTitle,
                          //             ),
                          //           )
                          //         : IconButton(
                          //             splashRadius: 30,
                          //             splashColor: mainRedShadeForTitle,
                          //             icon: ImageIcon(
                          //               AssetImage("assets/images/PLAY.png"),
                          //               size: 25,
                          //               color: Color(0xFF5D5D5D).withOpacity(1),
                          //             ),
                          //             onPressed: () async {
                          //               // audioPlayer.stop();
                          //
                          //               await audioPlayer.play(
                          //                   displayWholeQuranFiltered![index]
                          //                       .fileName,
                          //                   isLocal: true);
                          //             },
                          //           ),
                          //     IconButton(
                          //       splashColor: mainRedShadeForTitle,
                          //       icon: ImageIcon(
                          //         AssetImage("assets/images/pause-button.png"),
                          //         size: 25,
                          //         color: Color(0xFF5D5D5D).withOpacity(1),
                          //       ),
                          //       onPressed: () async {
                          //         await audioPlayer.pause();
                          //
                          //         // audioPlayer.play(audioUrl, isLocal: true);
                          //       },
                          //     ),
                          //     IconButton(
                          //       splashColor: mainRedShadeForTitle,
                          //       icon: ImageIcon(
                          //         AssetImage("assets/images/stop-button.png"),
                          //         size: 25,
                          //         color: Color(0xFF5D5D5D).withOpacity(1),
                          //       ),
                          //       onPressed: () async {
                          //         await audioPlayer.stop();
                          //
                          //         // audioPlayer.play(audioUrl, isLocal: true);
                          //       },
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap:(){
                              _pageManager.setUrl(displayWholeQuranFiltered![index].fileName);
                              setState(() {
                                showAudioPlayer = true;
                              });

                              _pageManager.play(displayWholeQuranFiltered![index].fileName);

                            },
                            child: Align(

                              child: Text(
                                displayWholeQuranFiltered![index].ayatText,
                                softWrap: true,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: kQuranPageArabicTabStyle,
                              ),
                              alignment: Alignment.centerRight,
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
        ),
      ],
    );
  }

  List<Widget> createAudioPlayer(){
    return [
      Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Column(
          // mainAxisSize: MainAxisSize.max,

          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(
                //     iconSize: 30,
                //     onPressed: (){
                //       _pageManager.play(displayWholeQuranFiltered![index-1].fileName);
                //     },
                //     icon: const Icon(Icons.skip_previous_sharp)
                // ),
                ValueListenableBuilder<ButtonState>(
                    valueListenable:  _pageManager.buttonNotifier,
                    builder: (_,value,__) {
                      switch (value){
                        case ButtonState.loading:
                          return Row(
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 25.0,
                                  height: 25.0,
                                  child: CircularProgressIndicator(color: mainRedShadeForTitle,),
                                ),
                              ),
                            ],
                          );
                        case ButtonState.paused:
                          return IconButton(
                            iconSize: 40,
                            color: mainRedShadeForTitle,
                            onPressed: (){
                              _pageManager.play(displayWholeQuranFiltered![index].fileName);

                            },
                            icon: Icon(Icons.play_circle_fill_outlined),
                          );
                        case ButtonState.playing:
                          return IconButton(
                            iconSize: 40,
                            color: mainRedShadeForTitle,
                              onPressed: (){
                                _pageManager.pause;

                              },
                              icon: Icon(Icons.pause_circle_filled_outlined)
                          );



                      }
                    }

                ),
                // IconButton(
                //   iconSize: 30,
                //     onPressed: (){
                //     _pageManager.seekToNext();
                //     },
                //     icon: Icon(Icons.skip_next_sharp,)
                // ),
              ],

            ),
            // SizedBox(height: 10),
            // Spacer(),
            Flexible(
              child: ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _pageManager.progressNotifier,
                  builder: (_,value,__){
                    return ProgressBar(

                      barHeight: 3,

                      progressBarColor: mainRedShadeForTitle,
                      bufferedBarColor: mainRedShadeForText,
                      thumbColor: mainRedShadeForTitle,
                      thumbRadius: 6,
                      progress: value.current,
                      total: value.total,
                      buffered: value.buffered,
                      onSeek: _pageManager.seek,
                      timeLabelTextStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontFamily.sfProDisplay
                      ),

                    );
                  }
              ),
            ),

          ],
        ),
      ),
    ];
  }

  Widget buildTranslationTab() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount:
          int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
      itemBuilder: (BuildContext context, index) {
        print(
          int.parse(displayWholeQuranFiltered![index].suartNumberOfAyats),
        );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Container(
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
                              displayWholeQuranFiltered![index].ayatNumber,
                              style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     startAndPause
                      //         ? Center(
                      //             child: CircularProgressIndicator(
                      //               color: mainRedShadeForTitle,
                      //             ),
                      //           )
                      //         : IconButton(
                      //             splashRadius: 30,
                      //             splashColor: mainRedShadeForTitle,
                      //             icon: ImageIcon(
                      //               AssetImage("assets/images/PLAY.png"),
                      //               size: 25,
                      //               color: Color(0xFF5D5D5D).withOpacity(1),
                      //             ),
                      //             onPressed: () async {
                      //               // audioPlayer.stop();
                      //
                      //               await audioPlayer.play(
                      //                   displayWholeQuranFiltered![index]
                      //                       .fileName,
                      //                   isLocal: true);
                      //             },
                      //           ),
                      //     IconButton(
                      //       splashColor: mainRedShadeForTitle,
                      //       icon: ImageIcon(
                      //         AssetImage("assets/images/pause-button.png"),
                      //         size: 25,
                      //         color: Color(0xFF5D5D5D).withOpacity(1),
                      //       ),
                      //       onPressed: () async {
                      //         await audioPlayer.pause();
                      //
                      //         // audioPlayer.play(audioUrl, isLocal: true);
                      //       },
                      //     ),
                      //     IconButton(
                      //       splashColor: mainRedShadeForTitle,
                      //       icon: ImageIcon(
                      //         AssetImage("assets/images/stop-button.png"),
                      //         size: 25,
                      //         color: Color(0xFF5D5D5D).withOpacity(1),
                      //       ),
                      //       onPressed: () async {
                      //         await audioPlayer.stop();
                      //
                      //         // audioPlayer.play(audioUrl, isLocal: true);
                      //       },
                      //     ),
                      //   ],
                      // ),
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

  // List<Widget> createAudioPlayer() {
  //   return [
  //     ClipRRect(
  //       borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(10), topLeft: Radius.circular(10)),
  //       child: Container(
  //         height: 60,
  //         width: MediaQuery.of(context).size.width,
  //         decoration: const BoxDecoration(
  //           borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(10), topLeft: Radius.circular(10)),
  //         ),
  //         child: Column(
  //           children: [
  //             Flexible(
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(bottom: 0, top: 0),
  //                       child: Consumer<MyAudioPlayer>(
  //                         builder: (_, myAudioPlayer, child) => IconButton(
  //                           iconSize: 40,
  //                           padding: EdgeInsets.zero,
  //                           onPressed: () {
  //                             // myAudioPlayer.playerState == "Playing"
  //                             //     ? myAudioPlayer.pauseAudio()
  //                             //     : myAudioPlayer.playAudio(
  //                             //         displayWholeQuranFiltered![index]
  //                             //             .fileName,
  //                             //       );
  //                             // myAudioPlayer.releaseModeAudio();
  //
  //                             if (isPlaying == true &&
  //                                 showAudioPlayer &&
  //                                 myAudioPlayer.playerState == "Playing") {
  //                               myAudioPlayer.pauseAudio();
  //                               setState(() {
  //                                 isPlaying = false;
  //                               });
  //                             } else if (isPlaying == false &&
  //                                 showAudioPlayer &&
  //                                 myAudioPlayer.playerState == "Paused") {
  //                               myAudioPlayer.playAudio(
  //                                 displayWholeQuranFiltered![index]
  //                                     .fileName,
  //                               );
  //                               setState(() {
  //                                 isPlaying = !isPlaying;
  //                               });
  //                             }
  //                           },
  //                           icon:
  //                           myAudioPlayer.playerState == "Playing"
  //                               ? Icon(Icons.play_circle_fill_rounded,
  //                                   color: mainRedShadeForTitle)
  //                               : Icon(
  //                                   Icons.pause_circle_filled_rounded,
  //                                   color: mainRedShadeForTitle,
  //                                 ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   // Expanded(
  //                   //   child: IconButton(
  //                   //       onPressed: () {},
  //                   //       icon: Icon(Icons.play_circle_fill_rounded)),
  //                   // ),
  //                   // Expanded(
  //                   //   child: IconButton(
  //                   //       onPressed: () {},
  //                   //       icon: Icon(Icons.play_circle_fill_rounded)),
  //                   // ),
  //                   // Expanded(
  //                   //   child: IconButton(
  //                   //       onPressed: () {},
  //                   //       icon: Icon(Icons.play_circle_fill_rounded)),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Flexible(
  //               child: SliderTheme(
  //                 data: const SliderThemeData(
  //                   trackHeight: 1,
  //                   thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
  //                 ),
  //                 child: Consumer<MyAudioPlayer>(
  //                   builder: (_, myAudioPlayer, child) => Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Slider(
  //                       value: myAudioPlayer.position == null
  //                           ? 1.0
  //                           : myAudioPlayer.position!.inMilliseconds.toDouble(),
  //                       activeColor: mainRedShadeForTitle,
  //                       inactiveColor: lightGreyShadeForText,
  //                       onChanged: (value) {
  //                         myAudioPlayer.seekAudio(
  //                             Duration(milliseconds: value.toInt().round()));
  //                       },
  //                       min: 0.0,
  //                       max: myAudioPlayer.totalDuration == null
  //                           ? 20.0
  //                           : myAudioPlayer.totalDuration!.inMilliseconds
  //                               .toDouble(),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ];
  // }


  // Widget buildAudioPlayer() {
  //   return Container(
  //     height: 50,
  //     width: MediaQuery.of(context).size.width,
  //     color: Colors.white,
  //   );
  // }

  Widget buildQuranTranslatedPageCard(String surahName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Last read",style: kQuranPageBoxSubTitleStyle1,),
        SizedBox(height: 20),
        Text(
          surahName,
          style: kQuranPageBoxTitleStyle1,
        ),
        // Text(
        //   displayWholeQuranFiltered![index].suartEnglishTranslation!,
        //   style: kQuranPageBoxSubTitleStyle1,
        // ),
        // Divider(
        //   color: Colors.white.withOpacity(1),
        //   // indent: 50,
        //   endIndent: 230,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 25),
        //   child: Text(displayWholeQuranFiltered![index].suartRevelationCity,
        //       style: kQuranPageBoxSubTitleStyle1),
        // ),
      ],
    );
  }
}
