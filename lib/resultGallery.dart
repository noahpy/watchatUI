import 'dart:math';

import 'package:flutter/material.dart';

class ResultGallery extends StatefulWidget {
  List<String> imgPathList;
  List<String> urlPathList;
  List<String> titleList;

  ResultGallery(this.imgPathList, this.urlPathList, this.titleList,
      {super.key});

  @override
  State<ResultGallery> createState() => _ResultGalleryState();
}

class _ResultGalleryState extends State<ResultGallery> {
  @override
  Widget build(BuildContext context) {
    int l = min(min(widget.imgPathList.length, widget.urlPathList.length),
        widget.titleList.length);
    int amountWidth = MediaQuery.of(context).size.width ~/ 200;
    List<Widget> widgetsList = [];
    List<Widget> rowList = [];
    amountWidth = min((l - 1) ~/ 2, amountWidth);

    for (int i = 0; i < l; i++) {
      rowList.add(Column(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height/30),
                child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 70),
              child: Image.network(
                widget.imgPathList[i],
              ),
            )),
          ),
          Text(
            widget.titleList[i],
            style: TextStyle(
                color: const Color.fromARGB(255, 236, 240, 241),
                fontFamily: "Lato",
                decoration: TextDecoration.none,
                fontSize: MediaQuery.of(context).size.width / 50),
          )
        ],
      ));
      if (i % amountWidth == amountWidth - 1 || i == l - 1) {
        widgetsList.add(Container(
          padding: EdgeInsets.fromLTRB(
              0, 0, 0, MediaQuery.of(context).size.height / 12),
          child: LimitedBox(
            maxHeight: MediaQuery.of(context).size.height / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: rowList,
            ),
          ),
        ));
        rowList = [];
      }
    }
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            "assets/images/bluewallpaper.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 10,
              MediaQuery.of(context).size.height / 9,
              MediaQuery.of(context).size.width / 10,
              0),
          child: ListView(
            shrinkWrap: true,
            children: widgetsList,
          ),
        ),
      ],
    );
  }
}
