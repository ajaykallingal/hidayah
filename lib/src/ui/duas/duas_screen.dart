import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/ui/duas/view_all_duas_screen.dart';

import '../../constants/text_style.dart';
import '../../data/bloc/test_request_bloc.dart';
import '../../data/models/quran_request.dart';
import '../../data/models/quran_request_response.dart';
import '../Quran/components/search_bar_widget.dart';
import '../Quran/components/textStyle.dart';

class DuasScreen extends StatefulWidget {
  static const String id = 'duas_screen';

  const DuasScreen({Key? key}) : super(key: key);

  @override
  State<DuasScreen> createState() => _DuasScreenState();
}

class _DuasScreenState extends State<DuasScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int selectedTabIndex = 0;
  ScrollController _scrollController = new ScrollController();

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String? localFilePath;
  String? localAudioCacheURI;

  final String languageId = "35";
   String suratId ="0" ;
  final String ayathNo = "0";
  final String juzId = "0";
  final String ayathPageNo = "0";
  final String ayathAutoIncrId = "0";
  final String searchText = "";
  final String limitFrom = "10";
  final String limitTo = "20";
  final String voiceTypeId = "8";


  bool loading = true;
  int index = 0;

  final testRequestBloc = TestRequestBloc();
  Response? responseDetails;
  List<DisplayWholeQuranFiltered>? displayWholeQuranFiltered;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
        length: 2, vsync: this, initialIndex: selectedTabIndex);
    _tabController.addListener(() {
      setState(() {
        print(_tabController.index);
      });
    });

    testRequestBloc.quranFetchFiltered(
      request: QuranRequest(
        langId: languageId,
        suratId: index.toString(),
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
                  SearchBarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, top: 10),
                    child: Text(
                      'Duas',
                      style: kQuranPageHeadlineTextStyle,
                    ),
                  ),
                  SizedBox(height: 10),


                  DefaultTabController(
                    length: 2,

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: mainThemeWhiteColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [

                                TabBar(

                                  physics: BouncingScrollPhysics(),
                                  controller: _tabController,
                                  indicatorColor: mainRedShadeForTitle,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 0.9,
                                  // indicatorPadding: EdgeInsets.only(left: 5,right: 5),
                                  padding: EdgeInsets.all(5),

                                  // indicatorSize: TabBarIndicatorSize.label,
                                  labelColor: mainRedShadeForTitle,
                                  unselectedLabelColor: lightGreyShadeForText,
                                  unselectedLabelStyle: kQuranPageTabHeaderStyle,
                                  onTap: (index) {
                                    _tabController.animateTo(index);
                                  },
                                  tabs: [
                                    Tab(
                                      text: "Categories",

                                    ),
                                    Tab(
                                      text: "Favourites",
                                    ),





                                  ],

                                ),

                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(10),
                                  height: 450,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: TabBarView(

                                    controller: _tabController,
                                    children: [

                                      loading

                                          ? Center(
                                        child: CircularProgressIndicator(),)
                                          : ListView.builder(
                                        itemBuilder:
                                            (BuildContext context, index) {



                                          return
                                            ListTile(
                                            title: Text(
                                              displayWholeQuranFiltered![index].suratEngName!,
                                              // displayWholeQuranFiltered![index]
                                              //     .suratEngName! ,
                                              softWrap: true,
                                              style:
                                              kQuranPageTabContentTitleStyle,
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage: AssetImage("assets/images/dua.png"),
                                            ),
                                            subtitle: Text(
                                              displayWholeQuranFiltered![index]
                                                  .suartEnglishTranslation!,
                                              // softWrap: true,
                                              style:
                                              kQuranPageTabContentSubTitleStyle,
                                            ),



                                            onTap: () {
                                            print(index.toString());
                                            Navigator.pushNamed(context, ViewAllDuasScreen.id);
                                            },
                                          );
                                        },
                                        itemCount: displayWholeQuranFiltered!.length,
                                        scrollDirection: Axis.vertical,
                                        controller: _scrollController,
                                        physics: BouncingScrollPhysics(),
                                      ),
                                      ListView.builder(
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return ListTile(
                                            title: Text(
                                              "data",
                                              style:
                                              TextStyle(color: Colors.black),
                                            ),


                                          );
                                        },
                                        itemCount: 10,
                                        scrollDirection: Axis.vertical,
                                        // controller: _scrollController,
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
}
