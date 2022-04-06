import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zardscvrapp/utils/colors.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('mobile screen'),
      ),
      bottomNavigationBar: CupertinoTabBar(
        //bottom bar
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.policy),
              label: 'Info',
              backgroundColor: primaryColor),
        ],
      ),
    );
  }
}
