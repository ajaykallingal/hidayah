import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/data/models/dua/dua_category_response.dart';
import 'package:hidayah/src/ui/duas/components/view_all_dua_screen_arguments.dart';
import 'package:hidayah/src/ui/duas/view_all_duas_screen.dart';

import '../../constants/text_style.dart';
import '../../data/bloc/dua_category_bloc.dart';
import '../../data/bloc/quran_request_bloc.dart';
import '../../data/models/quran_request.dart';
import '../../data/models/quran_request_response.dart';
import '../Quran/components/search_bar_widget.dart';
import '../Quran/components/textStyle.dart';
import '../more/widgets/more_screen_list_tile_widget.dart';
import 'components/more_screen_list_tile_widget.dart';

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
  bool oneTime = true;

  final duaCategoryBloc = DuaCategoryBloc();
   List? duaCategoryResposnse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
        length: 1, vsync: this, initialIndex: selectedTabIndex);
    _tabController.addListener(() {
      setState(() {
        print(_tabController.index);
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies


    duaCategoryBloc.duaCategoryFetchStreamListener.listen((event) {

  setState(() {
    loading = false;
    oneTime = false;
    duaCategoryResposnse = event.response;
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
    if(oneTime){
      duaCategoryBloc.fetchDuaCategory();

    }

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
                    padding: const EdgeInsets.only(left: 28, top: 20),
                    child: Text(
                      'Duas',
                      style: kQuranPageHeadlineTextStyle,
                    ),
                  ),
                  SizedBox(height: 20),


                  DefaultTabController(
                    length: 1,

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
                                    // Tab(
                                    //   text: "Favourites",
                                    // ),





                                  ],

                                ),

                                StreamBuilder<DuaCategoryResponse>(
                                  stream: duaCategoryBloc.duaCategoryFetchStreamListener,
                                  builder: (context, snapshot) {
                                    print(snapshot.data.toString());
                                    if(snapshot.data == null|| !snapshot.hasData){
                                      return Center(child: CircularProgressIndicator(color: mainRedShadeForText,),);
                                    }else if(snapshot.hasError){
                                      print(snapshot.error.toString());
                                    }

                                      return Container(
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
                                              :
                                          ListView.separated(
                                            shrinkWrap: true,

                                            itemCount: snapshot.data!.response!.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return
                                                InkWell(
                                                  child: TileWidgetForDuas(
                                                    title:
                                                        snapshot.data!.response![index].duaCatName,

                                                        // softWrap: true,
                                                        // style:
                                                        // kQuranPageTabContentTitleStyle,

                                                    // subTitle:
                                                    // 'Show accurate qibla\ndirection from your location.',
                                                    // iconPath: 'assets/images/QIBLA_COMPASS.png',
                                                  ),
                                                  onTap: () {

                                                        Navigator.pushNamed(context, ViewAllDuasScreen.id,
                                                            arguments: ViewAllDuaScreenArguments(catId: snapshot.data!.response![index].duaCatId),

                                                          );

                                                  },
                                                );
                                              //   ListTile(
                                              //     contentPadding: EdgeInsets.zero,
                                              //   title: Padding(
                                              //     padding: const EdgeInsets.all(10),
                                              //     child: Text(
                                              //       snapshot.data!.response![index].duaCatName,
                                              //
                                              //       softWrap: true,
                                              //       style:
                                              //       kQuranPageTabContentTitleStyle,
                                              //     ),
                                              //   ),
                                              //   // leading: CircleAvatar(
                                              //   //   child: Text(snapshot.data!.response![index].duaCatId ),
                                              //   //   // Stack(
                                              //   //   //   children: [
                                              //   //   //     Image.asset("assets/images/duaimage.jpg"),
                                              //   //   //     Text(snapshot.data!.response![index].duaCatId ),
                                              //   //   //   ],
                                              //   //   // ),
                                              //   //   radius: 30,
                                              //   //   backgroundColor: Colors.transparent,
                                              //   //   backgroundImage: AssetImage("assets/images/duaimage.jpg"),
                                              //   // ),
                                              //   // subtitle: Text(
                                              //   //   snapshot.data!.response![index].duaCatId,
                                              //   //   // softWrap: true,
                                              //   //   style:
                                              //   //   kQuranPageTabContentSubTitleStyle,
                                              //   // ),
                                              //
                                              //
                                              //
                                              //   onTap: () {
                                              //   print(index.toString());
                                              //
                                              //   Navigator.pushNamed(context, ViewAllDuasScreen.id,
                                              //     arguments: ViewAllDuaScreenArguments(catId: snapshot.data!.response![index].duaCatId),
                                              //   );
                                              //   },
                                              // );
                                            },

                                            scrollDirection: Axis.vertical,
                                            controller: _scrollController,
                                            physics: BouncingScrollPhysics(),
                                            separatorBuilder: (BuildContext context, int index)=> Divider(),
                                          ),
                                          // ListView.builder(
                                          //   itemBuilder:
                                          //       (BuildContext context, index) {
                                          //     return ListTile(
                                          //       title: Text(
                                          //         "data",
                                          //         style:
                                          //         TextStyle(color: Colors.black),
                                          //       ),
                                          //
                                          //
                                          //     );
                                          //   },
                                          //   itemCount: 10,
                                          //   scrollDirection: Axis.vertical,
                                          //   // controller: _scrollController,
                                          //   physics: BouncingScrollPhysics(),
                                          // ),


                                        ],
                                      ),
                                    );
                                    }

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
