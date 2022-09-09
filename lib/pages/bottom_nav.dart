import 'package:flutter/material.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../theme/color.dart';
import 'discover.dart';
import 'home.dart';
import 'search.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

int selectedpage = 0;
final _pageNo = [HomePage(), DiscoverPage()];

void _onItemTapped(int index) {
    setState(() {
      selectedpage = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageNo.elementAt(selectedpage),
      bottomNavigationBar: ConvexAppBar(
          color: ColorTheme().shadowColor,
          elevation:0,
          height: 40,
          activeColor: ColorTheme().buttonColor,
          backgroundColor: ColorTheme().backgroundColor,
          top: -15,
    items: [
      TabItem(icon: Icon(Icons.home_outlined, size: selectedpage == 0 ? 35 : 30, color: ColorTheme().iconColor)),
      TabItem(icon: Icon(Icons.explore_outlined, size: selectedpage == 1 ? 35 : 30, color: ColorTheme().iconColor)),
    ],
    initialActiveIndex: selectedpage,//optional, default as 0
    onTap: _onItemTapped
  )
    );
  }
}