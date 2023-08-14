import 'package:flutter/material.dart';

import 'Account.dart';
import 'HomeScreen.dart';
import 'WorkoutListScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.loggedIn}) : super(key: key);
  final bool loggedIn;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int bottomSelectedIndex = 0;

  List<NavigationDestination> buildBottomNavBarItems() {
    return [
      const NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home'
      ),
      const NavigationDestination(
          icon: Icon(Icons.fitness_center),
          label: 'Workouts'
      ),
      const NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Account'
      )
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        const HomeScreen(),
        WorkoutListScreen(),
        Account(loggedIn: widget.loggedIn),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.loggedIn){
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: buildPageView(),
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: bottomSelectedIndex,
          onDestinationSelected: (int index) {
            bottomTapped(index);
          },
          destinations: buildBottomNavBarItems(),
        ),
      );
    }else{
      bottomSelectedIndex=0;
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Account(loggedIn: false),

      );
    }

  }
}