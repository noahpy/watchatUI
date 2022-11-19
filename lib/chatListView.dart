import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> childList = [];

    childList.add(QuestionText("Hey, willkommen!"));
    childList.add(MovieSelector(const [
      "https://m.media-amazon.com/images/I/61gtGlalRvL._AC_SY679_.jpg",
      "https://m.media-amazon.com/images/I/51URKHWYfnL._AC_UF894,1000_QL80_.jpg",
    ], MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 4));

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
}

class AnswerField extends StatefulWidget {
  const AnswerField({super.key});

  @override
  State<AnswerField> createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
        child: MaterialButton(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            setState(() {
              selectedList[i] = !selectedList[i];
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: MediaQuery.of(context).size.width / 300,
                    color: selectedList[i] ? Colors.green : Colors.transparent),
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width / 70)),
            child: LimitedBox(
              maxHeight: widget.maxHeight,
              child: Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 70),
                  child: Image.network(
                    widget.imagePathList[i],
                  ),
                ),
              ),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 10,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.blue,
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
