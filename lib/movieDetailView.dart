import 'package:flutter/material.dart';
import 'dart:js' as js;

class MovieDetailView extends StatefulWidget {
  String imgPath;
  String title;
  String description;
  String redirectPath;
  String tag;

  MovieDetailView(
      this.imgPath, this.title, this.description, this.redirectPath, this.tag,
      {super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget content = MediaQuery.of(context).size.width >
            MediaQuery.of(context).size.height
        ? Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width / 10, 0),
                      child: Expanded(
                          child: Hero(
                              tag: widget.tag,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 70),
                                child: Image.network(
                                  widget.imgPath,
                                ),
                              ))),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 236, 240, 241),
                                fontFamily: "Lato",
                                decoration: TextDecoration.none,
                                fontSize:
                                    MediaQuery.of(context).size.width / 20),
                          ),
                          Text(
                            widget.description,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 236, 240, 241),
                                fontFamily: "Lato",
                                decoration: TextDecoration.none,
                                fontSize:
                                    MediaQuery.of(context).size.width / 40),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0,
                                MediaQuery.of(context).size.height / 10, 0, 0),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height / 40),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 236, 240, 241),
                                    width: MediaQuery.of(context).size.width /
                                        400),
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 40)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width / 40),
                              child: MaterialButton(
                                onPressed: () {
                                  js.context.callMethod(
                                      'open', [widget.redirectPath]);
                                },
                                child: Text(
                                  "Get me there!",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 236, 240, 241),
                                      fontFamily: "Lato",
                                      decoration: TextDecoration.none,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              40),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )))
        : Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height / 20),
                  child: Expanded(
                      child: Hero(
                          tag: widget.tag,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width / 70),
                            child: Image.network(
                              widget.imgPath,
                            ),
                          ))),
                ),
                Center(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height / 30),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 236, 240, 241),
                        fontFamily: "Lato",
                        decoration: TextDecoration.none,
                        fontSize: MediaQuery.of(context).size.width / 20),
                  ),
                )),
                Center(
                  child: Text(
                    widget.description,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 236, 240, 241),
                        fontFamily: "Lato",
                        decoration: TextDecoration.none,
                        fontSize: MediaQuery.of(context).size.width / 40),
                  ),
                ),
                Center(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height / 10, 0, 0),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 40),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 236, 240, 241),
                          width: MediaQuery.of(context).size.width / 400),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 40)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 40),
                    child: MaterialButton(
                      onPressed: () {
                        js.context.callMethod('open', [widget.redirectPath]);
                      },
                      child: Text(
                        "Get me there!",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 236, 240, 241),
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: MediaQuery.of(context).size.width / 40),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          );

    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            "assets/images/bluewallpaper.png",
            fit: BoxFit.cover,
          ),
        ),
        content,
      ],
    );
  }
}
