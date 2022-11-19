import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:watchat_ui/movieDetailView.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with SingleTickerProviderStateMixin {
  List<Widget> childList = [];
  bool greet = false;

  @override
  Widget build(BuildContext context) {
    if (!greet) {
      addChat([
        QuestionText("Hey, welcome!"),
        AnswerField("")
      ]);
      greet = true;
    }

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 17,
          MediaQuery.of(context).size.height / 10,
          MediaQuery.of(context).size.width / 17,
          0),
      children: childList,
    );
  }

  void addChat(List<Widget> widgets) {
    for (Widget widget in widgets) {
      childList.add(Container(
        padding: EdgeInsets.fromLTRB(
            0, 0, 0, MediaQuery.of(context).size.height / 20),
        child: widget,
      ));
    }
  }
}

class AnswerField extends StatefulWidget {
  String helperText;

  AnswerField(this.helperText, {super.key});

  @override
  State<AnswerField> createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 236, 240, 241),
                width: MediaQuery.of(context).size.width / 350,
              ),
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 70),
              color: Colors.transparent),
          child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                height: MediaQuery.of(context).size.height / 3,
                child: Material(
                  color: Colors.transparent,
                  child: TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 236, 240, 241),
                        fontFamily: "Lato",
                        decoration: TextDecoration.none,
                        fontSize: MediaQuery.of(context).size.width / 30),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.helperText,
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 236, 240, 241),
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: MediaQuery.of(context).size.width / 30),
                        filled: true,
                        fillColor: Colors.transparent),
                  ),
                ),
              )),
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
            fontSize: MediaQuery.of(context).size.width / 30),
      ),
    );
  }
}

class MovieSelector extends StatefulWidget {
  double maxWidth, maxHeight;
  List<String> imagePathList;

  MovieSelector(this.imagePathList, this.maxWidth, this.maxHeight, {super.key});

  @override
  State<MovieSelector> createState() => _MovieSelectorState();
}

class _MovieSelectorState extends State<MovieSelector> {
  int maxImages = 6;
  int imagePerRow = 2;
  List<bool> selectedList = [];
  bool loaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    List<Widget> rowList = [];

    if (widget.imagePathList.length > 3 &&
        widget.imagePathList.length % 2 != 0 &&
        widget.imagePathList.length % 3 != 0) {
      maxImages = widget.imagePathList.length - 1;
    }
    if (widget.imagePathList.length % 3 == 0) {
      imagePerRow = 3;
    }
    for (int i = 0; i < min(widget.imagePathList.length, maxImages); i++) {
      if (!loaded) {
        selectedList.add(false);
      }
      rowList.add(Container(
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width / 20, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedList[i] = !selectedList[i];
            });
          },
          onDoubleTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MovieDetailView(
                    widget.imagePathList[i],
                    "Title",
                    "This is a demo Desciption",
                    widget.imagePathList[i],
                    "poster$i");
              },
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: MediaQuery.of(context).size.width / 300,
                    color: selectedList[i]
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
                    widget.imagePathList[i],
                  ),
                ),
              )),
            ),
          ),
        ),
      ));

      if (i % imagePerRow == imagePerRow - 1 ||
          i == min(widget.imagePathList.length, maxImages) - 1) {
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
                        "More of these!",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 236, 240, 241),
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: MediaQuery.of(context).size.width / 30),
                      ),
                    ),
                  )),
            ))
      ],
    );
  }
}
