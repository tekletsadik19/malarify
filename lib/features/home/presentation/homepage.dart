import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:malarify/features/data_vis/presentation/data_vis_page.dart';
import 'package:malarify/features/detect_malaria/presentation/detect_malaria_page.dart';
import 'package:malarify/features/profile/presentation/profile_page.dart';

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
          DetectMalariaPage(),
          DataVisualizePage(),
          Profile(),
        ],

      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        currentIndex: _page,
        onTap: onTap,
        activeColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot),),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.earthAfrica),),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heartCircleCheck),),
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
