import 'dart:ui';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/data/models/dua/dua_category_response.dart';
import 'package:hidayah/src/ui/duas/components/view_all_dua_screen_arguments.dart';
import 'package:hidayah/src/ui/duas/view_all_duas_screen.dart';

import '../../constants/text_style.dart';
import '../../data/bloc/dua_category_bloc.dart';
import '../Quran/components/textStyle.dart';
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
  final ScrollController _scrollController = ScrollController();


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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _tabController.dispose();
  //
  // }


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
            child: DefaultTabController(
              length: 1,
            child:  NestedScrollView(

              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return <Widget>[
                  SliverOverlapAbsorber(
                    // This widget takes the overlapping behavior of the SliverAppBar,
                    // and redirects it to the SliverOverlapInjector below. If it is
                    // missing, then it is possible for the nested "inner" scroll view
                    // below to end up under the SliverAppBar even when the inner
                    // scroll view thinks it has not been scrolled.
                    // This is not necessary if the "headerSliverBuilder" only builds
                    // widgets that do not overlap the next sliver.
                    handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverPadding(
                      sliver: SliverAppBar(

                        // leading: Container(),
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.white.withOpacity(1),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        // title: Padding(
                        //   padding: const EdgeInsets.only(top: 10,bottom: 10),
                        //   child: Text(
                        //     'Quran',
                        //     style: kQuranPageHeadlineTextStyle,
                        //   ),
                        // ),
                        // pinned: true,
                        // floating: true,
                        pinned: true,
                        // floating: true,
                        // snap: true,
                        shadowColor: Colors.transparent,
                        expandedHeight: 150,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20,bottom: 10),
                                child: Text(
                                  'Duas',
                                  style: kQuranPageHeadlineTextStyle,
                                ),
                              ),
                              // title: Text(
                              //   'Quran',
                              //   style: kQuranPageHeadlineTextStyle,
                              // ),
                              // leading: IconButton(
                              //   onPressed: () {
                              //     Navigator.pop(context);
                              //   },
                              //   icon: Icon(
                              //     Icons.arrow_back,
                              //     color: Colors.white.withOpacity(1),
                              //   ),
                              // ),
                              // ),
                              // SizedBox(height: 15),

                              // const SizedBox(height: 10),
                            ],

                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize:
                          Size(MediaQuery.of(context).size.width, 40),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child:
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width/1.2,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:
                                      TabBar(
                                        labelPadding: const EdgeInsets.all(2),
                                        isScrollable: false,
                                        physics: const NeverScrollableScrollPhysics(),
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
                                            // _tabController.animateTo(index);
                                          });

                                          print(selectedTabIndex);
                                          print(
                                              "tabController:${_tabController.index}");
                                          setState(() {
                                            loading = false;
                                          });
                                        },
                                        tabs: const [
                                          Tab(
                                            text: "Categories",
                                          ),
                                        ],
                                      ),




                          ),
                ],
                        ),
                        // floating: true,
                        // snap: true,


                        //               ),
                      ),
                    ),
                  ),
                  )
                ),
                        padding: EdgeInsets.all(0),

                ),
                )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: StreamBuilder<DuaCategoryResponse>(
                      stream: duaCategoryBloc.duaCategoryFetchStreamListener,
                      builder: (context, snapshot) {
                        print(snapshot.data.toString());
                        if(snapshot.data == null|| !snapshot.hasData){
                          return Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),);
                        }else if(snapshot.hasError){
                          print(snapshot.error.toString());
                        }
                        return Container(
                          color: Colors.white.withOpacity(1),
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(10),
                          height: 450,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: TabBarView(

                            controller: _tabController,
                            children: [

                              loading

                                  ? const Center(
                                child: CircularProgressIndicator(),)
                                  :
                              ListView.builder(

                                shrinkWrap: true,

                                itemCount: snapshot.data!.response!.length,
                                itemBuilder:
                                    (BuildContext context, index) {
                                  return
                                    InkWell(
                                      child: Column(
                                        children: [
                                          ListTile(
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// selectedTileColor: Colors.orange[100],
// selected: true,
// tileColor: Colors.red,
                                            title: Text(snapshot.data!.response![index].duaCatName,style: TextStyle(color: Colors.black),),
                                          ),
                                          Divider(
                                            color: const Color(0xFF707070).withOpacity(0.2),
                                            indent: 0,
                                            thickness: 0.8,
                                            endIndent: 0,
                                          ),
                                          SizedBox(height: 10),

                                        ],
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

                                // scrollDirection: Axis.vertical,
                                // controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
// separatorBuilder: (BuildContext context, int index)=> const Divider(),
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
                ),
              ),
              // anchor: 0.0,
              physics: const BouncingScrollPhysics(),

            ),

            ),


          ),
        ),
      ],
    );
  }
}


//
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// // SearchBarWidget(),
// Padding(
// padding: const EdgeInsets.only(left: 28, top: 20),
// child: Text(
// 'Duas',
// style: kQuranPageHeadlineTextStyle,
// ),
// ),
// const SizedBox(height: 20),
//
//
// DefaultTabController(
// length: 1,
//
// child: Column(
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 20,right: 20),
// child: Container(
// width: MediaQuery.of(context).size.width,
// decoration: BoxDecoration(
// color: mainThemeWhiteColor,
// borderRadius: BorderRadius.circular(15),
// ),
// child: Column(
// children: [
//
// TabBar(
//
// physics: const BouncingScrollPhysics(),
// controller: _tabController,
// indicatorColor: mainRedShadeForTitle,
// indicatorSize: TabBarIndicatorSize.tab,
// indicatorWeight: 0.9,
// // indicatorPadding: EdgeInsets.only(left: 5,right: 5),
// padding: const EdgeInsets.all(5),
//
// // indicatorSize: TabBarIndicatorSize.label,
// labelColor: mainRedShadeForTitle,
// unselectedLabelColor: lightGreyShadeForText,
// unselectedLabelStyle: kQuranPageTabHeaderStyle,
// onTap: (index) {
// _tabController.animateTo(index);
// },
// tabs: const [
// Tab(
// text: "Categories",
//
// ),
// // Tab(
// //   text: "Favourites",
// // ),
//
//
//
//
//
// ],
//
// ),
//
// StreamBuilder<DuaCategoryResponse>(
// stream: duaCategoryBloc.duaCategoryFetchStreamListener,
// builder: (context, snapshot) {
// print(snapshot.data.toString());
// if(snapshot.data == null|| !snapshot.hasData){
// return Center(child: CircularProgressIndicator(color: mainRedShadeForTitle,),);
// }else if(snapshot.hasError){
// print(snapshot.error.toString());
// }
//
// return Container(
// color: Colors.white.withOpacity(1),
// margin: const EdgeInsets.all(8),
// padding: const EdgeInsets.all(10),
// height: 450,
// width: MediaQuery
//     .of(context)
//     .size
//     .width,
// child: TabBarView(
//
// controller: _tabController,
// children: [
//
// loading
//
// ? const Center(
// child: CircularProgressIndicator(),)
//     :
// ListView.builder(
//
// shrinkWrap: true,
//
// itemCount: snapshot.data!.response!.length,
// itemBuilder:
// (BuildContext context, index) {
// return
// InkWell(
// child: Column(
// children: [
// ListTile(
// // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // selectedTileColor: Colors.orange[100],
// // selected: true,
// // tileColor: Colors.red,
// title: Text(snapshot.data!.response![index].duaCatName,style: TextStyle(color: Colors.black),),
// ),
// Divider(
// color: const Color(0xFF707070).withOpacity(0.2),
// indent: 0,
// thickness: 0.8,
// endIndent: 0,
// ),
// SizedBox(height: 20),
//
// ],
// ),
// onTap: () {
//
// Navigator.pushNamed(context, ViewAllDuasScreen.id,
// arguments: ViewAllDuaScreenArguments(catId: snapshot.data!.response![index].duaCatId),
//
// );
//
// },
// );
// //   ListTile(
// //     contentPadding: EdgeInsets.zero,
// //   title: Padding(
// //     padding: const EdgeInsets.all(10),
// //     child: Text(
// //       snapshot.data!.response![index].duaCatName,
// //
// //       softWrap: true,
// //       style:
// //       kQuranPageTabContentTitleStyle,
// //     ),
// //   ),
// //   // leading: CircleAvatar(
// //   //   child: Text(snapshot.data!.response![index].duaCatId ),
// //   //   // Stack(
// //   //   //   children: [
// //   //   //     Image.asset("assets/images/duaimage.jpg"),
// //   //   //     Text(snapshot.data!.response![index].duaCatId ),
// //   //   //   ],
// //   //   // ),
// //   //   radius: 30,
// //   //   backgroundColor: Colors.transparent,
// //   //   backgroundImage: AssetImage("assets/images/duaimage.jpg"),
// //   // ),
// //   // subtitle: Text(
// //   //   snapshot.data!.response![index].duaCatId,
// //   //   // softWrap: true,
// //   //   style:
// //   //   kQuranPageTabContentSubTitleStyle,
// //   // ),
// //
// //
// //
// //   onTap: () {
// //   print(index.toString());
// //
// //   Navigator.pushNamed(context, ViewAllDuasScreen.id,
// //     arguments: ViewAllDuaScreenArguments(catId: snapshot.data!.response![index].duaCatId),
// //   );
// //   },
// // );
// },
//
// scrollDirection: Axis.vertical,
// controller: _scrollController,
// physics: const BouncingScrollPhysics(),
// // separatorBuilder: (BuildContext context, int index)=> const Divider(),
// ),
// // ListView.builder(
// //   itemBuilder:
// //       (BuildContext context, index) {
// //     return ListTile(
// //       title: Text(
// //         "data",
// //         style:
// //         TextStyle(color: Colors.black),
// //       ),
// //
// //
// //     );
// //   },
// //   itemCount: 10,
// //   scrollDirection: Axis.vertical,
// //   // controller: _scrollController,
// //   physics: BouncingScrollPhysics(),
// // ),
//
//
// ],
// ),
// );
// }
//
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),

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
// ],
// ),
