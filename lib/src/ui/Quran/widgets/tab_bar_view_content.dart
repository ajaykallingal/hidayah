import 'package:flutter/material.dart';

class TabBarViewContent extends StatelessWidget {

  const TabBarViewContent({
    Key? key,

  }) :  super(key: key);
  // final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Surah Al-Fatiha"),
      leading: Image.asset("assets/images/QURAN NAV.png"),
    );
  }
}