import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchat_ui/common/textReqResponse.dart';
import 'package:watchat_ui/common/userVector.dart';
import 'package:watchat_ui/controller/reqController.dart';
import 'package:watchat_ui/design/fontSizes.dart';
import 'package:watchat_ui/movieDetailView.dart';
import 'package:watchat_ui/widgets/chatMessage.dart';

import 'common/movie.dart';

class ChatListView extends StatefulWidget {
  UserVector? userVector;
  Map<String, String> firstQuestions = {
    "What kind of movie would you like to watch?": "Ok, looking into that!",
    "How are you feeling today?":
        "Okay, there are some movies which would match your situation ...",
    "What is your current vibe?": "Maybe there is a movie for that!",
    "What is your favorite color?": "Let me translate that into movies ...",
    "What is your favorite thing to do in your free time?":
        "Cool, then these movies may be interesting ...",
    //"What kind of genre do you like?" :,
    "Give me your favorite song?":
        "Great One! Let me translate that into a movie ...",
    //"Who is the best actor in your opinion?",
    //"What series did you like the most?"
  };

  int count = 0;

  ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with SingleTickerProviderStateMixin {
  List<Widget> childList = [];
  bool greet = false;
  Random random = Random();
  int selectedMovieId = -1;
  final TextEditingController txtController = TextEditingController();
  String hintText = "Insert text here to start getting recommendations...";
  late String firstQuestion;
  bool blocked = false;

  @override
  Widget build(BuildContext context) {
    if (!greet) {
      firstQuestion = widget.firstQuestions.keys
          .toList()[random.nextInt(widget.firstQuestions.length - 1)];
      addChat([
        QuestionText("Hey, welcome!"),
        QuestionText(firstQuestion),
      ]);
      greet = true;
    }

    double inputHeight = FontSizes.flexibleEESmall(context) * 2.7;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: inputHeight),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 17,
                MediaQuery.of(context).size.height / 10,
                MediaQuery.of(context).size.width / 17,
                inputHeight),
            children: childList,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 17,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, sqrt(inputHeight) / 50 + inputHeight * 0.1),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 236, 240, 241),
                      width: MediaQuery.of(context).size.width / 350,
                    ),
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 50,
                    )),
                width: MediaQuery.of(context).size.width / 17 * 10,
                height: inputHeight,
                child: Material(
                  color: Colors.transparent,
                  child: TextField(
                    onSubmitted: (value) {
                      if (blocked) {
                        return;
                      }
                      if (value == "") {
                        setState(() {
                          hintText = "Can't submit empty message ...";
                        });
                        return;
                      }
                      txtController.clear();
                      hintText =
                          "Insert text here to start getting recommendations...";
                      addChat([
                        AnswerField(value),
                        QuestionText(widget.firstQuestions[firstQuestion]!)
                      ]);
                      if (widget.firstQuestions.isNotEmpty) {
                        setState(() {
                          widget.firstQuestions.remove(firstQuestion);
                          blocked = true;
                        });
                        Timer(const Duration(seconds: 3), () {
                          setState(() {
                            blocked = false;
                          });
                        });
                      }
                      getTextResponse(value);
                    },
                    controller: txtController,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 236, 240, 241),
                        fontFamily: "Lato",
                        decoration: TextDecoration.none,
                        fontSize: FontSizes.flexibleEESmall(context)),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 236, 240, 241),
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: FontSizes.flexibleEESmall(context)),
                        filled: true,
                        fillColor: Colors.transparent),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 30),
                width: MediaQuery.of(context).size.width / 17 * 5,
                height: inputHeight,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 236, 240, 241),
                      width: MediaQuery.of(context).size.width / 350,
                    ),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 50),
                    color: Colors.transparent),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 40),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      child: MaterialButton(
                        onPressed: () {
                          getSimilarMovies();
                        },
                        child: Text(
                          selectedMovieId == -1
                              ? "Select for more..."
                              : "More like this one!",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 236, 240, 241),
                              fontFamily: "Lato",
                              decoration: TextDecoration.none,
                              fontSize: FontSizes.flexibleEESmall(context)),
                        ),
                      ),
                    )),
              )
            ],
          ),
        )
      ],
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
    TextReqResponse response = await ReqController.postResponse(
        text: t, preferences: widget.userVector);
    widget.userVector = response.resVector;
    addChat([
      QuestionText(response.question),
      MovieSelector(
          response.movieList,
          MediaQuery.of(context).size.width / 5 * 2,
          MediaQuery.of(context).size.height / 14 * 5,
          setSelectedMovieId,
          getCount)
    ]);
    if (widget.firstQuestions.isEmpty) {
      return;
    }
    firstQuestion = widget.firstQuestions.keys
        .toList()[random.nextInt(widget.firstQuestions.length - 1)];
    addChat([
      QuestionText(firstQuestion),
    ]);
  }

  int getCount() {
    int tmp = widget.count;
    widget.count += 1;
    return tmp;
  }

  void getSimilarMovies() async {
    if (selectedMovieId == -1) {
      return;
    }
    TextReqResponse response = await ReqController.getSimilarMovies(
        movieId: selectedMovieId, preferences: widget.userVector);
    widget.userVector = response.resVector;
    addChat([
      QuestionText(response.question),
      MovieSelector(
          response.movieList,
          MediaQuery.of(context).size.width / 5 * 2,
          MediaQuery.of(context).size.height / 14 * 5,
          setSelectedMovieId,
          getCount)
    ]);
  }

  void setSelectedMovieId(int movieId) {
    setState(() {
      selectedMovieId = movieId;
    });
  }
}

class AnswerField extends StatefulWidget {
  String answerText;

  AnswerField(this.answerText, {super.key});

  @override
  State<AnswerField> createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  final fieldText = TextEditingController();
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    if (!sent) {
      Timer(const Duration(microseconds: 500), () {
        setState(() {
          sent = true;
        });
      });
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        ChatMessage(
          child: Text(
            widget.answerText,
            style: TextStyle(
                color: const Color.fromARGB(255, 236, 240, 241),
                fontFamily: "Lato",
                decoration: TextDecoration.none,
                fontSize: FontSizes.flexibleNormal(context)),
          ),
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
      ]),
    );
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
      child: ChatMessage(
        child: Text(
          widget.questionText,
          style: TextStyle(
              color: const Color.fromARGB(255, 236, 240, 241),
              fontFamily: "Lato",
              decoration: TextDecoration.none,
              fontSize: FontSizes.flexibleNormal(context)),
        ),
      ),
    );
  }
}

class MovieSelector extends StatefulWidget {
  double maxWidth, maxHeight;
  List<Movie> movieList;

  void Function(int) sendSelectedMovie;
  int Function() getCount;

  MovieSelector(this.movieList, this.maxWidth, this.maxHeight,
      this.sendSelectedMovie, this.getCount,
      {super.key});

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
      int num = widget.getCount();
      rowList.add(Container(
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width / 20, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            if (selected == i) {
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
            } else {
              setState(() {
                selected = i;
                widget.sendSelectedMovie(widget.movieList[i].id);
              });
            }
          },
          onDoubleTap: () {
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
                        ? const Color.fromARGB(255, 25, 157, 30)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width / 70)),
            child: LimitedBox(
              maxHeight: widget.maxHeight,
              child: Hero(
                tag: "poster$num",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 70),
                  child: Image.network(
                    "https:${widget.movieList[i].imgPath.split(":")[1]}",
                  ),
                ),
              ),
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

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        children: widgetList,
      ),
    );
  }
}
