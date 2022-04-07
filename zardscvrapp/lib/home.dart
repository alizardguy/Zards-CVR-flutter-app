import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int feedOffsetNumber = 0;
  String firstDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  PageController pageController = PageController();

  void currentImage() {
    feedOffsetNumber = 0;
    final uri = Uri.parse(
        'https://api.compensationvr.tk/api/social/imgfeed?offset=0&count=1&reverse');
    //cursed sins to get the newest api image
    http.get(uri).then((response) {
      setState(() {
        final rawImageJson = response.body;
        final parsedImageJson = jsonDecode(rawImageJson);
        firstDisplayedImage = "https://api.compensationvr.tk/img/" +
            parsedImageJson[0]['_id'].toString();
      });
    });
  }

  void nextImage() {
    feedOffsetNumber++;
    feedLook();
  }

  void previousImage() {
    feedOffsetNumber--;
    feedLook();
  }

  void feedLook() {
    final uri = Uri.parse(
        'https://api.compensationvr.tk/api/social/imgfeed?offset=' +
            feedOffsetNumber.toString() +
            '&count=1&reverse');
    //cursed sins to get the newest api image
    http.get(uri).then((response) {
      setState(() {
        final rawImageJson = response.body;
        final parsedImageJson = jsonDecode(rawImageJson);
        firstDisplayedImage = "https://api.compensationvr.tk/img/" +
            parsedImageJson[0]['_id'].toString();
      });
    });
  }

  void onTapped(int index) {
    //page selector
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CVR app")),
      body: PageView(
        controller: pageController,
        children: [
          //page 1
          Column(
            children: [
              Flexible(child: Image.network(firstDisplayedImage)),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    //latest button
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            onPressed: currentImage,
                            child: const Text("Latest"))),
                    //back button
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            onPressed: previousImage,
                            child: const Text("Back"))),

                    //next button
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            onPressed: nextImage, child: const Text("Next"))),
                    //user
                    const Text("@username",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)), //Image uploader
                  ]))
            ],
          ),
          //page 2
          Container(color: Colors.blue),
          //page 3
          Container(color: Colors.yellow),
        ],
      ),
      //bottom bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "users"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "wip"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 185, 108, 199),
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
    );
  }
}
