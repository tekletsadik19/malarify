import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feeds.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routeName = '/home_screen';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _page = 0;
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }
  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: PageView(
        controller: pageController,
        onPageChanged: navigationTapped,
        children:  [
          Feeds(),
          Scaffold(),
          Scaffold(),
          Scaffold(),
          Scaffold(),
        ],

      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        currentIndex: _page,
        onTap: onTap,
        activeColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot),),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories),),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar_today),),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid),),
        ],
      ),
    );
  }
  void onTap(int page){
    pageController!.animateToPage(
        page,
        duration:const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn
    );
  }
  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
