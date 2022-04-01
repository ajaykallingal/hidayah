import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/models/quran_request.dart';
import 'package:hidayah/src/data/models/surah/surah_response.dart';
import 'package:hidayah/src/data/models/surat_model.dart';
import 'package:hidayah/src/ui/Quran/components/quran_arabic_translated_page.dart';
import 'package:hidayah/src/ui/Quran/components/quran_translated_page_arguments.dart';
import 'package:hidayah/src/ui/Quran/widgets/tab_bar_view_content.dart';
import 'package:hidayah/src/ui/home/components/glass_morphic_container.dart';

import '../../data/bloc/test_request_bloc.dart';
import '../../data/models/quran_request_response.dart';
import 'components/search_bar_widget.dart';
import 'components/textStyle.dart';

class QuranScreen extends StatefulWidget {
  static const String id = 'quran_screen';

  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen>
    with SingleTickerProviderStateMixin {
  List tabList = ["Surah", "Jus", "Favourites"];
  // List surahList = SuratModel() as List<Map<String, dynamic>>;
  // List<DisplayWholeQuranFiltered> displayWholeQuranFiltered = List.empty(growable: true);
  List<SurahResponse> surahList = List.empty(growable: true);
  int index = 0;

  // displayWholeQuranFiltered.addAll(List<DisplayWholeQuranFiltered>.from(SuratModel.surahList.map((x) => DisplayWholeQuranFiltered.fromJson(x))));

  int selectedTabIndex = 0;
  late TabController _tabController;
  ScrollController _scrollController = new ScrollController();

  final String languageId = "12";
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

  final testRequestBloc = TestRequestBloc();
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
    surahList.addAll(List<SurahResponse>.from(SuratModel.surahList.map((x) => SurahResponse.fromJson(x))));
    print(surahList);
    _tabController = TabController(
        length: tabList.length, vsync: this, initialIndex: selectedTabIndex);
    _tabController.addListener(() {
      setState(() {
        print(_tabController.index);
      });
    });

    testRequestBloc.quranFetchFiltered(
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2),
                  SearchBarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, top: 5),
                    child: Text(
                      'Quran',
                      style: kQuranPageHeadlineTextStyle,
                    ),
                  ),
                  SizedBox(height: 3),
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
                            buildQuranPageCard(index),
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
                    length: tabList.length,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            // height: 350,
                            width: 346,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              children: [
                                TabBar(
                                  physics: BouncingScrollPhysics(),
                                  controller: _tabController,
                                  labelStyle: kQuranPageTabHeaderStyle,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: tabBarHeaderActiveTextColor,
                                  labelColor: tabBarHeaderActiveTextColor,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  unselectedLabelColor:
                                      tabBarHeaderInactiveTextColor,
                                  unselectedLabelStyle:
                                      kQuranPageTabHeaderStyle,
                                  onTap: (index) =>
                                      _tabController.animateTo(index),
                                  tabs: List<Widget>.generate(tabList.length,
                                      (index) {
                                    return Tab(
                                      text: tabList[index],
                                    );
                                  }),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(10),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      loading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListView.builder(
                                              itemCount: surahList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return ListTile(
                                                  horizontalTitleGap: 30,

                                                  title: Text(
                                                    surahList[index].transliteration,
                                                    softWrap: true,
                                                    style:
                                                        kQuranPageTabContentTitleStyle,
                                                  ),
                                                  subtitle: Text(
                                                   surahList[index].translation,
                                                    // softWrap: true,
                                                    style:
                                                        kQuranPageTabContentSubTitleStyle,
                                                  ),
                                                  leading:   Container(
                                                    constraints: BoxConstraints(maxWidth: 50,maxHeight: 50),
                                                    decoration: BoxDecoration(image: DecorationImage(
                                                      // alignment: Alignment.centerLeft,

                                                        fit: BoxFit.contain,

                                                        image: AssetImage("assets/images/list_tile_leading.png")
                                                    )),
                                                    child: Stack(
                                                      children: [
                                                      Align(
                                                            alignment: Alignment.center,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text("SURAH"),
                                                                Text(surahList[index].id,style: TextStyle(fontSize: 20),)
                                                              ],
                                                            ),

                                                          ),
                                                      ],
                                                    ),

                                                  ),



                                                    // color: mainRedShadeForTitle,

                                                  trailing: IconButton(onPressed: (){},
                                                      icon: _isFavSelectedIndex != null && _isFavSelectedIndex == suratId ?
                                                      Icon(Icons.favorite) : Icon(Icons.favorite_border),
                                                  ),

                                                  // ImageIcon(
                                                  //   AssetImage(
                                                  //     "assets/images/HEART_STROKE.png",
                                                  //   ),
                                                  //   color: _isFavSelectedIndex != null && _isFavSelectedIndex == suratId
                                                  //       ? mainRedShadeForTitle : lightGreyShadeForText,
                                                  // ),
                                                  onTap: () {
                                                    print(index);
                                                    loading
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  mainRedShadeForTitle,
                                                            ),
                                                          )
                                                        : Navigator
                                                            .pushNamed(
                                                                context,
                                                                QuranArabicTranslatedPage
                                                                    .id,
                                                                  arguments: QuranTranslatedPageArguments(surathId: surahList[index].id, languageId: languageId)
                                                               );
                                                  },
                                                );
                                              },
                                              scrollDirection: Axis.vertical,
                                              controller: _scrollController,
                                              physics: BouncingScrollPhysics(),
                                            ),
                                    loading ? Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),) :  ListView.builder(
                                        itemBuilder:
                                            (BuildContext context, index) {
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
                                     loading ? Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),) : ListView.builder(
                                        itemBuilder:
                                            (BuildContext context, index) {
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
                        ),
                      ],
                    ),
                  ),

                  //       child:
                  //       Column(
                  //         children: [

                  //
                  //   },
                  //   ),
                  //
                  // ),
                  //
                  //       ],
                  //     ),
                  //   ),
                  //
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildQuranPageCard(int index) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Last read",style: kQuranPageBoxSubTitleStyle1,),
        SizedBox(height: 20),
        Text(surahList[index].transliteration,style: kQuranPageBoxTitleStyle1,),
        Text(surahList[index].translation,style: kQuranPageBoxSubTitleStyle1,),
        Divider(
          color: Colors.white.withOpacity(1),
          // indent: 50,
          endIndent: 230,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            surahList[index].totalVerses + " verses",style: kQuranPageBoxSubTitleStyle1),
        ),

      ],
    );
  }
}
