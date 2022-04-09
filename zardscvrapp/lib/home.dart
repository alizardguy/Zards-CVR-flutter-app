import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//bottom bar page system
  int _selectedIndex = 0;

//button image feed
  int feedOffsetNumber = 0;
  static const double feedPaddingSpace = 15;
  final feedScrollControl = ScrollController();

//image holders (very cursed, please fix later)
  String firstDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String firstImageText = "@alizard";
  String secondDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String secondImageText = "@alizard2";
  String thirdDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String thirdImageText = "@alizard3";
  String forthDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String forthImageText = "@alizard4";
  String fifthDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String fifthImageText = "@alizard5";
  String sixthDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String sixthImageText = "@alizard6";

//functions n stuff
  PageController pageController = PageController();

  void currentImage() {
    feedOffsetNumber = 0;
    feedLook();
  }

  void nextImage() {
    feedOffsetNumber = feedOffsetNumber + 6;
    feedLook();
  }

  void previousImage() {
    if (feedOffsetNumber > 0) {
      feedOffsetNumber = feedOffsetNumber - 6;
      feedLook();
    }
  }

  //reset scroll
  void scrollUp() {
    final double start = 0;
    feedScrollControl.jumpTo(start);
  }

  void feedLook() {
    try {
      final uri = Uri.parse(
          'https://api.compensationvr.tk/api/social/imgfeed?offset=' +
              feedOffsetNumber.toString() +
              '&count=6&reverse');
      //cursed sins to get the newest api image
      http.get(uri).then((response) {
        setState(() {
          final rawImageJson = response.body;
          final parsedImageJson = jsonDecode(rawImageJson);
          //first image
          try {
            firstDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[0]['_id'].toString();
            firstImageText =
                "@" + parsedImageJson[0]['takenBy']['username'].toString();
          } catch (e) {
            firstDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //second image
          try {
            secondDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[1]['_id'].toString();
            secondImageText =
                "@" + parsedImageJson[1]['takenBy']['username'].toString();
          } catch (e) {
            secondDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //third image
          try {
            thirdDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[2]['_id'].toString();
            thirdImageText =
                " @" + parsedImageJson[2]['takenBy']['username'].toString();
          } catch (e) {
            thirdDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //forth image
          try {
            forthDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[3]['_id'].toString();
            forthImageText =
                "@" + parsedImageJson[3]['takenBy']['username'].toString();
          } catch (e) {
            forthDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //fifth image
          try {
            fifthDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[4]['_id'].toString();
            fifthImageText =
                "@" + parsedImageJson[4]['takenBy']['username'].toString();
          } catch (e) {
            fifthDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //sixth image
          try {
            sixthDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[5]['_id'].toString();
            sixthImageText =
                "@" + parsedImageJson[5]['takenBy']['username'].toString();
          } catch (e) {
            sixthDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          scrollUp();
        });
      });
    } catch (e) {
      //fail catch
      print(e.toString());
    }
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
  void initState() {
    currentImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CVR app")),
      body: PageView(
        controller: pageController,
        children: [
          //page 1
          SingleChildScrollView(
            controller: feedScrollControl,
            child: Column(
              children: [
                //image container 1
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 66, 66, 66),
                        borderRadius: BorderRadius.only()),
                    margin: const EdgeInsets.all(feedPaddingSpace),
                    padding: const EdgeInsets.all(feedPaddingSpace),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(firstImageText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          )),
                      Image.network(firstDisplayedImage)
                    ])),
                //image container 2
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 66, 66, 66),
                        borderRadius: BorderRadius.only()),
                    margin: const EdgeInsets.all(feedPaddingSpace),
                    padding: const EdgeInsets.all(feedPaddingSpace),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(secondImageText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          )),
                      Image.network(secondDisplayedImage)
                    ])),
                //image container 3
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 66, 66, 66),
                        borderRadius: BorderRadius.only()),
                    margin: const EdgeInsets.all(feedPaddingSpace),
                    padding: const EdgeInsets.all(feedPaddingSpace),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(thirdImageText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          )),
                      Image.network(thirdDisplayedImage)
                    ])),
                //image container 4
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 66, 66, 66),
                        borderRadius: BorderRadius.only()),
                    margin: const EdgeInsets.all(feedPaddingSpace),
                    padding: const EdgeInsets.all(feedPaddingSpace),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(forthImageText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          )),
                      Image.network(forthDisplayedImage)
                    ])),
                //image container 5
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 66, 66, 66),
                        borderRadius: BorderRadius.only()),
                    margin: const EdgeInsets.all(feedPaddingSpace),
                    padding: const EdgeInsets.all(feedPaddingSpace),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(fifthImageText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          )),
                      Image.network(fifthDisplayedImage)
                    ])),
                //image container 6
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 66, 66, 66),
                        borderRadius: BorderRadius.only()),
                    margin: const EdgeInsets.all(feedPaddingSpace),
                    padding: const EdgeInsets.all(feedPaddingSpace),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(sixthImageText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          )),
                      Image.network(sixthDisplayedImage)
                    ])),
              ],
            ),
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
