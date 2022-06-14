import 'dart:ui';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/models/quran_request.dart';
import 'package:hidayah/src/data/models/surah/surah_response.dart';
import 'package:hidayah/src/data/models/surat_model.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/Quran/components/quran_arabic_translated_page.dart';
import 'package:hidayah/src/ui/Quran/components/quran_translated_page_arguments.dart';

import '../../data/bloc/quran_request_bloc.dart';
import '../../data/models/quran_request_response.dart';
import 'components/textStyle.dart';

class QuranScreen extends StatefulWidget {
  static const String id = 'quran_screen';

  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen>
    with SingleTickerProviderStateMixin {
  List tabList = ["Surah"];

  // List surahList = SuratModel() as List<Map<String, dynamic>>;
  // List<DisplayWholeQuranFiltered> displayWholeQuranFiltered = List.empty(growable: true);
  List<SurahResponse> surahList = List.empty(growable: true);
  int index = 0;

  // displayWholeQuranFiltered.addAll(List<DisplayWholeQuranFiltered>.from(SuratModel.surahList.map((x) => DisplayWholeQuranFiltered.fromJson(x))));
  int selectedTabIndex = 0;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  final String languageId = ObjectFactory()
      .prefs
      .getUserData()!
      .response!
      .userSelectedLanguageId
      .toString();
  final String suratId = "1";
  final String ayathNo = "0";
  final String juzId = "0";
  final String ayathPageNo = "0";
  final String ayathAutoIncrId = "0";
  final String searchText = "";
  final String limitFrom = "10";
  final String limitTo = "20";
  final String voiceTypeId = "8";

  bool loading = true;

  final quranRequestBloc = QuranRequestBloc();
  Response? responseDetails;
  List<DisplayWholeQuranFiltered>? displayWholeQuranFiltered;
  int? _isFavSelectedIndex;

  void _onSelected(int index) {
    setState(() {
      _isFavSelectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    surahList.addAll(List<SurahResponse>.from(
        SuratModel.surahList.map((x) => SurahResponse.fromJson(x))));
    print(surahList);
    _tabController = TabController(
        length: tabList.length, vsync: this, initialIndex: selectedTabIndex);
    _tabController.addListener(() {
      setState(() {
        print(_tabController.index);
      });
    });

    quranRequestBloc.quranFetchFiltered(
      request: QuranRequest(
        langId: languageId,
        suratId: surahList[index].id,
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
    // ObjectFactory().prefs.saveUserLastReadData(surahList[index]);

    quranRequestBloc.quranFetchSCStreamListener.listen((event) {
      setState(() {

        // ObjectFactory().prefs.getLastReadSurahTranslation();
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
    return Scaffold(
      // extendBodyBehindAppBar: true,
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: CustomScrollView(

                    shrinkWrap: true,
                    anchor: 0.0,
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        leading: Container(),
                        backgroundColor: Colors.transparent,
                        title: Column(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Text(
                                'Quran',
                                style: kQuranPageHeadlineTextStyle,
                              ),
                            ),
                            // SizedBox(height: 70),
                          ],
                        ),


                        pinned: true,
                        expandedHeight: 190,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              // ListTile(
                              //   // title: Text(
                              //   //   'Quran',
                              //   //   style: kQuranPageHeadlineTextStyle,
                              //   // ),
                              //   leading:  Text(
                              //       'Quran',
                              //       style: kQuranPageHeadlineTextStyle,
                              //     ),
                              //   ),
                              SizedBox(height: 60,),
                              Container(
                                height: 120,
                                width: 346,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage("assets/images/quran.png"),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                    Visibility(

                                      child: Text(
                                                      "Last read",
                                                      style: kQuranPageBoxSubTitleStyle1,
                                                    ),
                                      visible: ObjectFactory().prefs.getUserLastReadData() == null ? false : true,
                                    ),
                                                  const SizedBox(height: 20),
                                                  Visibility(
                                                    visible: ObjectFactory().prefs.getUserLastReadData() ==null? false : true,
                                                    child: Text(
                                                      ObjectFactory().prefs.getUserLastReadData()?.transliteration.toString()??" ",

                                                      style: kQuranPageBoxTitleStyle1,
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: ObjectFactory().prefs.getUserLastReadData()==null? false : true,
                                                    child: Text(
                                                      ObjectFactory().prefs.getUserLastReadData()?.translation.toString()??" ",
                                                      style: kQuranPageBoxSubTitleStyle1,
                                                    ),
                                                  ),
                                                  if(ObjectFactory().prefs.getUserLastReadData()!=null)
                                                  Divider(
                                                    color: Colors.white.withOpacity(1),
                                                    // indent: 50,
                                                    endIndent: 230,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 25),
                                                    child: Visibility(
                                                      visible: ObjectFactory().prefs.getUserLastReadData()==null ? false : true,
                                                      child: Text("${ObjectFactory().prefs.getUserLastReadData()?.totalVerses.toString()} verses",
                                                          style: kQuranPageBoxSubTitleStyle1),
                                                    ),
                                                  ),

                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        // floating: true,
                        // snap: true,
                        // foregroundColor: Colors.transparent,
                        // shadowColor: Colors.transparent,

                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(bottom: 80),
                        sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (BuildContext, int index) {
                                  return  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(1),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          // contentPadding: EdgeInsets.only(bottom: 70),
                                          selectedColor: mainRedShadeForTitle,
                                        horizontalTitleGap: 30,
                                        title: Text(
                                          surahList[index]
                                              .transliteration,
                                          softWrap: true,
                                          style:
                                          kQuranPageTabContentTitleStyle,
                                        ),
                                        subtitle: Text(
                                          surahList[index]
                                              .translation,
                                          // softWrap: true,
                                          style:
                                          kQuranPageTabContentSubTitleStyle,
                                        ),
                                        leading: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 50,
                                              maxHeight: 50),
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                // alignment: Alignment.centerLeft,
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                      "assets/images/list_tile_leading.png")),),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:
                                                Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    const Text("SURAH"),
                                                    Text(
                                                      surahList[index]
                                                          .id,
                                                      style: const TextStyle(
                                                          fontSize:
                                                          20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        onTap: () {
                                          setState(() {
                                            ObjectFactory().prefs
                                                .saveUserLastReadData(
                                                surahList[index]);
                                          });
                                          // ObjectFactory().prefs.setLastReadSurah(lastReadSurah: surahList[index].transliteration);
                                          // ObjectFactory().prefs.setLastReadSurahTranslation(lastReadSurahTranslation: surahList[index].translation);
                                          // ObjectFactory().prefs.setLastReadSurahVerses(lastReadSurahVerses: surahList[index].totalVerses);
                                          print(index);
                                          loading
                                              ? Center(
                                            child:
                                            CircularProgressIndicator(
                                              color:
                                              mainRedShadeForTitle,
                                            ),
                                          )
                                              : Navigator.pushNamed(
                                            context,
                                            QuranArabicTranslatedPage
                                                .id,
                                            arguments: QuranTranslatedPageArguments(
                                                surathId:
                                                surahList[
                                                index]
                                                    .id,
                                                languageId:
                                                languageId,
                                                surahName:
                                                surahList[
                                                index]
                                                    .transliteration,
                                                totalVerse: surahList[index]
                                                    .totalVerses),
                                          ).then((value) => null

                                          );
                                        },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                          childCount: surahList.length,

                        ),







                        ),
                      ),

      //                 delegate: SliverChildListDelegate(
      //
      //                   [
      //
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 20, right: 20),
      //                       child: Container(
      //                         width: 346,
      //
      // decoration: BoxDecoration(
      //           color: Colors.white.withOpacity(1),
      //           borderRadius:
      //           const BorderRadius.all(Radius.circular(10)),
      //         ),
      //                         child:  loading
      //                             ?  Center(
      //                           child:
      //                           CircularProgressIndicator(color: mainRedShadeForTitle,),
      //                         ) :
                        //                         Column(
      //                           children: [
      //                             Container(
      //                               margin: EdgeInsets.only(left: 7,right: 7),
      //                               width: MediaQuery.of(context).size.width,
      //                               padding: EdgeInsets.only(bottom: 8,top: 8),
      //                                 decoration: BoxDecoration(
      //                                   border: Border(
      //                                     bottom: BorderSide(
      //                                       color: mainRedShadeForTitle,
      //                                       width: 1.0,
      //                                     ),
      //                                   ),
      //                                 ),
      //
      //                                 child: Align(
      //                                   alignment: Alignment.center,
      //                                     child: Text("Surah",style: kQuranScreenTabStyle,))),
      //                             Column(
      //                               children: [
      //                                 Container(
      //                                   margin: const EdgeInsets.all(8),
      //                                             padding: const EdgeInsets.all(10),
      //                                             height: MediaQuery.of(context).size.height,
      //                                             width: MediaQuery.of(context).size.width,
      //                                   child:
      //                                                  ListView.builder(
      //                                               itemCount: surahList.length,
      //                                               itemBuilder:
      //                                                   (BuildContext context,
      //                                                   index) {
      //                                                 return ListTile(
      //                                                   horizontalTitleGap: 30,
      //
      //                                                   title: Text(
      //                                                     surahList[index]
      //                                                         .transliteration,
      //                                                     softWrap: true,
      //                                                     style:
      //                                                     kQuranPageTabContentTitleStyle,
      //                                                   ),
      //                                                   subtitle: Text(
      //                                                     surahList[index]
      //                                                         .translation,
      //                                                     // softWrap: true,
      //                                                     style:
      //                                                     kQuranPageTabContentSubTitleStyle,
      //                                                   ),
      //                                                   leading: Container(
      //                                                     constraints: const BoxConstraints(
      //                                                         maxWidth: 50,
      //                                                         maxHeight: 50),
      //                                                     decoration: const BoxDecoration(
      //                                                         image: DecorationImage(
      //                                                           // alignment: Alignment.centerLeft,
      //
      //                                                             fit: BoxFit.contain,
      //                                                             image: AssetImage(
      //                                                                 "assets/images/list_tile_leading.png"))),
      //                                                     child: Stack(
      //                                                       children: [
      //                                                         Align(
      //                                                           alignment:
      //                                                           Alignment.center,
      //                                                           child: Column(
      //                                                             mainAxisAlignment:
      //                                                             MainAxisAlignment
      //                                                                 .center,
      //                                                             children: [
      //                                                               const Text("SURAH"),
      //                                                               Text(
      //                                                                 surahList[index]
      //                                                                     .id,
      //                                                                 style: const TextStyle(
      //                                                                     fontSize:
      //                                                                     20),
      //                                                               )
      //                                                             ],
      //                                                           ),
      //                                                         ),
      //                                                       ],
      //                                                     ),
      //                                                   ),
      //
      //                                                   onTap: () {
      //                                                     setState(() {
      //
      //                                                       ObjectFactory().prefs.saveUserLastReadData(surahList[index]);
      //
      //                                                     });
      //                                                     // ObjectFactory().prefs.setLastReadSurah(lastReadSurah: surahList[index].transliteration);
      //                                                     // ObjectFactory().prefs.setLastReadSurahTranslation(lastReadSurahTranslation: surahList[index].translation);
      //                                                     // ObjectFactory().prefs.setLastReadSurahVerses(lastReadSurahVerses: surahList[index].totalVerses);
      //                                                     print(index);
      //                                                     loading
      //                                                         ? Center(
      //                                                       child:
      //                                                       CircularProgressIndicator(
      //                                                         color:
      //                                                         mainRedShadeForTitle,
      //                                                       ),
      //                                                     )
      //                                                         : Navigator.pushNamed(
      //                                                       context,
      //                                                       QuranArabicTranslatedPage
      //                                                           .id,
      //                                                       arguments: QuranTranslatedPageArguments(
      //                                                           surathId:
      //                                                           surahList[
      //                                                           index]
      //                                                               .id,
      //                                                           languageId:
      //                                                           languageId,
      //                                                           surahName:
      //                                                           surahList[
      //                                                           index]
      //                                                               .transliteration,
      //                                                           totalVerse: surahList[index].totalVerses ),
      //                                                     ).then((value) => null
      //
      //                                                     );
      //                                                   },
      //                                                 );
      //                                               },
      //                                               scrollDirection: Axis.vertical,
      //                                               controller: _scrollController,
      //                                               physics: const BouncingScrollPhysics(),
      //                                             ),
      //                                           ),
      //                                 SizedBox(height: 0),
      //
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),



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

  Widget buildQuranPageCard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Last read",
          style: kQuranPageBoxSubTitleStyle1,
        ),
        const SizedBox(height: 20),
        Text(
          surahList[index].transliteration,
          style: kQuranPageBoxTitleStyle1,
        ),
        Text(
          surahList[index].translation,
          style: kQuranPageBoxSubTitleStyle1,
        ),
        Divider(
          color: Colors.white.withOpacity(1),
          // indent: 50,
          endIndent: 230,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(surahList[index].totalVerses + " verses",
              style: kQuranPageBoxSubTitleStyle1),
        ),
      ],
    );
  }
}
