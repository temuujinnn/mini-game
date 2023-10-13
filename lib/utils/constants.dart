import 'package:flutter/material.dart';

const kAnimatinoDuration = Duration(milliseconds: 200);
const kdelayDuration200 = Duration(milliseconds: 200);
const kdelayDuration2000 = Duration(milliseconds: 2000);
const List<BottomNavigationBarItem> kBottomNavBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shop),
    label: 'Shop',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
];
const kNavigationRailDestinations = [
  NavigationRailDestination(
    icon: Icon(Icons.home),
    label: Text('Home'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.search),
    label: Text('Search'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.shop),
    label: Text('Shop'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.person),
    label: Text('Profile'),
  ),
];
const kDrawerItems = [
  NavigationDrawerDestination(
    icon: Icon(Icons.home),
    label: Text('Home'),
  ),
  NavigationDrawerDestination(
    icon: Icon(Icons.play_lesson),
    label: Text('Search'),
  ),
  NavigationDrawerDestination(
    icon: Icon(Icons.shop),
    label: Text('Shop'),
  ),
  NavigationDrawerDestination(
    icon: Icon(Icons.person),
    label: Text('Profile'),
  ),
];

/// Colors
const Color primaryColor = Color(0xff65d3ff);
const Color canvasColor = Color(0xff191c1e);
const Color cardColor = Color(0xff191c1e);
const Color unselectedWidgetColor = Color(0xb3ffffff);
const Color buttonColor = Color(0xff65d3ff);
const Color primaryContainerColor = Color(0xff004d64);
const Color secondaryColor = Color(0xffb4cad6);
const Color secondaryContainerColor = Color(0xff354a53);
const Color surfaceColor = Color(0xff191c1e);
const Color backgroundColor = Color(0xff191c1e);
const Color errorColor = Color(0xffffb4ab);
const Color onPrimaryColor = Color(0xff003546);
const Color onSecondaryColor = Color(0xff1f333c);
const Color onSurfaceColor = Color(0xffe1e2e4);
const Color onBackgroundColor = Color(0xffe1e2e4);
const Color onErrorColor = Color(0xff690005);
