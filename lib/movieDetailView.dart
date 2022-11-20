import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'package:watchat_ui/design/fontSizes.dart';

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
        ? SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 20,
                MediaQuery.of(context).size.width / 20, 0, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width / 10, 0),
                      child: Hero(
                              tag: widget.tag,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 70),
                                child: Image.network(
                                  widget.imgPath,
                                ),
                              )),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          LimitedBox(
                            maxWidth: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 236, 240, 241),
                                  fontFamily: "Lato",
                                  decoration: TextDecoration.none,
                                  fontSize: FontSizes.normal(context)),
                            ),
                          ),
                          LimitedBox(
                              maxWidth: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                widget.description,
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 236, 240, 241),
                                    fontFamily: "Lato",
                                    decoration: TextDecoration.none,
                                    fontSize:
                                        FontSizes.extraExtraSmall(context)),
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(0,
                                MediaQuery.of(context).size.height / 20, 0, 0),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height / 60),
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
                                      fontSize: FontSizes.extraSmall(context)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))),
        )
        : Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height / 20),
                  child: Hero(
                          tag: widget.tag,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width / 70),
                            child: Image.network(
                              widget.imgPath,
                            ),
                          )),
                ),
                Center(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height / 30),
                  child: LimitedBox(
                      maxWidth: MediaQuery.of(context).size.width / 4 * 3,
                      child: Text(widget.title,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 236, 240, 241),
                              fontFamily: "Lato",
                              decoration: TextDecoration.none,
                              fontSize: FontSizes.normal(context)))),
                )),
                Center(
                  child: LimitedBox(
                      maxWidth: MediaQuery.of(context).size.width / 4 * 3,
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 236, 240, 241),
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: FontSizes.extraExtraSmall(context)),
                      )),
                ),
                Center(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height / 20, 0, 0),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 60),
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
                            fontSize: FontSizes.extraSmall(context)),
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

        Align(
            alignment: Alignment.topRight,
            child: Material(color: Colors.transparent,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: Colors.grey.shade800,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: const EdgeInsets.all(25),
                  iconSize: 80,
                ))),
      ],
    );
  }
}
