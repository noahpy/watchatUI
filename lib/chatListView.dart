import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:watchat_ui/common/textReqResponse.dart';
import 'package:watchat_ui/common/userVector.dart';
import 'package:watchat_ui/controller/reqController.dart';
import 'package:watchat_ui/design/fontSizes.dart';
import 'package:watchat_ui/movieDetailView.dart';

import 'common/movie.dart';

class ChatListView extends StatefulWidget {
  UserVector? userVector;
  List<String> firstQuestions = [
    "What kind of movie would you like to watch?",
    "How are you feeling today?",
    "What is your current vibe?"
  ];

  ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with SingleTickerProviderStateMixin {
  List<Widget> childList = [];
  bool greet = false;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    if (!greet) {
      addChat([
        QuestionText("Hey, welcome!"),
        QuestionText(widget
            .firstQuestions[random.nextInt(widget.firstQuestions.length - 1)]),
        AnswerField("...", getTextResponse),
      ]);
      greet = true;
    }

    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 17,
          MediaQuery.of(context).size.height / 10,
          MediaQuery.of(context).size.width / 17,
          0),
      children: childList,
    );
  }

  void addChat(List<Widget> widgets) {
    List<Widget> tmp = List.of(childList);
    for (Widget widget in widgets) {
      tmp.add(Container(
        padding: EdgeInsets.fromLTRB(
            0, 0, 0, MediaQuery.of(context).size.height / 20),
        child: widget,
      ));
      setState(() {
        childList = tmp;
      });
    }
  }

  void getTextResponse(String t) async {
    TextReqResponse response = await ReqController.postResponse(text: t, preferences: widget.userVector);
    widget.userVector = response.resVector;
    addChat([
      QuestionText(response.question),
      MovieSelector(
          response.movieList,
          MediaQuery.of(context).size.width / 5 * 2,
          MediaQuery.of(context).size.height / 14 * 5)
    ]);
  }
}

class AnswerField extends StatefulWidget {
  String helperText;
  final void Function(String) f;

  AnswerField(this.helperText, this.f, {super.key});

  @override
  State<AnswerField> createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  final fieldText = TextEditingController();
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 236, 240, 241),
                    width: MediaQuery.of(context).size.width / 350,
                  ),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 70),
                  color: Colors.transparent),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 40),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Material(
                      color: Colors.transparent,
                      child: TextField(
                        readOnly: sent,
                        onSubmitted: (t) {
                          if (t == "") {
                            widget.helperText = "can't submit empty string...";
                            setState(() {});
                            return;
                          }
                          widget.f(t);
                          setState(() {
                            sent = true;
                          });
                        },
                        maxLines: 5,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 236, 240, 241),
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: FontSizes.extraExtraSmall(context)),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.helperText,
                            hintStyle: TextStyle(
                                color: const Color.fromARGB(255, 236, 240, 241),
                                fontFamily: "Lato",
                                decoration: TextDecoration.none,
                                fontSize: FontSizes.extraExtraSmall(context)),
                            filled: true,
                            fillColor: Colors.transparent),
                      ),
                    ),
                  )),
            ),
            Visibility(
                visible: sent,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 100, 0, 0, 0),
                  child: Icon(
                    Icons.done_all,
                    color: const Color.fromARGB(255, 236, 240, 241),
                    size: MediaQuery.of(context).size.width / 60,
                  ),
                )),
          ],
        ));
  }
}

// ignore: must_be_immutable
class QuestionText extends StatefulWidget {
  String questionText;

  QuestionText(this.questionText, {super.key});

  @override
  State<QuestionText> createState() => _QuestionTextState();
}

class _QuestionTextState extends State<QuestionText> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        widget.questionText,
        style: TextStyle(
            color: const Color.fromARGB(255, 236, 240, 241),
            fontFamily: "Lato",
            decoration: TextDecoration.none,
            fontSize: FontSizes.extraSmall(context)),
      ),
    );
  }
}

class MovieSelector extends StatefulWidget {
  double maxWidth, maxHeight;
  List<Movie> movieList;

  MovieSelector(this.movieList, this.maxWidth, this.maxHeight, {super.key});

  @override
  State<MovieSelector> createState() => _MovieSelectorState();
}

class _MovieSelectorState extends State<MovieSelector> {
  int maxImages = 6;
  int imagePerRow = 2;
  int selected = -1;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    List<Widget> rowList = [];

    if (widget.movieList.length > 3 &&
        widget.movieList.length % 2 != 0 &&
        widget.movieList.length % 3 != 0) {
      maxImages = widget.movieList.length - 1;
    }
    if (widget.movieList.length % 3 == 0) {
      imagePerRow = 3;
    }
    for (int i = 0; i < min(widget.movieList.length, maxImages); i++) {
      rowList.add(Container(
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width / 20, 0, 0, 0),
        child: GestureDetector(
          onDoubleTap: () {
            setState(() {
              selected = i;
            });
          },
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MovieDetailView(
                    widget.movieList[i].imgPath,
                    widget.movieList[i].title,
                    widget.movieList[i].description,
                    widget.movieList[i].redirectPath,
                    "poster$i");
              },
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: MediaQuery.of(context).size.width / 300,
                    color: selected == i
                        ? Color.fromARGB(255, 25, 157, 30)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width / 70)),
            child: LimitedBox(
              maxHeight: widget.maxHeight,
              child: Expanded(
                  child: Hero(
                tag: "poster$i",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 70),
                  child: Image.network(
                    "https:${widget.movieList[i].imgPath.split(":")[1]}",
                  ),
                ),
              )),
            ),
          ),
        ),
      ));

      if (i % imagePerRow == imagePerRow - 1 ||
          i == min(widget.movieList.length, maxImages) - 1) {
        widgetList.add(LimitedBox(
          maxWidth: widget.maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: rowList,
          ),
        ));
        rowList = [];
      }
    }

    if (!loaded) {
      loaded = true;
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            children: widgetList,
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 236, 240, 241),
                    width: MediaQuery.of(context).size.width / 350,
                  ),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 70),
                  color: Colors.transparent),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 40),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        selected == -1? "Select with double click...":"More of this!",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 236, 240, 241),
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: FontSizes.extraExtraSmall(context)),
                      ),
                    ),
                  )),
            ))
      ],
    );
  }
}
