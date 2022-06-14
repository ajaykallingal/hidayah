import 'package:flutter/material.dart';
import 'package:hidayah/src/data/bloc/dua_sub_category_bloc.dart';
import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_request.dart';
import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_response.dart';
import 'package:hidayah/src/ui/duas/components/view_all_dua_screen_arguments.dart';
import 'package:hidayah/src/ui/duas/components/view_dua_detailed_screen_arguments.dart';
import 'package:hidayah/src/ui/duas/view_dua_detailed_screen.dart';

import '../../constants/text_style.dart';
import '../prayer_times/text_style.dart';

class ViewAllDuasScreen extends StatefulWidget {
  static const String id = 'view_all_duas_screen';


  const ViewAllDuasScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllDuasScreen> createState() => _ViewAllDuasScreenState();
}

class _ViewAllDuasScreenState extends State<ViewAllDuasScreen> {
 bool callOneTime = true;
  bool loading = true;
  final duaSubCategoryBloc = DuaSubCategoryBloc();

  @override
  void initState() {
    // TODO: implement initState
    // duaSubCategoryBloc.fetchDuaSubCategory(
    //     request: DuaSubCategoryRequest(catId: "1"),
    // );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    duaSubCategoryBloc.duaSubCategorySCStreamListener.listen((event) {
     loading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ViewAllDuaScreenArguments;


      duaSubCategoryBloc.fetchDuaSubCategory(
          request: DuaSubCategoryRequest(catId: args.catId),
      );

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
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SearchBarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child:  ListTile(
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 50,
                      leading: IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back,color: Colors.white),),
                      title: Text("All Dua",style: kPrayerTimeScreenHeaderStyle,),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child:
                         StreamBuilder<DuaSubCategoryResponse>(
                           stream: duaSubCategoryBloc.duaSubCategorySCStreamListener,
                           builder: (context, snapshot) {
                             return
                                Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(1),

                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: loading ? Center(child: CircularProgressIndicator(color: mainRedShadeForText,),) :
                      ListView.builder(
                          itemCount: snapshot.data!.response!.length,
                          itemBuilder: (BuildContext context, index) {
                            if(snapshot.data == null || !snapshot.hasData){
                              return Center(child: CircularProgressIndicator(color: mainRedShadeForText,));
                            }else {
                              return ListTile(
                                title: Text(
                                  snapshot.data!.response![index].duaSubCatName,
                                  style: const TextStyle(color: Colors.black),
                                ),

                                        trailing: IconButton(onPressed: (){
                                          Navigator.of(context).pushNamed(ViewDuaDetailedScreen.id,arguments: ViewDuaDetailedScreenArguments(subCatId: snapshot.data!.response![index].duaSubCatId));

                                        },
                                          icon: Icon(Icons.arrow_forward_ios,color: mainRedShadeForTitle,size: 15,),
                                          padding: EdgeInsets.zero,
                                        ),
                                
                                onTap: (){
                                  Navigator.of(context).pushNamed(ViewDuaDetailedScreen.id,arguments: ViewDuaDetailedScreenArguments(subCatId: snapshot.data!.response![index].duaSubCatId));
                                },

                                      );
                            }
                                    },
                                    scrollDirection: Axis.vertical,
                                    // controller: _scrollController,
                                    physics: const BouncingScrollPhysics(),
                                  ),

                              );
                           }
                         ),
                        ),



                ],
              ),
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
        )
      ],
    );
  }
}
