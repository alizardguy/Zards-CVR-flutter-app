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

//image holders (very cursed, please fix later)
  String firstDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String secondDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String thirdDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String forthDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String fifthDisplayedImage = "https://api.compensationvr.tk/img/113.png";
  String sixthDisplayedImage = "https://api.compensationvr.tk/img/113.png";

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
          } catch (e) {
            firstDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //second image
          try {
            secondDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[1]['_id'].toString();
          } catch (e) {
            secondDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //third image
          try {
            thirdDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[2]['_id'].toString();
          } catch (e) {
            thirdDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //forth image
          try {
            forthDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[3]['_id'].toString();
          } catch (e) {
            forthDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //fifth image
          try {
            fifthDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[4]['_id'].toString();
          } catch (e) {
            fifthDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
          //sixth image
          try {
            sixthDisplayedImage = "https://api.compensationvr.tk/img/" +
                parsedImageJson[5]['_id'].toString();
          } catch (e) {
            sixthDisplayedImage = 'https://i.imgur.com/weClCCE.png';
          }
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
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: feedPaddingSpace),
                  child: Image.network(firstDisplayedImage),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: feedPaddingSpace),
                  child: Image.network(secondDisplayedImage),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: feedPaddingSpace),
                  child: Image.network(thirdDisplayedImage),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: feedPaddingSpace),
                  child: Image.network(forthDisplayedImage),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: feedPaddingSpace),
                  child: Image.network(fifthDisplayedImage),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: feedPaddingSpace),
                  child: Image.network(sixthDisplayedImage),
                ),
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
                    ]))
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
