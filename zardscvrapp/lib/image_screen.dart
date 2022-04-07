import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.white);
    TextStyle boldTextStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBar(
          title: Text("Network Image", style: textStyle),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          child: Image.network("https://api.compensationvr.tk/img/113.png"),
        )));
  }
}
